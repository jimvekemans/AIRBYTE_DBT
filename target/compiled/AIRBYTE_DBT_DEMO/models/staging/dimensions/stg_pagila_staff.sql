with staff as
(select staff.staff_id,
       first_name,
       last_name,
       staff.address_id,
       picture,
       email,
       staff.store_id,
       active,
       username,
       password,
       staff.last_update,
       address,
       address2,
       district,
       address.city_id,
       postal_code,
       phone,
       city,
       city.country_id,
       country
from AIRBYTE_DATABASE.pagila.staff
left join AIRBYTE_DATABASE.pagila.address on address.address_id = staff.address_id
left join AIRBYTE_DATABASE.pagila.city on city.city_id = address.city_id
left join AIRBYTE_DATABASE.pagila.country on country.country_id = city.country_id)

select *
from staff