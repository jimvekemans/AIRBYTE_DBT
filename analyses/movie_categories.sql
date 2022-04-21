{%- set datasource -%}
{{ source('pagila', 'category')}}
{%- endset -%}
{%- set desired_column='CATEGORY_ID' -%}
{%- set catcodes = get_column_values(desired_column, datasource) -%}
{%- set intcodes = [] -%}
{%- for code in catcodes -%}
    {%- set intcode -%}
        {{ code|int }}
    {%- endset -%}
    {{ intcodes.append(intcode) }}
    {{ code|int }}{% if not loop.last %},{% endif %}
{%- endfor %}
{{ intcodes }}