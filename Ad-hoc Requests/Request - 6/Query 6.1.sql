SELECT c.city_name,
	   MONTHNAME(ps.month) AS month_name,
       ps.total_passengers AS total_passengers,
       ps.repeat_passengers AS repeat_passengers,
       ROUND(repeat_passengers*100/total_passengers,2) AS "monthly_RPR%"
FROM dim_city c
JOIN fact_passenger_summary ps
ON c.city_id = ps.city_id
ORDER BY c.city_name, ps.month;
