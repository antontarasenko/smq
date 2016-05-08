-- Sources of major news. Change `subreddit` for topical news.
select
  domain(url) domain,
  sum(score) sum_score,
  count(1) count_rows
from
  [fh-bigquery:reddit_posts.2016_02]
where
  subreddit = 'shutupandtakemymoney'
group by
  domain
order by
  count_rows desc
