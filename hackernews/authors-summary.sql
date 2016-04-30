-- Summary stats by user
-- Specific users:  Replace `<your name>` with your username and run the query.
-- All users:       Execute the "ALL_USERS" query nested in the main query.
-- Comments:        By default, this query returns stats for stories. You can find stats for comments by editing `type in` clause.
select
  *
from
(
  # ALL_USERS
  select
    *,
    # percentiles relative to other authors
    percent_rank() over (order by total_stories asc) percent_rank_total_stories,
    percent_rank() over (order by sum_score asc) percent_rank_sum_score,
    percent_rank() over (order by median_score asc) percent_rank_median_score,
    percent_rank() over (order by avg_score asc) percent_rank_avg_score,
    percent_rank() over (order by sum_comments asc) percent_rank_sum_comments,
    ( sum_score / tenure ) point_earning_speed
  from
  (
    select
      [by] author,
      count(*) total_stories,

      # scores
      sum(score) sum_score,
      avg(score) avg_score,
      stddev(score) stddev_score,
      min(score) min_score,
      nth(11, quantiles(score, 21)) median_score,
      max(score) max_score,

      # comments to the authors submissions
      sum(descendants) sum_comments,
      avg(descendants) avg_comments,
      stddev(descendants) stddev_comments,
      min(descendants) min_comments,
      nth(11, quantiles(descendants, 21)) median_comments,
      max(descendants) max_comments,

      # time spent on HN
      min(time) first_submission_time,
      max(time) last_submission_time,
      ( now()/1e6 - min(time) ) / (60*60*24) tenure,

      # misc
      avg(length(title)) avg_length_title,
    from
      [bigquery-public-data:hacker_news.full_201510]
    where
      type in ('story', 'poll', 'job') and
      # type in ('comment') and
      dead is null and deleted is null and
      id is not null
    group by
      author
    order by
      sum_score desc
  )
  order by
    sum_score desc
)
where
  author in ('<your name>', 'ColinWright', 'dang', 'pg', 'sama')
order by
  author
