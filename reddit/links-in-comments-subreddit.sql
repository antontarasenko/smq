-- Most popular links in comments
-- Set subreddit in `where` clause.
select
  regexp_extract(body, r'(\w+://[^\s<\"\),]+)') link,
  sum(score) sum_score,
  count(*) count_rows
from
  [fh-bigquery:reddit_comments.2014]
  # OR use this data-intensive query to search through all comments:
  # (table_query([fh-bigquery:reddit_comments], "table_id between '2007' and '2014' or table_id contains '2015_' or table_id contains '2016_'"))
where
  subreddit = 'productivity' and
  body contains '://'
group by
  link
having
  link is not null
order by
  count_rows desc
ignore case