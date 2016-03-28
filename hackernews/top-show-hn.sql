-- List of "Show HN" submissions
SELECT
  title, url, score
FROM
  [fh-bigquery:hackernews.full_201510]
WHERE
  text CONTAINS 'Show HN:'
ORDER BY
  score DESC
LIMIT
  1000
IGNORE CASE
