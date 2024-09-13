{{ config(materialized='view') }}

WITH sales_7_days AS (
    SELECT
        date_time,
        product,
        SUM(value) AS total_valor,
        SUM(quantity) AS total_quantidade,
        COUNT(*) AS total_vendas
    FROM
        {{ ref('silver_sales') }}
    WHERE
        date_time >= CURRENT_DATE - INTERVAL '6 days'
    GROUP BY
        date_time, product
)

SELECT
    date_time,
    product,
    total_valor,
    total_quantidade,
    total_vendas
FROM
    sales_7_days
ORDER BY
    date_time ASC