SELECT
  [by] author,
  COUNT(1) cnt,
  ROUND(AVG(score)) avg_score,
  CONCAT("https://news.ycombinator.com/submitted?id=", [by]) link,
FROM
  [fh-bigquery:hackernews.full_201510]
WHERE
  type = 'story'
GROUP BY
  author, link
HAVING
  cnt >= 5
ORDER BY
  avg_score DESC
LIMIT
  100