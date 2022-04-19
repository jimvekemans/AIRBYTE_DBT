
  create or replace  view AIRBYTE_DATABASE.PAGILA_staging.stg_pagila_store 
  
   as (
    select store.store_id,
       manager_staff_id,
       store.address_id,
       store.last_update,
       address,
       address2,
       district,
       address.city_id,
       postal_code,
       phone,
       city,
       city.country_id,
       country
from AIRBYTE_DATABASE.pagila.store
left join AIRBYTE_DATABASE.pagila.address on store.address_id = address.address_id
left join AIRBYTE_DATABASE.pagila.city on address.city_id = city.city_id
left join AIRBYTE_DATABASE.pagila.country on city.country_id = country.country_id
left join AIRBYTE_DATABASE.pagila.staff on staff.staff_id = store.manager_staff_id
  );
