-- iTunes apps submitted to Hacker News
SELECT
  CONCAT('https://itunes.apple.com/app/id', REGEXP_EXTRACT(url, r'itunes.apple.com/app/id([0-9]+)')) AS link,
  SUM(score) as sum_score,
  COUNT(1) AS cnt
FROM
  [fh-bigquery:hackernews.full_201510]
WHERE
  url CONTAINS 'itunes.apple.com/app/' AND type = 'story'
GROUP BY
  link
HAVING
  link IS NOT NULL
ORDER BY
  sum_score DESC
LIMIT
  100
