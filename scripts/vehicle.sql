DROP TABLE Vehicles;
DROP TABLE VehicleTypes;

CREATE TABLE VehicleTypes(
	vType VARCHAR PRIMARY KEY
);

CREATE TABLE Vehicles(
	serialNb SERIAL PRIMARY KEY,
	make VARCHAR,
	model VARCHAR,
	veh_state VARCHAR,
	capacity int,
	vType VARCHAR,
	FOREIGN KEY (vType) REFERENCES VehicleTypes(vType)
);

INSERT INTO VehicleTypes(vType)
VALUES
('car'),
('bike'),
('electric bikes'),
('regular cars'),
('luxury cars');






/*UPDATE vehicles SET capacity = 2 WHERE serialNb = 4;*/


insert into vehicles (make, model) values ('Jeep', 'Grand Cherokee');
insert into vehicles (make, model) values ('Mercedes-Benz', 'CL-Class');
insert into vehicles (make, model) values ('Volkswagen', 'Golf');
insert into vehicles (make, model) values ('Mazda', 'RX-7');
insert into vehicles (make, model) values ('Bentley', 'Continental GTC');
insert into vehicles (make, model) values ('Mazda', 'Mazda3');
insert into vehicles (make, model) values ('Volkswagen', 'Jetta');
insert into vehicles (make, model) values ('Honda', 'Prelude');
insert into vehicles (make, model) values ('Honda', 'Fit');
insert into vehicles (make, model) values ('Ford', 'Excursion');
insert into vehicles (make, model) values ('Infiniti', 'M');
insert into vehicles (make, model) values ('Alfa Romeo', '164');
insert into vehicles (make, model) values ('Dodge', 'Charger');
insert into vehicles (make, model) values ('Dodge', 'Dakota');
insert into vehicles (make, model) values ('Dodge', 'Challenger');
insert into vehicles (make, model) values ('Mercury', 'Grand Marquis');
insert into vehicles (make, model) values ('Ford', 'Mustang');
insert into vehicles (make, model) values ('Chevrolet', 'Tahoe');
insert into vehicles (make, model) values ('GMC', '1500');
insert into vehicles (make, model) values ('GMC', 'Savana 3500');
insert into vehicles (make, model) values ('Bentley', 'Continental Flying Spur');
insert into vehicles (make, model) values ('Chevrolet', 'Tracker');
insert into vehicles (make, model) values ('Saab', '9-5');
insert into vehicles (make, model) values ('Pontiac', 'Vibe');
insert into vehicles (make, model) values ('Hyundai', 'Sonata');
insert into vehicles (make, model) values ('Oldsmobile', 'Achieva');
insert into vehicles (make, model) values ('Saab', '9000');
insert into vehicles (make, model) values ('Ford', 'Explorer');
insert into vehicles (make, model) values ('Volvo', '960');
insert into vehicles (make, model) values ('Ford', 'Mustang');
insert into vehicles (make, model) values ('Hyundai', 'Tucson');
insert into vehicles (make, model) values ('Toyota', 'Sienna');
insert into vehicles (make, model) values ('Mercury', 'Villager');
insert into vehicles (make, model) values ('Chevrolet', 'Colorado');
insert into vehicles (make, model) values ('Mitsubishi', 'Chariot');
insert into vehicles (make, model) values ('BMW', 'X5');
insert into vehicles (make, model) values ('Buick', 'LaCrosse');
insert into vehicles (make, model) values ('Honda', 'Fit');
insert into vehicles (make, model) values ('GMC', 'Safari');
insert into vehicles (make, model) values ('Toyota', 'Corolla');
insert into vehicles (make, model) values ('Mitsubishi', 'Truck');
insert into vehicles (make, model) values ('Dodge', 'Ram 1500');
insert into vehicles (make, model) values ('Mercedes-Benz', 'CLS-Class');
insert into vehicles (make, model) values ('GMC', 'Savana');
insert into vehicles (make, model) values ('Kia', 'Rio');
insert into vehicles (make, model) values ('Hyundai', 'Sonata');
insert into vehicles (make, model) values ('Audi', 'A4');
insert into vehicles (make, model) values ('Bentley', 'Arnage');
insert into vehicles (make, model) values ('Mercury', 'Cougar');
insert into vehicles (make, model) values ('Ford', 'Expedition');

UPDATE Vehicles
SET    capacity = 5;

UPDATE Vehicles
SET    vType = 'regular cars';

UPDATE Vehicles
SET    veh_state = 'good shape';