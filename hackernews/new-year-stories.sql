SELECT
  id, url, score, title,
  MONTH(SEC_TO_TIMESTAMP(time)) AS month,
  DAY(SEC_TO_TIMESTAMP(time)) AS day
FROM
  [fh-bigquery:hackernews.full_201510]
WHERE
  type = 'story'
HAVING
  month = 1 AND
  day = 1
ORDER BY
  score DESC
LIMIT
  100