
  create or replace  view AIRBYTE_DATABASE.PAGILA_staging.stg_pagila_film 
  
   as (
    with film as (
select film.film_id,
       title,
       description,
       release_year,
       film.language_id,
       film.original_language_id,
       rental_duration,
       rental_rate,
       length,
       replacement_cost,
       rating,
       special_features,
       film.last_update,
       language.name as language,
       og_language.name as original_language,
       category.name as category_name
from AIRBYTE_DATABASE.pagila.film
LEFT JOIN AIRBYTE_DATABASE.pagila.language on film.language_id = language.language_id
LEFT JOIN AIRBYTE_DATABASE.pagila.language og_language on film.original_language_id = language.language_id
LEFT JOIN AIRBYTE_DATABASE.pagila.film_category on film_category.film_id = film.film_id
left join AIRBYTE_DATABASE.pagila.category  on category.category_id = film_category.category_id)

select *
from film
  );
