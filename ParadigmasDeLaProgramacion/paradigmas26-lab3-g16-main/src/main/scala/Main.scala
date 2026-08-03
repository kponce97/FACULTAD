import org.apache.spark.sql.SparkSession
import org.apache.spark.rdd.RDD

object Main {
  def main(args: Array[String]): Unit = {
    // Tiempo total de inicio - EJERCICIO 4
    val inicioTotal = System.currentTimeMillis()
    
    println("\n" + "=" * 60)
    println("PROCESAMIENTO DE REDDIT NER - INICIO")
    println("=" * 60)
    println()
    
    // Parse command-line arguments
    val cmdArgs = CommandLineArgs.parse(args) match {
      case Some(parsed) => parsed
      case None         => return // scopt prints error messages
    }
    
    // Inicio la SparkSession
    val spark = SparkSession
      .builder()
      .appName("RedditNER")
      .master("local[*]")
      .getOrCreate()
    val sc = spark.sparkContext

    sc.setLogLevel("ERROR")
    
    // Load subscriptions
    val subscriptionOpts = FileIO.readSubscriptions(cmdArgs.subscriptionFile)

    // Filter out malformed subscriptions (None values)
    val subscriptions = subscriptionOpts.flatten.flatMap { subscription =>
      val validName =
        subscription.name != null && subscription.name.trim.nonEmpty
      val validUrl = subscription.url != null && subscription.url.trim.nonEmpty

      // Caso: Si un subscription no se puede parsear porque le falta el campo name o url - Ejercicio 2 - Caso de Error
      if (!validName || !validUrl) {
        println(
          "Warning:Skipping malformed subscription (missing 'name' or 'url' field)"
        )
        None
      } else {
        Some(subscription)
      }
    }
    
    // Caso: Si no hay suscripciones para procesar - Ejercicio 2 - Caso de Error
    if (subscriptions.isEmpty) {
      println("Error: No valid subscriptions found")
      spark.stop()
      return
    }
    
    // Ejercicio 2 - inciso a)
    val rdd = sc.parallelize(subscriptions)

    // Inicialización de Acumuladores Ejercicio 4/Ejercicio 2 - inciso c)
    val accFeedsSuccess = sc.longAccumulator("Feeds Success")
    val accFeedsFailed = sc.longAccumulator("Feeds Failed")
    val accPostSuccess = sc.longAccumulator("Post Success")
    val accPostFailed = sc.longAccumulator("Post Failed")

    // ==================== EJERCICIO 4 - MEDICIÓN DESCARGA ====================
    val inicioDescarga = System.currentTimeMillis()
    
    // EJERCICIO 5 - inciso b) .cache() para evitar recomputación
    // Download feeds and parse posts, tracking success/failure - Ejercicio 2 - inciso b)
    val downloadResults: RDD[Post] = rdd.flatMap { subscription =>
      val feedOpt: Option[String] = try {
        val download = FileIO.downloadFeed(subscription.url)
        accFeedsSuccess.add(1)
        download
      } catch {
        case _: Exception =>
          println(
            s"Warning: Failed to download from '${subscription.name}' (${subscription.url})"
          )
          accFeedsFailed.add(1)
          None
      }
      val posts =
        feedOpt.fold(List[Post]()) { feed =>
          try { JsonParser.parsePosts(feed, subscription.name) }
          catch {
            case _: Exception =>
              println(
                s"Warning: Failed to parse posts from '${subscription.name}'(${subscription.url})"
              )
              List.empty[Post]
          }
        }

      val postsValidos = Analyzer.filterEmptyPosts(posts)

      accPostSuccess.add(posts.length)
      accPostFailed.add(posts.length - postsValidos.length)

      postsValidos
    }.cache()  // EJERCICIO 5 - inciso b): Cache para que no se recompute

    // EJERCICIO 5 - inciso a): Sin cache(), acá se recomputaría toda la descarga
    // Esta primera acción materializa el cache
    val downloadResultsCollect = downloadResults.collect()
    
    // EJERCICIO 4 - Mostrar tiempo de descarga
    val tiempoDescarga = (System.currentTimeMillis() - inicioDescarga) / 1000.0
    
    println()
    println("=" * 60)
    println("MÉTRICAS DE TIEMPO")
    println("=" * 60)
    println(f"  • Tiempo de descarga y filtrado: $tiempoDescarga%.2f segundos")
    println()
    
    // Ejercicio 2 - inciso d)
    if (downloadResultsCollect.isEmpty) {
      println("Error: No valid posts downloaded after filtering")
      // EJERCICIO 5 - inciso c): unpersist antes de salir por error
      downloadResults.unpersist()
      spark.stop()
      return
    }

    // Calculo el promedio de caracteres sobre los posts validos locales
    // EJERCICIO 5 - inciso a): Esta operación usa downloadResultsCollect (ya en driver)
    // No fuerza recomputación porque los datos ya están en el driver
    val totalChars = downloadResultsCollect
      .map(post => post.title.length + post.selftext.length)
      .sum
    val avgChars =
      if (downloadResultsCollect.nonEmpty)
        totalChars / downloadResultsCollect.length
      else 0

    // Ejercicio 2 - inciso c)
    val stats = Map(
      "feedsSuccess" -> accFeedsSuccess.value.toInt,
      "feedsFailed" -> accFeedsFailed.value.toInt,
      "postsSuccess" -> accPostSuccess.value.toInt,
      "postsFiltered" -> accPostFailed.value.toInt,
      "avgChars" -> avgChars
    )

    println("=" * 60)
    println(Formatters.formatProcessingStats(stats))
    println("=" * 60)
    println()

    // Load dictionaries
    val dictionary = Dictionary.loadAll(cmdArgs.entitiesDir)

    // ==================== EJERCICIO 4 - MEDICIÓN NER ====================
    val inicioNER = System.currentTimeMillis()
    
    // EJERCICIO 5 - inciso a): Sin cache(), acá se recomputaría TODO otra vez
    // Con cache(), usa los datos ya materializados en memoria
    val entityCounts = downloadResults
      .flatMap { post =>
        val text = s"${post.title} ${post.selftext}"
        Analyzer.detectEntities(text, dictionary)
      }
      .map(entity => ((entity.entityType, entity.text), 1))
      .reduceByKey(_ + _)
      .collect()
    
    // EJERCICIO 4 - Mostrar tiempo de procesamiento NER
    val tiempoNER = (System.currentTimeMillis() - inicioNER) / 1000.0
    println(f"  • Tiempo de procesamiento NER: $tiempoNER%.2f segundos")
    println()

    // EJERCICIO 5 - inciso c): Ya no necesitamos downloadResults, liberamos memoria
    downloadResults.unpersist()

    val totalEntities = entityCounts.map { case (_, count) => count }.sum

    // Ejercicio 3 - inciso d)
    println("=" * 60)
    println(Formatters.formatTypeStats(
      entityCounts
        .groupBy { case ((entityType, _), _) => entityType }
        .map { case (entityType, list) =>
          val total = list.map { case (_, count) => count }.sum
          (entityType, total)
        } + ("total" -> totalEntities)
    ))
    println("=" * 60)
    println()
    
    println("=" * 60)
    println(Formatters.formatEntityStats(
      entityCounts.toMap,
      topK = cmdArgs.topK
    ))
    println("=" * 60)
    
    // ==================== EJERCICIO 4 - TIEMPO TOTAL ====================
    val tiempoTotal = (System.currentTimeMillis() - inicioTotal) / 1000.0
    
    println()
    println("=" * 60)
    println(" RESUMEN FINAL")
    println("=" * 60)
    println(f"  • Tiempo total de ejecución: $tiempoTotal%.2f segundos")
    println()
    println("=" * 60)
    println("PROCESAMIENTO FINALIZADO")
    println("=" * 60)
    println()
    
    spark.stop()
  }
}