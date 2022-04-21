with film_categories as (
    select 
        FILM_ID,
        CATEGORY_ID
    from {{ source('pagila', 'film_category')}}
),

film_actors as (
    select 
        FILM_ID,
        ACTOR_ID
    from {{ source('pagila', 'film_actor')}}
),

actors as (
    select 
        CONCAT(FIRST_NAME, ' ', LAST_NAME) as NAME,
        ACTOR_ID 
    from {{ source('pagila', 'actor')}}
),

movie_actor_summary as (
    SELECT DISTINCT 
        actors.NAME,
        film_actors.FILM_ID,
        film_categories.CATEGORY_ID
    FROM actors
    LEFT JOIN film_actors
    ON film_actors.ACTOR_ID = actors.ACTOR_ID
    LEFT JOIN film_categories
    ON film_actors.FILM_ID = film_categories.FILM_ID
)

{% set datasource %}
    {{ source('pagila', 'film_category') }}
{% endset %}
{% set desired_column = 'CATEGORY_ID' %}
{% set categories = get_column_values(desired_column, datasource) %}

select
    NAME,
    sum(case when CATEGORY_ID = 1 then 1 else 0 end) AS ACTION_MOVIES,
    sum(case when CATEGORY_ID = 2 then 1 else 0 end) AS ANIMATION_MOVIES,
    sum(case when CATEGORY_ID = 3 then 1 else 0 end) AS CHILDREN_MOVIES,
    sum(case when CATEGORY_ID = 4 then 1 else 0 end) AS CLASSIC_MOVIES,
    sum(case when CATEGORY_ID = 5 then 1 else 0 end) AS COMEDY_MOVIES,
    sum(case when CATEGORY_ID = 6 then 1 else 0 end) AS DOCUMENTARY_MOVIES,
    sum(case when CATEGORY_ID = 7 then 1 else 0 end) AS DRAMA_MOVIES,
    sum(case when CATEGORY_ID = 8 then 1 else 0 end) AS FAMILY_MOVIES,
    sum(case when CATEGORY_ID = 9 then 1 else 0 end) AS FOREIGN_MOVIES,
    sum(case when CATEGORY_ID = 10 then 1 else 0 end) AS GAMES_MOVIES,
    sum(case when CATEGORY_ID = 11 then 1 else 0 end) AS HORROR_MOVIES,
    sum(case when CATEGORY_ID = 12 then 1 else 0 end) AS MUSIC_MOVIES,
    sum(case when CATEGORY_ID = 13 then 1 else 0 end) AS NEW_MOVIES,
    sum(case when CATEGORY_ID = 14 then 1 else 0 end) AS SCIFI_MOVIES,
    sum(case when CATEGORY_ID = 15 then 1 else 0 end) AS SPORTS_MOVIES,
    sum(case when CATEGORY_ID = 16 then 1 else 0 end) AS TRAVEL_MOVIES
from movie_actor_summary
group by 1

{#
pivot_table as (
    select
        mas.NAME,
        sum(case when mas.CATEGORY_ID = 1 then 1) as ACTION_MOVIES
    from movie_actor_summary mas
)

select * from pivot_table
#}