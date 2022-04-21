
    
    

with all_values as (

    select
        active as value_field,
        count(*) as n_records

    from AIRBYTE_DATABASE.pagila.staff
    group by active

)

select *
from all_values
where value_field not in (
    'True','False'
)


