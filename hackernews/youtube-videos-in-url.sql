-- JSON info for each video http://www.youtube.com/oembed?url=http://www.youtube.com/watch?v=<ID>&format=json
SELECT
  CONCAT('http://www.youtube.com/watch?v=', REGEXP_EXTRACT(url, r'youtube.com/watch\?v=([^ \"\&]+)')) AS link,
  SUM(score) as sum_score,
  COUNT(1) AS cnt
FROM
  [fh-bigquery:hackernews.full_201510]
WHERE
  type = 'story' AND
  url CONTAINS 'youtube.com/watch'
GROUP BY
  link
HAVING
  link IS NOT NULL
ORDER BY
  sum_score DESC
LIMIT
  100
