DROP TABLE plans;
CREATE TABLE plans
(
    name VARCHAR(128) PRIMARY KEY,
    price numeric(8,2) CONSTRAINT positive_price CHECK (price > 0)
);

INSERT INTO plans VALUES 
('1-day biking', 7.99),
('1-day biking+ (inc. electric bikes)', 9.99),
('1-day car rental', 24.99),
('3-days biking', 14.99),
('3-days biking+ (inc. electric bikes)', 19.99),
('3-days car rental', 49.99),
('3-days combo (inc. all bikes and cars)', 59.99),
('7-days biking', 24.99),
('7-days biking+', 29.99),
('7-days car rental', 59.99),
('7-days combo (inc. all bikes and cars)', 69.99),
('1-trip biking', 2.99),
('1-trip biking+ (electric bikes)', 3.99),
('2-trips biking', 3.99),
('2-trips biking+ (electric bikes)', 5.99),
('10-trips biking', 19.99),
('10-trips biking+ (electric bikes)', 29.99),
('1-month biking', 39.99),
('1-month biking+ (electric bikes)', 49.99),
('1-month car rental', 99.99),
('1-month combo (inc. all bikes and cars)', 119.99),
('1-month biking - Reduced fare', 29.99),
('1-month biking+ (electric bikes) - Reduced fare', 39.99),
('1-month car rental - Reduced fare', 79.99),
('1-month combo (inc. all bikes and cars) - Reduced fare', 99.99),
('All year biking', 399.99),
('All year biking+', 499.99),
('All year car rental', 999.99),
('All year combo (inc. all bikes and cars)', 1199.99),
('All year biking - Reduced fare', 299.99),
('All year biking+ (electric bikes) - Reduced fare', 399.99),
('All year car rental - Reduced fare', 799.99),
('All year combo (inc. all bikes and cars) - Reduced fare', 999.99),
('1-day coverage - regular cars', 9.99),
('3-days coverage - regular cars', 19.99),
('7-days coverage - regular cars', 39.99),
('1-month coverage - regular cars', 79.99),
('1-year coverage - regular cars', 799.99),
('1-day coverage - luxury cars', 19.99),
('3-days coverage - luxury cars', 29.99),
('7-days coverage - luxury cars', 49.99),
('1-month coverage - luxury cars', 99.99),
('1-year coverage - luxury cars', 999.99);

DROP TABLE limited;
CREATE TABLE limited
(
    name VARCHAR(128) PRIMARY KEY,
    maxTrips INTEGER NOT NULL CONSTRAINT positive_trips CHECK (maxTrips > 0),
    FOREIGN KEY(name) REFERENCES plans(name)
);

INSERT INTO limited VALUES 
('1-trip biking', 1),
('1-trip biking+ (electric bikes)', 1),
('2-trips biking', 2),
('2-trips biking+ (electric bikes)', 2),
('10-trips biking', 10),
('10-trips biking+ (electric bikes)', 10);

DROP TABLE unlimited;
CREATE TABLE unlimited
(
    name VARCHAR(128) PRIMARY KEY,
    duration INTEGER NOT NULL CONSTRAINT positive_duration CHECK (duration > 0),
    FOREIGN KEY(name) REFERENCES plans(name)
);

INSERT INTO unlimited VALUES 
('1-day biking', 1),
('1-day biking+ (inc. electric bikes)', 1),
('1-day car rental', 1),
('3-days biking', 3),
('3-days biking+ (inc. electric bikes)', 3),
('3-days car rental', 3),
('3-days combo (inc. all bikes and cars)', 3),
('7-days biking', 7),
('7-days biking+', 7),
('7-days car rental', 7),
('7-days combo (inc. all bikes and cars)', 7),
('1-month biking', 30),
('1-month biking+ (electric bikes)', 30),
('1-month car rental', 30),
('1-month combo (inc. all bikes and cars)', 30),
('1-month biking - Reduced fare', 30),
('1-month biking+ (electric bikes) - Reduced fare', 30),
('1-month car rental - Reduced fare', 30),
('1-month combo (inc. all bikes and cars) - Reduced fare', 30),
('All year biking', 365),
('All year biking+', 365),
('All year car rental', 365),
('All year combo (inc. all bikes and cars)', 365),
('All year biking - Reduced fare', 365),
('All year biking+ (electric bikes) - Reduced fare', 365),
('All year car rental - Reduced fare', 365),
('All year combo (inc. all bikes and cars) - Reduced fare', 365);

DROP TABLE insurance;
CREATE TABLE insurance
(
    name VARCHAR(128) PRIMARY KEY,
    coverage INTEGER NOT NULL CONSTRAINT positive_coverage CHECK (coverage > 0),
    duration INTEGER NOT NULL CONSTRAINT positive_duration CHECK (duration > 0),
    FOREIGN KEY(name) REFERENCES plans(name)
);

INSERT INTO insurance VALUES 
('1-day coverage - regular cars', 10000, 1),
('3-days coverage - regular cars', 30000, 3),
('7-days coverage - regular cars', 100000, 7),
('1-month coverage - regular cars', 1000000, 30),
('1-year coverage - regular cars', 3000000, 365),
('1-day coverage - luxury cars', 30000, 1),
('3-days coverage - luxury cars', 100000, 3),
('7-days coverage - luxury cars', 1000000, 7),
('1-month coverage - luxury cars', 5000000, 30),
('1-year coverage - luxury cars', 50000000, 365);

