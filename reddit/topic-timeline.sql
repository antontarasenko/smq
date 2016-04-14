-- Picking major news on topic (determined by subreddit or keywords in the title) to read how events unfold over time
select *
from
  (
  select
    id, title, created_utc, url, score, num_comments, subreddit,
    year(sec_to_timestamp(created_utc)) year,
    week(sec_to_timestamp(created_utc)) week,
    rank() over (order by score desc) as rank_total,
    rank() over (partition by year, week order by score desc) as rank_year_week
  from
    [fh-bigquery:reddit_posts.full_corpus_201512]
  where
    id is not null and
    score >= 0 and
    subreddit = 'worldnews'
    # title contains 'your term'
  order by
    score desc
  )
where rank_year_week = 1
order by
   year, week, score desc
ignore case
