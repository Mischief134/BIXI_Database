DROP TABLE trips;

CREATE TABLE trips(
  s_time TIMESTAMP NOT NULL,
  e_time TIMESTAMP,
  userID INT NOT NULL,
  startsAt INT,
  endsAt INT,
  serialNB INT,
  vType VARCHAR,
  FOREIGN KEY (startsAt) REFERENCES stations(sid),
  FOREIGN KEY (endsAt) REFERENCES stations(sid),
  FOREIGN KEY (userID) REFERENCES users(userid),
  FOREIGN KEY (serialNB) REFERENCES vehicles(serialnb),
  FOREIGN KEY (vType) REFERENCES vehicletypes(vType),
  PRIMARY KEY (s_time, userID)
);

DO $$
  DECLARE
    carCount INTEGER := 0;
    bikeCount INTEGER := 0;
    randomStartTime TIMESTAMP;
    randomEndTime TIMESTAMP;
    randomUID INT;
    randomStartsAt INT;
    randomEndsAt INT;
    randomSerialNb INT;
    randomType VARCHAR;
    tempTime TIMESTAMP;


  BEGIN
    <<generate>>
    LOOP
      randomStartTime = TIMESTAMP
        '2014-01-01 20:00:00' + random() * (TIMESTAMP '2019-01-01 00:00:00' - TIMESTAMP '2014-01-01 20:00:00');
      randomEndTime := randomStartTime + random() * (randomStartTime + '14 days' - randomStartTime);
      tempTime := randomStartTime;
      randomStartTime := least(randomStartTime, randomEndTime);
      randomEndTime := greatest(tempTime, randomEndTime);

      SELECT userid INTO randomUID FROM users ORDER BY random() limit 1;
      SELECT sid INTO randomStartsAt FROM stations ORDER BY random() limit 1;
      SELECT sid INTO randomEndsAt FROM stations ORDER BY random() limit 1;

      IF carCount > bikeCount
      THEN
        randomType = 'bike';
        bikeCount := bikeCount + 1;
      ELSE
        randomType = 'regular car';
        carCount := carCount + 1;
      END IF;

      SELECT serialnb INTO randomSerialNb FROM vehicles WHERE vType = randomType ORDER BY random() limit 1;
      INSERT INTO trips VALUES(randomStartTime, randomEndTime, randomUID, randomStartsAt, randomEndsAt, randomSerialNb, randomType);
      EXIT generate WHEN (carCount + bikeCount) >= 100;
    END LOOP;
  END;
  $$
