SELECT
  CONCAT('http://imdb.com/title/tt', REGEXP_EXTRACT(url, r'imdb.com/title/tt([0-9]+)')) AS link,
  SUM(score) as sum_score,
  COUNT(1) AS cnt
FROM
  [fh-bigquery:hackernews.full_201510]
WHERE
  type = 'story' AND
  url CONTAINS 'imdb.com/title/'
GROUP BY
  link
HAVING
  link IS NOT NULL
ORDER BY
  sum_score DESC
LIMIT
  100
