--
select
    column_a as a
    , 'static string'
    , (select 'static string' from table_b) as b
from
    (select * from table_a)
;
