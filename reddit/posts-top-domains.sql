-- Sources of major news. Change `subreddit` for topical news.
SELECT
  DOMAIN(url) domain,
  COUNT(1) cnt
FROM
  [fh-bigquery:reddit_posts.full_corpus_201512]
WHERE
  score > 1000 AND
  subreddit = 'politics'
GROUP BY
  domain
ORDER BY
  cnt DESC
LIMIT
  100