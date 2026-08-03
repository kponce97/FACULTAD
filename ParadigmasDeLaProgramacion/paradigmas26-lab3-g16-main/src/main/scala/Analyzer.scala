import org.apache.spark.rdd.RDD

object Analyzer {

  /**
   * Filter out empty or irrelevant posts.
   * Discards posts where title is empty/null, selftext is empty/null/whitespace.
   * @param posts list of posts to filter
   * @return filtered list of valid posts
   */
  def filterEmptyPosts(posts: List[Post]): List[Post] = {
    posts.filter { post =>
      post.title.nonEmpty &&
      post.selftext.nonEmpty &&
      post.selftext.trim.nonEmpty
    }
  }

  /**
   * Detect entities from dictionary that appear in the given text.
   * Matching is case-insensitive, whole-word only (no partial matches).
   * "Java" does not match "javascript"; "Scala" does not match "ScalaTest".
   * @param text text to search (e.g., post title or content)
   * @param dictionary list of known entities to match against
   * @return list of entities found in text (can include duplicates)
   */
  def detectEntities(text: String, dictionary: List[NamedEntity]): List[NamedEntity] = {
    val words = text.toLowerCase.split("\\s+").toSet
    dictionary.filter { entity =>
      words.contains(entity.text.toLowerCase)
    }
  }

  /**
   * Count occurrences of each entity (grouped by type and name).
   * @param entities list of detected entities
   * @return map from (entityType, entityName) to count
   */
  def countEntities(entities: List[NamedEntity]): Map[(String, String), Int] = {
    entities
      .groupBy(entity => (entity.entityType, entity.text))
      .view
      .mapValues(_.size)
      .toMap
  }

  /**
   * Count total entities and entities by type.
   * @param entities list of detected entities
   * @return map with "total" key and one key per entity type
   */
  def countByType(entities: List[NamedEntity]): Map[String, Int] = {
    val byType = entities.groupBy(_.entityType).view.mapValues(_.size).toMap
    byType + ("total" -> entities.size)
  }

  def detectAndCountEntities(
    posts: RDD[Post],
    dictionary: List[NamedEntity]
  ): Array[((String, String), Int)] = {
    posts
      // Ejercicio 3 - inciso a): extraer entidades nombradas de cada post con flatMap.
      .flatMap { post =>
        val text = s"${post.title} ${post.selftext}"
        detectEntities(text, dictionary)
      }
      // Ejercicio 3 - inciso b): convertir cada entidad en ((tipo, nombre), 1).
      .map(entity => ((entity.entityType, entity.text), 1))
      // Ejercicio 3 - inciso c): sumar las apariciones por clave con reduceByKey.
      .reduceByKey(_ + _)
      .collect()
  }


  // Ejercicio 3 - inciso d): ordenar e imprimir con formato [TIPO] Entidad: N apariciones.
  def computeTypeStats(
    entityCounts: Array[((String, String), Int)]
  ): Map[String, Int] = {
    val totalEntities = entityCounts.map { case (_, count) => count }.sum
    entityCounts
      .groupBy { case ((entityType, _), _) => entityType }
      .map { case (entityType, list) =>
        val total = list.map { case (_, count) => count }.sum
        (entityType, total)
      } + ("total" -> totalEntities)
  }
}
