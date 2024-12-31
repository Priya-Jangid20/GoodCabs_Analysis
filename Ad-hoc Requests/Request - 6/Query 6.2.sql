SELECT c.city_name,
       SUM(ps.total_passengers) AS total_passengers,
       SUM(ps.repeat_passengers) AS repeat_passengers,
       ROUND(SUM(ps.repeat_passengers)*100/sum(ps.total_passengers),2) AS city_RPR_pct
FROM dim_city c
JOIN fact_passenger_summary ps
ON c.city_id = ps.city_id
GROUP BY c.city_name
ORDER BY city_RPR_pct DESC;
