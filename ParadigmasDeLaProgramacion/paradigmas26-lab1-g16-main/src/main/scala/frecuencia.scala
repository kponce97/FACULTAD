object Frecuencia {
  private val stopwords = Set(
    "the", "about", "above", "after", "again", "against", "all", "am", "an",
    "and", "any", "are", "aren't", "as", "at", "be", "because", "been",
    "before", "being", "below", "between", "both", "but", "by", "can't",
    "cannot", "could", "couldn't", "did", "didn't", "do", "does", "doesn't",
    "doing", "don't", "down", "during", "each", "few", "for", "from", "further",
    "had", "hadn't", "has", "hasn't", "have", "haven't", "having", "he", "he'd",
    "he'll", "he's", "her", "here", "here's", "hers", "herself", "him",
    "himself", "his", "how", "how's", "i", "i'd", "i'll", "i'm", "i've", "if",
    "in", "into", "is", "isn't", "it", "it's", "its", "itself", "let's", "me",
    "more", "most", "mustn't", "my", "myself", "no", "nor", "not", "of", "off",
    "on", "once", "only", "or", "other", "ought", "our", "ours", "ourselves",
    "out", "over", "own", "same", "shan't", "she", "she'd", "she'll", "she's",
    "should", "shouldn't", "so", "some", "such", "than", "that", "that's",
    "the", "their", "theirs", "them", "themselves", "then", "there", "there's",
    "these", "they", "they'd", "they'll", "re", "they've", "this", "those",
    "through", "to", "too", "under", "until", "up", "very", "was", "wasn't",
    "we", "we'd", "we'll", "we're", "we've", "were", "weren't", "what",
    "what's", "when", "when's", "where", "where's", "which", "while", "who",
    "who's", "whom", "why", "why's", "with", "won't", "would",
    "wouldn't", "you", "you'd", "you'll", "you're", "you've", "your", "yours",
    "yourself", "yourselves"
  )


  private def countWordsInText(text: String): Map[String, Int] = {
    text.split("\\W+")
      .filter(_.nonEmpty)
      .filter(_.headOption.exists(_.isUpper))
      .foldLeft(Map.empty[String, Int]) { (acc, word) =>
        acc.updated(word, acc.getOrElse(word, 0) + 1)
      }
  }

  def word_frequency(posts: List[FileIO.Post]): Map[String, Map[String, Int]] = {
    posts
      .groupBy(_._1)
      .map { case (sub, postsInSub) =>
        val freq = postsInSub.foldLeft(Map.empty[String, Int]) { (acc, post) =>
          val wordCounts = countWordsInText(post._3)  // post._3 is selftext
          wordCounts.foldLeft(acc) { case (innerAcc, (word, count)) =>
            if (stopwords.contains(word.toLowerCase)) innerAcc
            else innerAcc.updated(word, innerAcc.getOrElse(word, 0) + count)
          }
        }
        sub -> freq
      }
  }
}
