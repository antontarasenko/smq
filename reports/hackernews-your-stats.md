# Your Hacker News Stats

* *This is part of the [SMQ](../README.md) project*
* *More HN materials are available in [`reports`](../reports/)*

## Summary Stats

Top 10,000 HN users can find their stats in [this Google sheet](https://docs.google.com/spreadsheets/d/13GZegg1zrd0rcB30yL9s9JEyqo1n0LvbDC_eZukLwPk/edit?usp=sharing). (Use `Cmd-F` or `Ctrl-F` to find your username.)

Any other user's stats can be found with query [`hackernews/authors-summary.sql`](../hackernews/authors-summary.sql). Just put your name in it and run the code in BigQuery web interface, as described in [README](../README.md#web-interface). It takes like a minute.

Example for Colin Wright, the top HN author:

```
"author": "ColinWright",
"total_stories": "3710",

"sum_score": "78098",
"avg_score": "21.05067385444744",
"stddev_score": "55.009723578119406",
"min_score": "1",
"median_score": "2",
"max_score": "676",

"sum_comments": "31732",
"avg_comments": "8.553099730458221",
"stddev_comments": "26.71685835163779",
"min_comments": "0",
"median_comments": "0",
"max_comments": "372",

"first_submission_time": "1302805174",
"last_submission_time": "1444497732",
"tenure": "1843.1200038085187",
"point_earning_speed": "42.37271574212353"

"avg_length_title": "46.4533692722372",

"percent_rank_total_stories": "0.9992999299929993",
"percent_rank_sum_score": "1.0",
"percent_rank_median_score": "0.06530653065306531",
"percent_rank_avg_score": "0.5036503650365036",
"percent_rank_sum_comments": "1.0",
```

Fields are aggregated over stories. A brief description: 

 - `avg_XXX`, scores or comments per story: This and other prefixes explain themselves.
 - `tenure`, days: How much time passed since the user's first submission.
 - `point_earning_speed`, points per day: Defined as `sum_score / tenure`
 - `percent_rank_XXX`, quantile in interval `[0, 1]`: The user's position relative to other users. `0.5` refers to the median user. All users `> .95` are in top 5% by the respective metric.


## All submissions

You can find all your submissions, as by October 2015, with [`hackernews/authors-stories.sql`](../hackernews/authors-stories.sql). See "Web Interface" in [README](../README.md#web-interface).
