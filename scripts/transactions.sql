DROP TABLE transactions;
CREATE TABLE transactions
(
    tranID SERIAL PRIMARY KEY, 
    userID INTEGER,
    name VARCHAR(128),
    status INTEGER NOT NULL,   
    date timestamp NOT NULL CONSTRAINT past_date CHECK (date <= NOW()::timestamp),
    subtotal numeric(8,2) NOT NULL CONSTRAINT positive_subtotal CHECK (subtotal > 0),
    FOREIGN KEY(userID) REFERENCES users(userID),
    FOREIGN KEY(name) REFERENCES plans(name),
    FOREIGN KEY(status) REFERENCES status(statID)
);

DROP TABLE status;
CREATE TABLE status 
(
    statID SERIAL PRIMARY KEY, 
    name VARCHAR(128)
);

INSERT INTO status VALUES 
(1, 'Pending'),
(2, 'Completed'),
(3, 'Cancelled');
