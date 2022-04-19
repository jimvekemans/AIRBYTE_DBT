

      create or replace transient table AIRBYTE_DATABASE.PAGILA_data_mart.dim_store  as
      (SELECT *
FROM AIRBYTE_DATABASE.PAGILA_staging.stg_pagila_store
      );
    