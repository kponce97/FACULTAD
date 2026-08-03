import scala.io.Source
import scala.util.{Try, Using}
import org.json4s._
import org.json4s.jackson.JsonMethods._
import org.json4s.DefaultFormats
import java.time.{Instant, ZoneId}
import java.time.format.DateTimeFormatter

object FileIO {

  type Subscription = (String, String)

  type Post = (
      String,
      String,
      String,
      String,
      Int,
      String
  ) // (Subreddit, Title, selftext, created_utc, score, permalink)

  // Pure function to format UTC timestamp to human-readable date string
  def formatDateFromUTC(utcSeconds: Long): String = {
    val instant = Instant.ofEpochSecond(utcSeconds)
    val formatter = DateTimeFormatter
      .ofPattern("yyyy-MM-dd HH:mm:ss")
      .withZone(ZoneId.systemDefault())
    formatter.format(instant)
  }

  // Pure function to read subscriptions from a JSON file
  def readSubscriptions(): Option[List[Subscription]] = {
    val result: Try[List[Subscription]] =
      Using(Source.fromFile("subscriptions.json")) { source =>
        val jsonString = source.mkString

        val regex = """\{\s*"name":\s*"([^"]+)",\s*"url":\s*"([^"]+)"\s*\}""".r

        regex
          .findAllMatchIn(jsonString)
          .map { m =>
            (m.group(1), m.group(2))
          }
          .toList
      }

    result.toOption
  }

  def downloadPosts(subscriptions: List[Subscription]): Option[List[Post]] = {
    implicit val formats: Formats = DefaultFormats
    val posts: List[Post] = subscriptions.flatMap { case (name, url) =>
      Try {
        val jsonString = Source.fromURL(url).mkString
        val json = parse(jsonString)
        val children = (json \ "data" \ "children").children

        children.map { child =>
          val data = child \ "data"
          (
            (data \ "subreddit").extractOrElse[String](""),
            (data \ "title").extractOrElse[String](""),
            (data \ "selftext").extractOrElse[String](""),
            formatDateFromUTC(
              (data \ "created_utc").extractOrElse[Double](0.0).toLong
            ),
            (data \ "score").extractOrElse[Int](0),
            (data \ "permalink").extractOrElse[String]("")
          )
        }
      }.getOrElse(Nil)
    }

    Some(posts)
  }
}
