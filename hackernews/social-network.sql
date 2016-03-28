-- This is a directed graph. Weights are based on "X comments Y" relationship.
-- Modify `LIMIT` and `HAVING` if you want to build a complete graph in Gephi, networkx, or elsewhere.
SELECT
  [tx.by] x,
  [ty.by] y,
  COUNT(1) weight
FROM
  [fh-bigquery:hackernews.full_201510] tx
LEFT JOIN EACH [fh-bigquery:hackernews.full_201510] ty ON ty.id=tx.parent
WHERE
  [tx.by] IS NOT NULL AND
  [ty.by] IS NOT NULL AND
  tx.parent IS NOT NULL AND
  [tx.by] != [ty.by]
GROUP BY
  x, y
HAVING
  weight >= 5
ORDER BY
  weight DESC
LIMIT
  100