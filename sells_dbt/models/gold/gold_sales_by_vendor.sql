{{ config(materialized='view') }}

WITH sales_7_days_vendor AS (
    SELECT
        email AS vendedor,
        DATE(date_time) AS data,
        SUM(value) AS total_valor,
        SUM(quantity) AS total_quantidade,
        COUNT(*) AS total_vendas
    FROM
        {{ ref('silver_sales') }}
    WHERE
        date_time >= CURRENT_DATE - INTERVAL '6 days'
    GROUP BY
        email, DATE(date_time)
)

SELECT
    vendedor,
    data,
    total_valor,
    total_quantidade,
    total_vendas
FROM
    sales_7_days_vendor
ORDER BY
    data ASC, vendedor ASC