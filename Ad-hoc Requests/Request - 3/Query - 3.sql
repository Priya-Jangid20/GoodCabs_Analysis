SELECT 
    dc.city_name,
    ROUND((SUM(CASE WHEN rtd.trip_count = '2-Trips' THEN rtd.repeat_passenger_count ELSE 0 END)*100)/SUM(rtd.repeat_passenger_count),2) AS 2_Trips,
    ROUND((SUM(CASE WHEN rtd.trip_count = '3-Trips' THEN rtd.repeat_passenger_count ELSE 0 END)*100)/SUM(rtd.repeat_passenger_count),2) AS 3_Trips,
    ROUND((SUM(CASE WHEN rtd.trip_count = '4-Trips' THEN rtd.repeat_passenger_count ELSE 0 END)*100)/SUM(rtd.repeat_passenger_count),2)AS 4_Trips,
    ROUND((SUM(CASE WHEN rtd.trip_count = '5-Trips' THEN rtd.repeat_passenger_count ELSE 0 END)*100)/SUM(rtd.repeat_passenger_count),2) AS 5_Trips,
    ROUND((SUM(CASE WHEN rtd.trip_count = '6-Trips' THEN rtd.repeat_passenger_count ELSE 0 END)*100)/SUM(rtd.repeat_passenger_count),2) AS 6_Trips,
    ROUND((SUM(CASE WHEN rtd.trip_count = '7-Trips' THEN rtd.repeat_passenger_count ELSE 0 END)*100)/SUM(rtd.repeat_passenger_count),2) AS 7_Trips,
    ROUND((SUM(CASE WHEN rtd.trip_count = '8-Trips' THEN rtd.repeat_passenger_count ELSE 0 END)*100)/SUM(rtd.repeat_passenger_count),2) AS 8_Trips,
    ROUND((SUM(CASE WHEN rtd.trip_count = '9-Trips' THEN rtd.repeat_passenger_count ELSE 0 END)*100)/SUM(rtd.repeat_passenger_count),2) AS 9_Trips,
    ROUND((SUM(CASE WHEN rtd.trip_count = '10-Trips' THEN rtd.repeat_passenger_count ELSE 0 END)*100)/SUM(rtd.repeat_passenger_count),2) AS 10_Trips
FROM 
    dim_repeat_trip_distribution rtd
JOIN 
    dim_city dc
ON 
    dc.city_id = rtd.city_id
GROUP BY 
    dc.city_name
ORDER BY 
    dc.city_name;
