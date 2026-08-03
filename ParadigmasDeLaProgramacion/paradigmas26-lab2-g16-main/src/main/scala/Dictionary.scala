
/**
 * Responsable de cargar colecciones de entidades nombradas desde archivos.
 *
 * Un diccionario es un archivo de texto plano donde cada línea contiene
 * el nombre de una entidad conocida del mismo tipo.
 *
 * Ejemplo — data/people.txt:
 *   Martin Odersky
 *   Alan Turing
 *   Ada Lovelace
 *
 * Ejemplo — data/languages.txt:
 *   Scala
 *   Python
 *   Haskell
 */
object Dictionary {

  /** Lee un archivo de diccionario y crea una lista de entidades del tipo
    * indicado.
    *
    * @param filePath
    *   ruta al archivo de diccionario (ej: "data/people.txt")
    * @param entityType
    *   tipo de entidad: "Person", "University", "ProgrammingLanguage", etc.
    * @return
    *   lista de NamedEntity del tipo correspondiente
    *
    */

  def loadFromFile(filePath: String, entityType: String): Option[List[NamedEntity]] = {
    try {
      val entities = scala.collection.mutable.ListBuffer[NamedEntity]()
      scala.io.Source.fromFile(filePath).getLines().foreach { line =>
        if (line.trim.nonEmpty && !line.trim.startsWith("#")) {
          entityType match {
            case "people"       => entities += new Person(line.trim)
            case "universities" => entities += new University(line.trim)
            case "languages" => entities += new ProgrammingLanguage(line.trim)
            case "places"    => entities += new Place(line.trim)
            case "organizations" => entities += new Organization(line.trim)
            case "technologies"  => entities += new Technology(line.trim)
            case _ => println(s"Tipo de entidad desconocido: $entityType")
          }
        }
      }
      Some(entities.toList)
    } catch {
      case _: java.io.FileNotFoundException =>
        println(s"Archivo no encontrado: $filePath")
        None
      case _: java.io.IOException =>
        println(s"Error de lectura: $filePath")
        None
      case e: Exception =>
        println(s"Error inesperado: ${e.getMessage}")
        None
    }
  }

  /** Carga todos los diccionarios disponibles y combina sus entidades.
    *
    * @return
    *   lista con todas las entidades de todos los diccionarios
    */
  def loadAll(): List[NamedEntity] = {
    try {
      val dataDir = new java.io.File("data")
      if (!dataDir.exists() || !dataDir.isDirectory) {
        println("Directorio 'data' no encontrado o no es un directorio")
        return Nil
      }

      val paths = dataDir.listFiles.filter(_.getName.endsWith(".txt"))
      val dictionaries = scala.collection.mutable.ListBuffer[NamedEntity]()
      paths.foreach { filePath =>
        val fileName = filePath.getName()
        val entityType = fileName.substring(0, fileName.lastIndexOf("."))
        loadFromFile(filePath.toPath().toString(), entityType).foreach {
          entities =>
            dictionaries ++= entities
        }
      }
      dictionaries.toList
    } catch {
      case _: java.io.FileNotFoundException =>
        println("Directorio data no encontrado")
        Nil
      case _: SecurityException =>
        println("Sin permisos para leer el directorio data")
        Nil
      case e: Exception =>
        println(s"Error inesperado: ${e.getMessage}")
        Nil
    }
  }
}
