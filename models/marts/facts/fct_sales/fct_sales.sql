with sales_fact
AS (
	SELECT  COALESCE(dd.date_dim_id, '0') AS date_id,
        COALESCE(dc.customer_id, '0') AS customer_id,
		COALESCE(df.film_id, '0') AS film_id,
		COALESCE(ds.store_id, '0') AS store_id,
		COALESCE(dst.staff_id, '0') AS staff_id,
		amount
	FROM {{ ref('stg_pagila_sales') }} src
	LEFT JOIN {{ ref('dim_customer') }} dc ON src.customer_id = dc.customer_id
	LEFT JOIN {{ ref('dim_store') }} ds ON src.store_id = ds.store_id
	LEFT JOIN {{ ref('dim_film') }} df ON src.film_id = df.film_id
	LEFT JOIN {{ ref('dim_staff') }} dst ON src.staff_id = dst.staff_id
    LEFT JOIN {{ ref('dim_date') }} dd ON DATE (src.payment_date) = dd.date_day
	)

SELECT *
FROM sales_fact