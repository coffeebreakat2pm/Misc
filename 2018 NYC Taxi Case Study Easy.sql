-- links to dataset: 
-- https://data.cityofnewyork.us/Transportation/2018-Yellow-Taxi-Trip-Data/t29m-gskq/data (2018 taxi data, named table to '2018_nyc_taxi_data')
-- https://data.cityofnewyork.us/Transportation/NYC-Taxi-Zones/d3c5-ddgc (Taxi zones data, named table to 'taxi_zones')

-- Add two column where we add name of corresponding LocationID from 'taxi_zone' table

ALTER TABLE 
	nyc_taxi..['2018_nyc_taxi_data']
ADD 
	PUZone nvarchar(255),
	DOZone nvarchar(255);

-- Updating the table so that LocationID gets its corresponding zone name by using INNER JOIN.
UPDATE 
	nyc_taxi..['2018_nyc_taxi_data']

SET 
	nyc_taxi..['2018_nyc_taxi_data'].PUZONE = nyc_taxi..['taxi_zones'].zone_name
FROM
	nyc_taxi..['2018_nyc_taxi_data']
	INNER JOIN nyc_taxi..['taxi_zones'] 
	ON nyc_taxi..['2018_nyc_taxi_data'].PULocationID = nyc_taxi..['taxi_zones'].LocationID

UPDATE 
	nyc_taxi..['2018_nyc_taxi_data']

SET 
	nyc_taxi..['2018_nyc_taxi_data'].DOZONE = nyc_taxi..['taxi_zones'].zone_name
FROM
	nyc_taxi..['2018_nyc_taxi_data']
	INNER JOIN nyc_taxi..['taxi_zones'] 
	ON nyc_taxi..['2018_nyc_taxi_data'].DOLocationID = nyc_taxi..['taxi_zones'].LocationID


-- How does the average trip look like?
SELECT
	AVG(passenger_count) AS avg_no_passenger,
	AVG(trip_distance) AS avg_distance_miles,
	AVG(total_amount) AS avg_cost_usd
FROM 
	nyc_taxi..['2018_nyc_taxi_data']

-- How does the customer pay for their rides?
SELECT
	payment_type, COUNT(payment_type) AS no_of_payments
FROM 
	nyc_taxi..['2018_nyc_taxi_data']
GROUP BY
	payment_type
ORDER BY
	no_of_payments DESC


-- Where are customer getting picked up and dropped off?
SELECT
	PUZone, COUNT(*) AS no_of_picked_up_trips
FROM
	nyc_taxi..['2018_nyc_taxi_data']
GROUP BY
	PUZONE
ORDER BY
	no_of_picked_up_trips DESC;

SELECT
	DOZone, COUNT(*) AS no_of_dropped_off_trips
FROM
	nyc_taxi..['2018_nyc_taxi_data']
GROUP BY
	DOZONE
ORDER BY
	no_of_dropped_off_trips DESC;

SELECT *
FROM nyc_taxi..['2018_nyc_taxi_data']

