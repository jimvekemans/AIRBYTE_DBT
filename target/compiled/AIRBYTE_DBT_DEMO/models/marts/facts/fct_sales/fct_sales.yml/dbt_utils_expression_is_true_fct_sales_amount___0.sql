

with meet_condition as (
    select * from AIRBYTE_DATABASE.PAGILA_data_mart.fct_sales where 1=1
)

select
    *
from meet_condition

where not(amount >= 0)

