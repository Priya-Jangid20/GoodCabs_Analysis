-- Q1) City-Level Fare and Trip Summary Report
      
SELECT 
    dc.city_name,
    COUNT(ft.trip_id) AS total_trips,
    ROUND(AVG(ft.fare_amount), 2) AS avg_fare_per_trip,
    ROUND(SUM(ft.fare_amount) / SUM(ft.distance_travelled_km),2) AS avg_fare_per_km,
    ROUND(COUNT(ft.trip_id) * 100 / (SELECT COUNT(ft.trip_id) FROM fact_trips ft), 2) AS pct_contribution_of_cityTrips_to_totalTrips
FROM
    dim_city dc
JOIN
    fact_trips ft
ON
    dc.city_id = ft.city_id
GROUP BY dc.city_name
ORDER BY total_trips DESC;
