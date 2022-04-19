WITH customer AS (
	SELECT customer_id,
		   store_id,
		   first_name,
		   last_name,
		   email,
		   active,
		   create_date,
		   address.address,
		   address.district,
		   address.postal_code,
		   address.phone,
		   city.city,
		   country.country,
		   customer.last_update
	FROM AIRBYTE_DATABASE.pagila.customer
	LEFT JOIN AIRBYTE_DATABASE.pagila.address ON address.address_id = customer.address_id
	LEFT JOIN AIRBYTE_DATABASE.pagila.city ON address.city_id = city.city_id
	LEFT JOIN AIRBYTE_DATABASE.pagila.country ON city.country_id = country.country_id
)

SELECT *
FROM customer