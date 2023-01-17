CREATE TABLE training 
(
    id INTEGER PRIMARY KEY NOT NULL,
    lastName STRING,
    phone STRING,
    email STRING
);

CREATE TABLE exercise 
(
    id INTEGER PRIMARY KEY NOT NULL,
    training_id INTEGER NOT NULL,
    name STRING,
    FOREIGN KEY (training_id) REFERENCES training (id)
);

CREATE TABLE set
(
    id INTEGER PRIMARY KEY NOT NULL,
    exercise_id INTEGER NOT NULL,
    reps INTEGER,
    weight REAL,
    FOREIGN KEY (exercise_id) REFERENCES exercise (id)
);