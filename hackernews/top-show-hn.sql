-- List of "Show HN" submissions
SELECT
  id, title, url, score, time, descendants comments, [by] author
FROM
  [fh-bigquery:hackernews.full_201510]
WHERE
  type = 'story' AND
  id is not null AND
  url != '' AND
  title CONTAINS 'Show HN:'
ORDER BY
  score DESC
IGNORE CASE
