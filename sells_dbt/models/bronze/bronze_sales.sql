{{ config(materialized='view') }}

SELECT
    *
FROM
    {{ source('sells_source', 'sells') }}