-- Who dropped most f-words on HN?
SELECT
  [by] author,
  COUNT(1) cnt
FROM
  [fh-bigquery:hackernews.full_201510]
WHERE
  text CONTAINS 'fuck'
GROUP BY
  author
ORDER BY
  cnt DESC
LIMIT
  100
IGNORE CASE
