/* https://documentation.bloomreach.com/engagement/docs/jinjablocks */
{%- 
    set relation = api.Relation.create(
        database='AIRBYTE_DATABASE',
        schema='PAGILA',
        identifier='MOVIES_REL',
        type='view'
    )
-%}

{%- 
    set select_columns = [
        api.Column('FIRST_NAME', 'varchar', 255),
        api.Column('LAST_NAME', 'varchar', 255)
    ]
-%}

{%-
    set actor_ids = [39, 43, 60, 98]
-%}

/* 
You can use jinja in comments to document that we are selecting:
{% for colname in select_columns -%}
    {{ colname.name }}{%- if loop.last %} {% else %} and {% endif -%}
{%- endfor -%} for the actors with ID:
{% for id in actor_ids -%}
    {{ id }}{%- if loop.last %} from {{ source('pagila', 'actor')}}{% else %},{% endif -%}
{%- endfor %}
*/

WITH teen_movies AS (
    SELECT fc.FILM_ID
    FROM {{ source('pagila', 'film_category')}} fc
    INNER JOIN {{ source('pagila', 'film_actor')}} fa
    ON fc.FILM_ID = fa.FILM_ID
    WHERE fc.CATEGORY_ID = 8
    AND fa.ACTOR_ID IN (
        {% for id in actor_ids -%}
            {{ id }}{%- if not loop.last %},{% endif -%}
        {%- endfor %}
    )
    GROUP BY 1
    ORDER BY fc.FILM_ID ASC
)

SELECT CONCAT(ac.FIRST_NAME, ' ', ac.LAST_NAME) as NAME
FROM teen_movies tm
INNER JOIN {{ source('pagila', 'film_actor')}} fa
INNER JOIN {{ source('pagila', 'actor')}} ac
INNER JOIN 

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) as NAME
FROM {{ source('pagila', 'actor')}} ac
INNER JOIN {{ source('pagila', 'film_actor')}} fa
INNER JOIN teen_movies tm
ON fa.FILM_ID = tm.FILM_ID
GROUP BY 1