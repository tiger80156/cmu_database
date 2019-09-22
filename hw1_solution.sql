--- Question 01
SELECT COUNT(DISTINCT(city)) FROM station;

--- Question 02
SELECT city, COUNT(*) as num FROM station GROUP BY city ORDER BY num, city;

--- Question 03
SELECT ROUND(1.0 * count(*) / ((SELECT count(*) FROM trip)+ (SELECT count(*) FROM trip where start_station_id != trip.end_station_id)), 4) as r, city
FROM (SELECT * FROM trip JOIN station ON
trip.start_station_id = station.station_id
UNION ALL
SELECT * FROM trip JOIN station ON
trip.end_station_id = station.station_id WHERE trip.start_station_id != trip.end_station_id)
GROUP BY city ORDER BY r desc;

--- Question 04
SELECT city, station_name, MAX(c) FROM (SELECT count(*) as c, station_name, city FROM trip JOIN station
ON trip.start_station_id = station.station_id GROUP BY station_name, city
UNION ALL 
SELECT count(*), station_name, city FROM trip JOIN station ON
trip.end_station_id = station.station_id WHERE trip.start_station_id != trip.end_station_id
GROUP BY station_name, city) GROUP BY city ORDER BY city;

--- Question 05
SELECT date(start_time) AS start_date, date(end_time) AS end_date,
(SUM(julianday(end_time)*3600*24 - julianday(start_time)*3600*24) / (SELECT COUNT(DISTINCT(bike_id)) FROM trip WHERE bike_id <= 100))
AS average_usage FROM trip where 
bike_id <= 100 and start_date == end_date GROUP BY start_date, end_date 
UNION ALL
SELECT data(start_time) AS start_date, date(end_time) AS end_date,
ORDER BY average_usage desc
