-- Summary stats for all story-type posts
select
  count(*) total_stories,
  sum(descendants) total_comments,
  count(unique([by])) total_authors,
  sum(if(title contains 'show hn:', 1, 0)) show_hn,
  sum(if(title contains 'ask hn:', 1, 0)) ask_hn,
  sum(if(title contains 'tell hn:', 1, 0)) tell_hn,
  sum(if(title contains 'apply hn:', 1, 0)) apply_hn,
  sum(if(title contains 'offer hn:', 1, 0)) offer_hn,
  sum(if(deleted = true, 1, 0)) deleted,
  sum(if(dead = true, 1, 0)) dead,
  sum(if(id is null, 1, 0)) null_id,
  sum(if(length(text) = 0, 1, 0)) no_text,
  sum(if(url = '', 1, 0)) no_url,
  min(sec_to_timestamp(time)) first_post_date,
  max(sec_to_timestamp(time)) last_post_date,
from
  [bigquery-public-data:hacker_news.stories]
ignore case
