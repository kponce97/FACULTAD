object Formatters {

  private def subredditSlug(url: String): String =
    url
      .split("/")
      .dropWhile(_ != "r")
      .lift(1)
      .getOrElse("")
      .toLowerCase

  private def normalizedKey(value: String): String =
    value.replace(" ", "").toLowerCase

  // Render all subscriptions with their posts and top word frequencies
  def renderSubscriptions(subscriptions: List[FileIO.Subscription], posts: List[FileIO.Post]): String = {
    val header = s"Reddit Post Parser\n${"=" * 40}\n"
    val wordFreq = Frecuencia.word_frequency(posts)

    val renderedSubs = subscriptions.map { case (name, url) =>
      val subredditKey = Option(subredditSlug(url)).filter(_.nonEmpty).getOrElse(normalizedKey(name))
      val postsForSub = posts.filter(post => post._1.toLowerCase == subredditKey)
      
      val topWordsContent = wordFreq
        .getOrElse(subredditKey, wordFreq.getOrElse(name, Map.empty))
        .toList
        .sortBy(-_._2)
        .take(5)
        .foldLeft(List[String]()) { (acc, pair) => s"    ${pair._1}: ${pair._2}" :: acc }
        .reverse
        .mkString("\n")

      
      val totalScore = postsForSub.foldLeft(0) { (acc, post) =>
        acc + post._5  
      }

      val postsContent = postsForSub
        .sortBy(-_._5) 
        .take(5)
        .map { post => s"  - ${post._2}\n    Score: ${post._5}\n    Date: ${post._4}\n    URL: https://reddit.com${post._6}" }
        .mkString("\n\n")

      val postsSection = if (postsContent.nonEmpty) s"Top 5 Posts:\n$postsContent" else "Posts: None"
      val topWordsSection = if (topWordsContent.nonEmpty) s"Top Words:\n$topWordsContent" else "Top Words: None"
      val scoreSection = s"Total Score: $totalScore"

      s"\n${"=" * 80}\nSubreddit: $name\nURL: $url\n${"=" * 80}\n$scoreSection\n\n$postsSection\n\n$topWordsSection"
    }.mkString("\n\n")

    header + renderedSubs
  }

  // Pure function to format posts from a subscription
  def formatSubscription(
      url: String,
      posts: List[FileIO.Post]
  ): String = {
    val header = s"\n${"=" * 80}\nPosts from: $url \n${"=" * 80}"

    val filteredPosts = posts
      .filter { case (_, title, selftext, _, _, _) =>
        val hasTitle = title != null && title.trim.nonEmpty
        val hasContent = selftext != null && selftext.trim.nonEmpty
        hasTitle && hasContent
      }
      .take(80)

    val formattedStrings = filteredPosts.map {
      case (subreddit, title, content, date, score, permalink) =>
        s"Subreddit: $subreddit\nTitle: $title\nScore: $score\nDate: $date\nPermalink: https://reddit.com$permalink\nContent: $content\n${"-" * 40}"
    }

    header + "\n" + formattedStrings.mkString("\n")
  }

}
