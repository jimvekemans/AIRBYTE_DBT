
    
    

select
    film_id as unique_field,
    count(*) as n_records

from AIRBYTE_DATABASE.PAGILA_data_mart.dim_film
where film_id is not null
group by film_id
having count(*) > 1


