select *
from
  (
  select
    id, title, created_utc, url, score, num_comments, subreddit,
    year(sec_to_timestamp(created_utc)) year,
    rank() over (order by score desc) as rank_total,
    rank() over (partition by year order by score desc) as rank_year
  from
    [fh-bigquery:reddit_posts.full_corpus_201512]
  where
    id is not null and
    score >= 0
  order by
    score desc
  )
where rank_year <= 10
order by
   year, score desc
