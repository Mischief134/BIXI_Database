--Choose a random user to receive a free one year car plan

SELECT setval('transactions_tranid_seq', (SELECT MAX(tranID) from transactions));
INSERT INTO transactions (userid, name, status, date, subtotal)
SELECT users.userid, 'All year combo (inc. all bikes and cars) - Reduced fare', 3, NOW(), 0
FROM users
ORDER BY random()
LIMIT 1;

--Grab all the vehicles that were at station 6153 at a given time and damage them (natural disaster)
UPDATE vehicles
SET veh_state = 'damaged'
WHERE vehicles.serialnb IN
(SELECT trips.serialnb FROM trips WHERE trips.endsat = 6248 AND '2014-01-01' <= trips.e_time AND trips.e_time <= '2015-01-01');


--Double the capacity of the most popular station
UPDATE accepts
SET capacity = capacity*2
WHERE accepts.stationid = (SELECT sID FROM
                            (SELECT sID, sum(c) AS s FROM
                              (
                                SELECT startsat as sID, count(startsat) as c
                                FROM trips
                                GROUP BY startsat
                                UNION
                                SELECT endsat, count(endsat) FROM trips
                                GROUP BY endsat) ustations
                                GROUP BY sID
                                ORDER BY s DESC LIMIT 1) as popularities);
