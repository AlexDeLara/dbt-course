SELECT
    *
FROM {{ ref('fact_reviews') }} AS fr
INNER JOIN {{ ref('dim_listings_cleansed') }} AS dlc
    ON fr.listing_id = dlc.listing_id
WHERE fr.review_date < dlc.created_at
