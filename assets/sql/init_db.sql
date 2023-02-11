CREATE TABLE training 
(
    id INTEGER PRIMARY KEY NOT NULL,
    name STRING,
    date INTEGER
);

CREATE TABLE exercise 
(
    id INTEGER PRIMARY KEY NOT NULL,
    training_id INTEGER NOT NULL,
    name STRING,
    category STRING,
    sets INTEGER,
    reps INTEGER,
    weight REAL,
    FOREIGN KEY (training_id) REFERENCES training (id)
);
