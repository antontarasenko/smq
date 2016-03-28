SELECT
  CONCAT('http://amazon.com/', REGEXP_EXTRACT(text, r'amazon.com/([^ \"]+/dp/[0-9]+)')) AS link,
  SUM(score) as sum_score,
  COUNT(1) AS cnt
FROM
  [fh-bigquery:hackernews.full_201510]
WHERE
  text CONTAINS 'amazon.com'
GROUP BY
  link
HAVING
  link IS NOT NULL
ORDER BY
  cnt DESC
LIMIT
  100
