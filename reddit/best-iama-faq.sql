-- Sum up scores for querstion-answer pairs in IAmA sessions and show 100 best pairs
-- TODO JOIN multiple tables of Reddit comments (TABLE_QUERY works only in FROM)
SELECT
  q.body question,
  a.body answer,
  (q.score + a.score) sum_score
FROM
  (TABLE_QUERY([fh-bigquery:reddit_comments], "table_id BETWEEN '2007' AND '2014' OR table_id CONTAINS '2015_' OR table_id CONTAINS '2016_'")) q
LEFT JOIN EACH
  (TABLE_QUERY([fh-bigquery:reddit_comments], "table_id BETWEEN '2007' AND '2014' OR table_id CONTAINS '2015_' OR table_id CONTAINS '2016_'")) a
    ON a.parent=q.id
WHERE
  subreddit IN ("IAmA") AND
  a.parent IS NOT NULL AND
  q.id IS NOT NULL AND
  a.id IS NOT NULL
ORDER BY
  sum_score DESC
LIMIT
  100
