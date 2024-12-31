WITH 
cityRank AS (
     SELECT dc.city_name,
            SUM(ps.new_passengers) AS total_new_passengers,
            DENSE_RANK() OVER (ORDER BY SUM(ps.new_passengers) ASC) AS rank_asc,
            DENSE_RANK() OVER (ORDER BY SUM(ps.new_passengers) DESC) AS rank_desc
     FROM dim_city dc
     JOIN fact_passenger_summary ps
     ON dc.city_id = ps.city_id
     GROUP BY dc.city_id
),
categrisedCity AS (
	SELECT 
      city_name,
      total_new_passengers,
    CASE 
    WHEN rank_desc <= 3 THEN "Top 3"
    WHEN rank_asc <= 3 THEN "Bottom 3" ELSE NULL END AS city_category
    FROM cityRank
)
SELECT city_name,
	total_new_passengers,
    city_category
FROM categrisedCity
WHERE city_category IS NOT NULL
GROUP BY city_name
ORDER BY total_new_passengers DESC;
