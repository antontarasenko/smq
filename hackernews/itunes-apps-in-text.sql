-- iTunes apps mentioned in text
SELECT
  CONCAT('https://itunes.apple.com/app/id=', REGEXP_EXTRACT(text, r'itunes.apple.com/app/id([0-9]+)')) AS link,
  COUNT(1) AS cnt
FROM
  [fh-bigquery:hackernews.full_201510]
WHERE
  text CONTAINS 'itunes.apple.com'
GROUP BY
  link
HAVING
  link IS NOT NULL
ORDER BY
  cnt DESC
LIMIT
  100
