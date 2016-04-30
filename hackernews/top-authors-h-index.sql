-- h-index of HN users: accounts for both quality and quantity of submissions
select
  author, count(*) h_index
from (
  select
    [by] author, score, rank() over (partition by author order by score desc) item_rank
  from
    [fh-bigquery:hackernews.full_201510]
  where
    type in ('story', 'job', 'poll') and
    id is not null and
    score >= 0
)
where
  score >= item_rank
group by
  author
order by
  h_index desc
