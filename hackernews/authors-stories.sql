-- Getting all of the author's stories
-- Replace `ColinWright` with any username. (ColinWright is the all-time top poster.)
select
  *,
  rank() over (partition by [by] order by score desc) rank
from
  [bigquery-public-data:hacker_news.stories]
where
  dead is null and deleted is null and
  score >= 0 and
  [by] in ('ColinWright')
order by
  [by], rank
