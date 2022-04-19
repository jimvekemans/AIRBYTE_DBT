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
from {{ source('pagila', 'film')}}
LEFT JOIN {{ source('pagila', 'language')}} on film.language_id = language.language_id
LEFT JOIN {{ source('pagila', 'language')}} og_language on film.original_language_id = language.language_id
LEFT JOIN {{ source('pagila', 'film_category')}} on film_category.film_id = film.film_id
left join {{ source('pagila', 'category')}}  on category.category_id = film_category.category_id)

select *
from film