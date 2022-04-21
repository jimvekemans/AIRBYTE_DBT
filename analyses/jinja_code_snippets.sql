/* THIS IS A COMMENT IN SQL */
{# THIS IS A COMMENT IN JINJA #}
/* USING {# JINJA #} INSIDE OF A {# SQL #} COMMENT */

{% set company_info={
    'company': 'datasense',
    'age': 5,
    'locations': ['Hasselt', 'Amsterdam', 'Silicon Valley']
} -%}
{{ company_info['company'] }} will soon turn {{ company_info['age'] }} years old!

{#- ADD DASHES TO AVOID COMPILING WHITESPACE -#}
{% set knowledge='transferring' %}
Just {{ knowledge }} some knowledge...

{% set usecase=['l', 'o', 'o', 'p', 'i', 'n', 'g'] -%}
Dashing is useful for {% for val in usecase -%}
    {{ val }}
{%- endfor %}

{%- set location_check='Hasselt' -%}
{%- set location_backup='Madrid' -%}
{% if location_check in company_info['locations'] %}
DataSense heeft een kantoor in Hasselt.
{% elif location_backup in company_info['locations'] %}
DataSense neemt collectief verlof naar Madrid.
{% else %}
Ik weet niet wat een DataSense is.
{% endif %}
