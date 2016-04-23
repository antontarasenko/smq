-- Most popular links in comments
select
  regexp_extract(text, r'(\w+://[^ <\"]+)') link,
  sum(score) sum_score,
  count(*) count
from
  [fh-bigquery:hackernews.full_201510]
where
  text contains '://' and
  type = 'comment'
group by
  link
having
  link is not null
order by
  count desc
