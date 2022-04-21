
    
    

select
    store_id as unique_field,
    count(*) as n_records

from AIRBYTE_DATABASE.PAGILA_data_mart.dim_store
where store_id is not null
group by store_id
having count(*) > 1


