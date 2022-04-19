with date_dim as(
{{ dbt_date.get_date_dimension('2015-01-01', '2022-12-31') }}
)

select row_number() over (order by date_day) as date_dim_id, date_dim.* from date_dim