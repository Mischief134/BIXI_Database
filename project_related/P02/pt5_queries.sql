-- Do 5 SELECT queries on our data (each need to show some feature of sql

--1) Find out the most recent plan associated to a user

SELECT transactions.name, transactions.date, users.userid
FROM transactions
INNER JOIN users
ON users.userid = transactions.userid
WHERE users.userid = 1
ORDER BY transactions.date
LIMIT 1;


--2) Determine the closest station to a users given location
--   Assume users location is given by application and is equal to 45.52027053, -73.61484915:

DROP FUNCTION distance(double precision,double precision,double precision,double precision);
CREATE OR REPLACE FUNCTION distance(lat1 FLOAT, long1 FLOAT, lat2 FLOAT, long2 FLOAT)
  RETURNS FLOAT AS $distance$

  DECLARE
    distance VARCHAR;

  BEGIN
    distance := 2 * 3961 * asin(sqrt((sin(radians((lat2 - lat1) / 2))) ^ 2 + cos(radians(lat1)) * cos(radians(lat2)) * (sin(radians((long2 - long1) / 2))) ^ 2));
    RETURN distance;
  END;
  $distance$ LANGUAGE plpgsql;

SELECT stations.name, distance(stations.lat, stations.long, 45.5003823414, -73.575072341) as dist FROM stations
ORDER BY dist
LIMIT 1;

--See which insurance plans a user has purchased, ensuring its not expired.
SELECT transactions.name, transactions.date, users.userid
FROM transactions
INNER JOIN users
ON users.userid = transactions.userid
WHERE users.userid = 3
  AND transactions.name IN (SELECT insurance.name FROM insurance)
  AND transactions.date::TIMESTAMP + (SELECT insurance.duration || ' days' FROM insurance
                            WHERE insurance.name = transactions.name)::INTERVAL >= NOW()

