select users.age, count(users.userid) as Members from users join trips on users.userid = trips.userid group by users.age order by users.age asc;