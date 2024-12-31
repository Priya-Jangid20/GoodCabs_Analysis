WITH RankedCities AS (
    SELECT 
        dc.city_name,
        SUM(ps.new_passengers) AS total_new_passengers,
        RANK() OVER (ORDER BY SUM(ps.new_passengers) DESC) AS rank_desc,
        RANK() OVER (ORDER BY SUM(ps.new_passengers) ASC) AS rank_asc
    FROM 
        fact_passenger_summary ps
    JOIN 
        dim_city dc
    ON 
        ps.city_id = dc.city_id
    GROUP BY 
        dc.city_name
),
CategorisedCities AS (
    SELECT 
        city_name,
        total_new_passengers,
        CASE 
            WHEN rank_desc <= 3 THEN 'Top 3'
            WHEN rank_asc <= 3 THEN 'Bottom 3'
            ELSE NULL
        END AS city_category
    FROM 
        RankedCities
)
SELECT 
    city_name,
    total_new_passengers,
    city_category
FROM 
    CategorisedCities
WHERE 
    city_category IS NOT NULL
ORDER BY 
    total_new_passengers DESC;
