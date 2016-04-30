-- Top "Ask HN", excluding monthly "Who is hiring" posts
select
  *
from
  [bigquery-public-data:hacker_news.stories]
where
  dead is null and deleted is null and
  score >= 0 and
  title contains 'ask hn:' and
  not (title contains 'who is hiring')
order by
  score desc
ignore case
