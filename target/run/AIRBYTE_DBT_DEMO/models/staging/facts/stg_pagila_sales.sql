
  create or replace  view AIRBYTE_DATABASE.PAGILA_staging.stg_pagila_sales 
  
   as (
    WITH sales
AS (
    SELECT payment_id,
    payment.customer_id,
    inventory.film_id,
    inventory.store_id,
    payment.staff_id,
    payment.payment_date,
    payment.amount
    FROM AIRBYTE_DATABASE.pagila.payment
    LEFT JOIN AIRBYTE_DATABASE.pagila.rental ON rental.rental_id = payment.rental_id
    LEFT JOIN AIRBYTE_DATABASE.pagila.inventory ON inventory.inventory_id = rental.inventory_id
)

select * 
from sales
  );
