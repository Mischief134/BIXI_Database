3) Get previous year total transactions for a user group by month

SELECT date_part('month', date) as month, SUM(subtotal)
FROM transactions INNER JOIN users ON transactions.userID = users.userID
WHERE date_part('year', date) = date_part('year', CURRENT_DATE) - 1
AND users.userID = 3
GROUP BY month
ORDER BY month;

4) List user's most used station

SELECT sID FROM
(SELECT startsat as sID, count(startsat) as c
FROM trips
WHERE userId = 11
GROUP BY startsat

UNION

SELECT endsat, count(endsat) 
FROM trips
WHERE userId = 11
GROUP BY endsat) ustations
GROUP BY sID
ORDER BY sum(c) DESC LIMIT 1;

