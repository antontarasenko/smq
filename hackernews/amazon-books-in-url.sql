SELECT
  CONCAT('http://amazon.com/', REGEXP_EXTRACT(url, r'amazon.com/([^ \"]+/dp/[0-9]+)')) AS link,
  SUM(score) as sum_score,
  COUNT(1) AS cnt
FROM
  [fh-bigquery:hackernews.full_201510]
WHERE
  url CONTAINS 'amazon.com' AND type = 'story'
GROUP BY
  link
HAVING
  link IS NOT NULL
ORDER BY
  sum_score DESC
LIMIT
  100
