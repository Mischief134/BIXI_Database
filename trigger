CREATE OR REPLACE FUNCTION update_vehicle_location() 
    RETURNS trigger AS
$BODY$
BEGIN
    UPDATE vehicles  
    SET station = NEW.endsat
    WHERE serialnb = NEW.serialnb;
    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER update_vehicle_location_trigger
  BEFORE INSERT OR UPDATE OF endsat ON trips
  FOR EACH ROW
  EXECUTE PROCEDURE update_vehicle_location();


UPDATE trips
SET endsat = 7030 
where s_time = '2019-03-24 13:20:00' and userid = 3;

 serialnb |     make      |          model          | veh_state  | capacity |     vtype     | station 
----------+---------------+-------------------------+------------+----------+---------------+---------
        1 | Jeep          | Grand Cherokee          | good shape |        7 | regular car   |        
        2 | Mercedes-Benz | CL-Class                | good shape |        2 | regular car   |        
        3 | Volkswagen    | Golf                    | good shape |        4 | regular car   |        
        4 | Honda         | Prelude                 | good shape |        2 | regular car   |        
        5 | Chevrolet     | Tahoe                   | good shape |        7 | regular car   |        
        7 | GMC           | Savana                  | good shape |        7 | regular car   |        
       11 | Ford          | Mustang                 | good_shape |        2 | luxury car    |    7030
