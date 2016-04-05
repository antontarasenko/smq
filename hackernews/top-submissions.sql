select
  url,
  count(url) count_url,
  sum(score) sum_score
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
