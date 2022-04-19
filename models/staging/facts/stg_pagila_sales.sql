WITH sales
AS (
    SELECT payment_id,
    payment.customer_id,
    inventory.film_id,
    inventory.store_id,
    payment.staff_id,
    payment.payment_date,
    payment.amount
    FROM {{ source('pagila','payment') }}
    LEFT JOIN {{ source('pagila','rental') }} ON rental.rental_id = payment.rental_id
    LEFT JOIN {{ source('pagila','inventory') }} ON inventory.inventory_id = rental.inventory_id
)

select * 
from sales