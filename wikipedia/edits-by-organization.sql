-- Change REGEXP_MATCH for IP patterns
SELECT
  title,
  COUNT(1) cnt
FROM
  [bigquery-public-data:samples.wikipedia]
WHERE
  reversion_id IS NOT NULL AND
  REGEXP_MATCH(contributor_ip, r'8\.8\.[0-9]+\.[0-9]+')
GROUP BY
  title
ORDER BY
  cnt DESC
LIMIT
  100
