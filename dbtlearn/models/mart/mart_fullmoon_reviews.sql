{{
  config(
    materialized = 'table',
    )
}}

WITH fct_reviews AS (
    SELECT * FROM {{ ref('fact_reviews') }}
)
, full_moon_dates AS (
    SELECT * FROM {{ ref('seed_full_moon_dates') }}
)

SELECT
    r.*
    , CASE fm.full_moon_date
        WHEN NULL
        THEN 'Not full moon'
        ELSE 'Full moon'
    END AS is_full_moon
FROM fct_reviews AS r
LEFT JOIN full_moon_dates AS fm
    ON TO_DATE(r.review_date) = DATEADD(DAY, 1, fm.full_moon_date)