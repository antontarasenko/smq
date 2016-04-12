select *
from
  (
  select
    id, title, time, url, score, descendants comments,
    year(sec_to_timestamp(time)) year,
    rank() over (order by score desc) as rank_total,
    rank() over (partition by year order by score desc) as rank_year
  from
    [fh-bigquery:hackernews.full_201510]
  where
    type = 'story' and
    id is not null and
    url != '' and
    score >= 0
  order by
    score desc
  )
where rank_year <= 10
order by
   year, score desc
