SELECT
  author,
  COUNT(1) cnt,
  NTH(11, QUANTILES(score, 21)) median_score,
FROM
  [fh-bigquery:reddit_posts.full_corpus_201512]
GROUP BY
  author
HAVING
  cnt >= 25
ORDER BY
  median_score DESC
LIMIT
  100
