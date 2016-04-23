-- Picking major news on topic (change `<your term>`) to read how events unfold over time
select *
from
  (
  select
    id, title, time, url, score, descendants,
    year(sec_to_timestamp(time)) year,
    week(sec_to_timestamp(time)) week,
    rank() over (order by score desc) as rank_total,
    rank() over (partition by year, week order by score desc) as rank_year_week
  from
    [fh-bigquery:hackernews.full_201510]
  where
    id is not null and
    score >= 0 and
    type = 'story' and
    title contains '<your term>'
  order by
    score desc
  )
where
  rank_year_week = 1
order by
  year, week, score desc
ignore case
