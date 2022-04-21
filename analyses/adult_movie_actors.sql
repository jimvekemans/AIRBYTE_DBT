{%-
    set adult_categories = [1, 6, 7, 11, 14]
-%}

WITH actors AS (
    SELECT DISTINCT
        CONCAT(ac.FIRST_NAME, ' ', ac.LAST_NAME) as ACTOR_NAME,
        ac.ACTOR_ID
    FROM {{ source('pagila', 'actor')}} ac
),

adult_movies AS (
    SELECT DISTINCT
        fl.TITLE,
        fl.FILM_ID
    FROM {{ source('pagila', 'film')}} fl
    INNER JOIN {{ source('pagila', 'film_category')}} fc
    ON fl.FILM_ID = fc.FILM_ID
    WHERE fc.CATEGORY_ID IN ({% for cat in adult_categories -%}
        {{ cat }}{%- if not loop.last %},{% endif -%}
    {%- endfor %})
    ORDER BY fl.TITLE ASC
),

adult_actors_amounts AS (
    SELECT 
        ac.ACTOR_NAME,
        COUNT(am.TITLE) AS ADULT_MOVIE_AMOUNT
    FROM adult_movies am
    LEFT JOIN {{ source('pagila', 'film_actor')}} fa
    ON fa.FILM_ID = am.FILM_ID
    LEFT JOIN actors ac
    ON fa.ACTOR_ID = ac.ACTOR_ID
    GROUP BY ac.ACTOR_NAME
    ORDER BY ADULT_MOVIE_AMOUNT DESC
)

SELECT DISTINCT ACTOR_NAME 
FROM ADULT_actors_amounts 
WHERE ADULT_MOVIE_AMOUNT > 10