WITH 
RankMonth AS (
	SELECT c.city_name AS city,
			MONTHNAME(t.date) AS month_name,
            SUM(t.fare_amount) AS revenue,
            RANK() OVER (PARTITION BY c.city_name ORDER BY SUM(t.fare_amount) DESC) AS rank_desc
    FROM dim_city c
    JOIN fact_trips t ON c.city_id = t.city_id
    GROUP BY c.city_id, MONTHNAME(t.date)
),
HighestRevCity AS (
	SELECT city,
    revenue,
    CASE
    WHEN rank_desc = 1 THEN month_name ELSE NULL
    END AS city_highest_rev,
    CASE
    WHEN rank_desc = 1 THEN revenue ELSE NULL
    END AS rev
    FROM RankMonth
)
SELECT city,
		city_highest_rev,
        rev,
        rev*100/revenue
FROM HighestRevCity
WHERE city_highest_rev IS NOT NULL;
