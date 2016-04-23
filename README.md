# Social Media Queries

A collection of SQL queries to social media datasets. The queries return answers like "Most mentioned books on Hacker News", "Top apps on Reddit", and others. See the [list of queries](#queries) and [how to use them](#usage) below


## Table of Contents

* [Reports](#reports)
* [Queries](#queries)
* [Usage](#usage)
* [Contributing](#contributing)
* [Acknowledgements](#acknowledgements)


## Reports

Directory [`reports`](reports/) features showcases:

* [Top Hacker News Submissions by Year](reports/hackernews-top-submissions-by-year.md)
* [Top 100 "Show HN" Projects](reports/hackernews-top-show-hn-100.md)
* [Top HN Authors by H-Index](reports/hackernews-top-authors-by-h-index.md)
* [Top Reddit Submissions by Year](https://github.com/antontarasenko/smq/blob/master/reports/reddit-top-submissions-by-year.md)
* [Top Reddit IAmA by Year](reports/reddit-top-iama-by-year.md)

Check [`reports`](reports/) for more.


## Queries

Queries are written for Google BigQuery [free public datasets](https://bigquery.cloud.google.com/) (requires a Google account) and stored in `.sql` files, organized by social media outlet (folder `hackernews` and so on). These datasets are snapshots taken on particular dates, so results do not include post-2015 content.

Each of the queries processes 0.5-10GB of data. Processing up to 1TB per month is free, and you have up to 2,000 queries to experiment with.

### [Hacker News](https://news.ycombinator.com/)

Some examples (see [`hackernews` directory](hackernews/) for the full list):

* [Most cited books (comments)](hackernews/amazon-books-in-text.sql) - Using links to Amazon.com as citations. Don't include text references. Also see [this thread](https://news.ycombinator.com/item?id=10924741). This and the three next queries can be extended to other items. Examples:
  - Movies on Internet Movie Database: `imdb.com/title/tt[0-9]+/`
  - Books on iTunes: `itunes.apple.com/book/id[0-9]+`
  - Apps on Google Play: `play.google.com/store/apps/details?id=.+`
* [Most cited books (submissions)](hackernews/amazon-books-in-url.sql) - The same, but this counts submitted URLs.
* [Popular iTunes Apps (comments)](hackernews/itunes-apps-in-text.sql) - Like "Most cited books", but this tracks links to Apple Store. 
* [Popular iTunes Apps (submissions)](hackernews/itunes-apps-in-url.sql) - Similarly.
* [Social network (graph)](hackernews/social-network.sql) - A weighted directional graph based on users commenting each other. Weights correspond to the number of comments one user left to another. See [Social network analysis](https://en.wikipedia.org/wiki/Social_network_analysis) for more information.
* [Top authors by median](hackernews/top-authors-median.sql) - List of authors based on the median score. A quick way to find founders and VCs submitting to HN.
* [Top authors by mean](hackernews/top-authors-mean.sql) - Based on the mean score. Usually implies many low-scored posts with major hits due to the skewed distribution.
* [Top news sources](hackernews/top-news-sources.sql) - Where most popular news come from? Separated by day of week and hour.
* [Popular Wikipedia articles](hackernews/wikipedia-pages-in-url.sql) - Counting links to Wikipedia articles.

For simple queries, use Hacker News' Algolia search:

* [All-time stories ranked by score](https://hn.algolia.com/?query=&sort=byPopularity&prefix&page=0&dateRange=all&type=story)
* ["Show HN" by score](https://hn.algolia.com/?query=show%20hn&sort=byPopularity&prefix&page=0&dateRange=all&type=story)
* ["Ask HN" by score](https://hn.algolia.com/?query=ask%20hn&sort=byPopularity&prefix&page=0&dateRange=all&type=story)
* [Comments ranked by score](https://hn.algolia.com/?query=&sort=byPopularity&prefix&page=0&dateRange=all&type=comment)

### [Reddit](http://reddit.com/)

All Hacker News queries can be applied to Reddit after minor edits. Examples:

* [Top authors by median](reddit/top-authors-median.sql) - Authors ranked by the median score with minor adjustments. Expect no poor content from them.
* [Top sources of political news](reddit/posts-top-domains.sql) - Ranking sources submitted to [r/politics](http://reddit.com/r/politics).

Reddit comments on BigQuery are split into multiple tables. If you want to select from comments, use `TABLE_QUERY`:

  `FROM (TABLE_QUERY([fh-bigquery:reddit_comments], "table_id BETWEEN '2007' AND '2014' OR table_id CONTAINS '2015_' OR table_id CONTAINS '2016_'"))`.

Beware, this can quickly exhaust the free 1TB limit.

### [Wikipedia](https://www.wikipedia.org/)

* [Edits made from an IP address](wikipedia/edits-by-organization.sql) - Wikipedia records IP addresses of anonymous editors. With respect to privacy, some uses of this data: 
  - Edits by organization. Many organizations reserve static IPs. One famous example is [US Congress' edits](https://en.wikipedia.org/wiki/United_States_Congressional_staff_edits_to_Wikipedia). This query is unlikely to return many edits done by a particular organization because the sample table contains only 300M edits. Too diluted to have a representative subset. 
  - Edits by region. The sample is sufficient for statistics by region and other broad characteristics.

### [Stack Exchange](http://stackexchange.com/)

Stack Exchange has its own query system at [http://data.stackexchange.com/](data.stackexchange.com). Check their [top queries](http://data.stackexchange.com/stackoverflow/queries?order_by=favorite) and [try](http://data.stackexchange.com/stackoverflow/query/new) your own. [This post](http://meta.stackexchange.com/questions/2677/database-schema-documentation-for-the-public-data-dump-and-sede) describes the variables.


## Usage

### Web Interface

You can export up to 16,000 rows or 10MB as a `csv` file via web interface. Larger output can be exported through console. Add `LIMIT <n>` to queries to control the number of rows in output.  

1. Locate a query in the repo's folder
2. Login at <https://bigquery.cloud.google.com/welcome>
3. Press "Compose query" in the top left corner
4. Copy-paste the query and run it

See [web UI quickstart](https://cloud.google.com/bigquery/web-ui-quickstart) by Google.

### Command line: `bq`

1. Install [Google Cloud SDK](https://cloud.google.com/sdk/downloads)
2. Initialize your account for [command line tools](https://cloud.google.com/bigquery/bq-command-line-tool)
3. Run ``bq query `cat <path>` ``, where `<path>` leads to the `.sql` file

### Python in clouds: Jupyter, IPython notebooks

1. Get a Google Cloud account ([free trial](https://console.cloud.google.com/freetrial))
2. Create a Jupyter notebook in [Datalab](https://cloud.google.com/datalab/)
3. Do `import gcp.bigquery as bq`
4. Run queries with `bq.Query()` function

See Felipe Hoffa's [Hacker News notebook](https://github.com/fhoffa/notebooks/blob/master/analyzing%20hacker%20news.ipynb) for example.

### BigQuery API

See [BigQuery API Quickstart](https://cloud.google.com/bigquery/bigquery-api-quickstart) for examples in Java, Python, C#, PHP, Ruby. You'll need a [credentials file](https://developers.google.com/identity/protocols/application-default-credentials) to run it locally.


## Contributing

Pull requests are welcomed. Suggestions:

* Adding new queries
* Adapting `.sql` files for Hacker News to Reddit and Wikipedia datasets
* Adding new types of reports to the [`reports`](reports/) section 

The [reference](https://cloud.google.com/bigquery/query-reference) for BigQuery's SQL dialect.


## Acknowledgements

* [Felipe Hoffa](https://twitter.com/felipehoffa) for publishing the datasets
* Discussions on Hacker News and Reddit. Also, the follow-up discussions:
  - [Top Hacker News Submissions by Year: 2009–2015](https://news.ycombinator.com/item?id=11468407)
  - [Websites That Feed Hacker News: Top Sources of Submissions by Median Score](https://news.ycombinator.com/item?id=11499120)
  - [Top 100 Users on Hacker News by H-Index](https://news.ycombinator.com/item?id=11512455)
