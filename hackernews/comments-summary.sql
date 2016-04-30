-- Summary stats for all comments
select
  count(*) total_comments,
  count(unique([by])) total_commentators,
  count(if(deleted = true, 1, 0)) deleted,
  count(if(dead = true, 1, 0)) dead,
  count(if(id is null, 1, 0)) null_id,
  avg(length(text)) avg_length_text,
  count(if(text contains '://', 1, 0)) comments_with_links,
  min(sec_to_timestamp(time)) first_comment_date,
  max(sec_to_timestamp(time)) last_comment_date,
from
  [bigquery-public-data:hacker_news.full_201510]
where
  type = 'comment'
ignore case
