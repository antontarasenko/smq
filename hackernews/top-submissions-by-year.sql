select rt.*
from
  (
  select
    title,
    id,
    time,
    url,
    score,
    descendants,
    year(sec_to_timestamp(time)) year,
    rank() over (partition by year(sec_to_timestamp(time)) order by score desc) as rank
  from
    [fh-bigquery:hackernews.full_201510]
  where
    type = 'story' and
    id is not null and
    url != '' and
    score >= 0
  ) rt
where rt.rank <= 10
order by
   rt.year, rt.rank desc
