select
  first(title) first_title,
  first(id) first_id,
  first(time) first_time,
  url,
  count(url) count_url,
  sum(score) sum_score,
  sum(descendants) sum_descendants
from
  [fh-bigquery:hackernews.full_201510]
where
  type = 'story' and
  id is not null and
  url != '' and
  score >= 0
group by
  url
order by
  sum_score desc
