SELECT
  url,
  SUM(score) AS sum_score,
  COUNT(1) AS cnt
FROM
  [fh-bigquery:hackernews.full_201510]
WHERE
  url CONTAINS 'wikipedia.org/wiki/'
GROUP BY
  url
ORDER BY
  sum_score DESC
LIMIT
  100