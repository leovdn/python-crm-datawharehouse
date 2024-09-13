{{ config(materialized='view') }}

WITH cleaned_data AS (
    SELECT
        email,
        DATE(date_time) AS date_time,
        value,
        quantity,
        product
    FROM
        {{ ref('bronze_sales') }}
    WHERE
        value > 0
        AND value < 8000
        AND date_time <= CURRENT_DATE
)

SELECT * FROM cleaned_data