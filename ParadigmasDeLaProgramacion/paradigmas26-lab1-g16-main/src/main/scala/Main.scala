import FileIO._

object Main {
  def main(args: Array[String]): Unit = {
    val header = s"Reddit Post Parser\n${"=" * 40}"

    val subscriptions = FileIO.readSubscriptions().getOrElse(Nil)

    val allPosts = FileIO.downloadPosts(subscriptions).getOrElse(Nil)

    val output = Formatters.renderSubscriptions(subscriptions, allPosts)

    println(output)
  }
}
