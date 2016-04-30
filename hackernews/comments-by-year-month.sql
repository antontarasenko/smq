-- Summary stats for comments by year and month
select
  # group

  year(sec_to_timestamp(t.time)) year,
  month(sec_to_timestamp(t.time)) month,
  count(*) n,

  # stats: commenters

  avg(t.time - st.first_time) avg_tenure,
  avg((t.time - st.first_time) < 31536000) pct_under_year,
  avg(if(st.first_time > 0, 0, 1)) pct_first_submission,
  count(unique(t.by)) n_unique_authors,
  count(unique(t.by))/count(*) diversity_index,

  # stats: submissions

  avg(length(t.title)) length_title,
  avg(length(t.text)) length_text,
  avg(if(t.deleted = true, 1, 0)) pct_submissions_deleted,
  avg(if(t.dead = true, 1, 0)) pct_submissions_dead,

  sum(t.score) sum_score,
  avg(t.score) avg_score,
  stddev(t.score) stddev_score,
  min(t.score) min_score,
  nth(11, quantiles(t.score, 21)) median_score,
  max(t.score) max_score,

  sum(t.descendants) sum_descendants,
  avg(t.descendants) avg_descendants,
  stddev(t.descendants) stddev_descendants,
  min(t.descendants) min_descendants,
  nth(11, quantiles(t.descendants, 21)) median_descendants,
  max(t.descendants) max_descendants

from
  [fh-bigquery:hackernews.full_201510] t
  left join (
    select
      [by],
      count(*) n_submissions,
      min(time) first_time,
      max(time) last_time,
      avg(if(deleted = true, 1, 0)) pct_author_submissions_deleted,
    from [fh-bigquery:hackernews.full_201510]
    group by [by]
  ) st on st.by = t.by
where
  t.type in ('comment')
group by
  year, month
order by
  year, month
