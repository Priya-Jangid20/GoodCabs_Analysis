WITH 
 actual_trip AS (
      SELECT ft.city_id, 
			 MONTHNAME(ft.date) AS month_name,
			 COUNT(ft.trip_id) AS actual_trips
      FROM fact_trips ft
      GROUP BY ft.city_id, month_name
),
target_trip AS (
      SELECT mtt.city_id, 
			 MONTHNAME(mtt.month) AS month_name,
             SUM(mtt.total_target_trips) AS target_trips
      FROM targets_db.monthly_target_trips mtt
	  GROUP BY mtt.city_id, month_name
)
SELECT 
   dc.city_name,
   a.month_name, 
   a.actual_trips, 
   t.target_trips AS target_trips,
   CASE
    WHEN a.actual_trips > t.target_trips THEN "Above Target" ELSE "Below Target"
    END AS performance_status,
   ROUND((((a.actual_trips-t.target_trips)*100)
            /t.target_trips),2) AS "%_difference"
	
FROM dim_city dc
JOIN target_trip t
ON dc.city_id = t.city_id
JOIN actual_trip a ON a.city_id = t.city_id AND a.month_name = t.month_name
ORDER BY dc.city_name, month_name;
