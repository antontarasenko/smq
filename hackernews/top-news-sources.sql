-- Most popular news sources averaged by day of week and hour.
-- Remove (dow, hour) pairs for a simple ranking.
SELECT
  DOMAIN(url) domain,
  HOUR(SEC_TO_TIMESTAMP(time)) hour,
  DAYOFWEEK(SEC_TO_TIMESTAMP(time)) dow,
  NTH(11, QUANTILES(score, 21)) median_score,
  AVG(score) avg_score,
  COUNT(url) cnt
FROM
  [fh-bigquery:hackernews.full_201510]
WHERE
  score > 0 AND
  type = "story"
GROUP BY
  domain, dow, hour
HAVING
  cnt > 100 AND
  domain IS NOT NULL
ORDER BY
  cnt DESC
