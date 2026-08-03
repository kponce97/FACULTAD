// =====================================================================
// Ejercicio 6: Integración del sistema completo
// =====================================================================
import Dictionary.loadAll
import Analyzer.detectEntities
import Formatters.formatNERResult
import Formatters.formatEntityStats
import Analyzer.countByType

object Main {
  def main(args: Array[String]): Unit = {
    // ------------------------------------------------------------------
    // Paso 1: Cargar diccionarios
    // ------------------------------------------------------------------
    val dictionary: List[NamedEntity] = loadAll()

    println(s"Diccionario cargado: ${dictionary.size} entidades.\n")

    // ------------------------------------------------------------------
    // Paso 2: Descargar posts
    // ------------------------------------------------------------------
    val subscriptions = FileIO.readSubscriptions()

    val allPosts: List[(String, List[String])] = subscriptions.map { url =>
      println(s"Descargando posts de: $url")
      val json   = FileIO.downloadFeed(url)
      val titles = FileIO.extractPostTitles(json)
      (url, titles)
    }

    // ------------------------------------------------------------------
    // Paso 3: Detectar entidades y mostrar resultados por post
    // ------------------------------------------------------------------

    var allEntities: List[NamedEntity] = List.empty

    allPosts.foreach{ case (url, titles) =>
      titles.foreach{ title =>
        val entities = detectEntities(title, dictionary)
        val formattedOutput = formatNERResult(title, entities)

        allEntities = allEntities ++ entities // Paso 4
        println(formattedOutput)
      }
    }

    // ------------------------------------------------------------------
    // Paso 4: Estadísticas globales
    // ------------------------------------------------------------------

    println(formatEntityStats(countByType(allEntities)) ++ "\n")

  }
}
