-- this shows that optimal posting time is Sat and Sun, but stats are weak
select
  dayofweek(sec_to_timestamp(time)) dow,
  hour(sec_to_timestamp(time)) hour,
-- TODO use `LN()` to smooth skewed score|descendants
  count(score) count_score,
  sum(score) sum_score,
  avg(score) avg_score,
  stddev(score) stddev_score,
  min(score) min_score,
  nth(11, quantiles(score, 21)) median_score,
  max(score) max_score,
  count(descendants) count_descendants,
  sum(descendants) sum_descendants,
  avg(descendants) avg_descendants,
  stddev(descendants) stddev_descendants,
  min(descendants) min_descendants,
  nth(11, quantiles(descendants, 21)) median_descendants,
  max(descendants) max_descendants,
-- TODO rewrite to `avg(case when (<expr> is null or 0) then 0 else 1 end)`
  avg(cast(deleted as integer)) pct_deleted,
  avg(cast(dead as integer)) pct_dead,
  avg(title contains "show hn:") pct_show_hn,
  avg(title contains "ask hn:") pct_ask_hn,
  avg(title contains "tell hn:") pct_tell_hn
from
  [fh-bigquery:hackernews.full_201510]
where
  type = 'story' and
  id is not null and
  url != '' and
  score >= 0 and
  descendants >= 0 and
  # capture the updated scoring algorithm (post-2011)
  year(sec_to_timestamp(time)) > 2011
group by
  dow, hour
order by
  dow, hour
ignore case;
