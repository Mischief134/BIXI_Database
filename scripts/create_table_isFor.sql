DROP TABLE isFor;

CREATE TABLE isFor(
  name VARCHAR,
  vType VARCHAR,
  FOREIGN KEY (name) REFERENCES plans(name),
  PRIMARY KEY (name, vType)
);

