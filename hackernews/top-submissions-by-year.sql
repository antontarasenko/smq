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
    rank() over (order by score desc) as total_rank,
    rank() over (partition by year order by score desc) as year_rank
  from
    [fh-bigquery:hackernews.full_201510]
  where
    type = 'story' and
    id is not null and
    url != '' and
    score >= 0
  order by
    score desc
  ) rt
where rt.year_rank <= 10
order by
   rt.year, rt.score desc
