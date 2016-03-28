-- Authors with a high median score tend to be founders and VCs.
-- Also the high median indicates fewer low-quality submissions by the user.
-- See also: `top-authors-mean.sql`
SELECT
  [by] author,
  COUNT(1) cnt,
  NTH(11, QUANTILES(score, 21)) median_score,
  CONCAT("https://news.ycombinator.com/user?id=", [by]) link,
FROM
  [fh-bigquery:hackernews.full_201510]
WHERE
  type = 'story'
GROUP BY
  author, link
HAVING
  cnt >= 10
ORDER BY
  median_score DESC
LIMIT
  100