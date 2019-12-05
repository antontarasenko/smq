-- Summary
select
  count(*) count_rows,

  min(SQLDATE) first_date,
  max(SQLDATE) last_date,

  count(unique(Actor1Name)) as count_unique_Actor1Name,
  count(unique(Actor2Name)) as count_unique_Actor2Name
from
  [gdelt-bq:full.events]