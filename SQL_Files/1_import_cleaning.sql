-- Creating the tables: members, attendance, engagement, and cancellations

CREATE TABLE members(
    member_id INT PRIMARY KEY,
    join_date DATE,
    gender VARCHAR(20),
    age INT,
    fitness_goal VARCHAR(50),
    sign_up_method VARCHAR(20),
    fitness_activity VARCHAR(20),
    fitness_level VARCHAR(20)
);

CREATE TABLE attendance(
    attendance_id INT PRIMARY KEY,
    member_id INT,
    attendance_start_time TIMESTAMP,
    attendance_end_time TIMESTAMP,
    duration FLOAT,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE engagement(
    reasons_id INT PRIMARY KEY,
    member_id INT,
    stay_reason VARCHAR(30),
    length_of_membership INT,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE cancellations (
    cancel_reason_id INT PRIMARY KEY,
    member_id INT,
    cancel_date DATE,
    cancel_reason VARCHAR(30),
    length_of_membership INT,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
)


-- Importing the data onto the tables

COPY members
FROM 'C:\Users\simon\OneDrive\Documents\Desktop\FITNESS FACILITIES RETENTION\2_cleaned_datasets\members.csv'
DELIMITER ',' CSV HEADER;

COPY attendance
FROM 'C:\Users\simon\OneDrive\Documents\Desktop\FITNESS FACILITIES RETENTION\2_cleaned_datasets\attendance.csv'
DELIMITER ',' CSV HEADER;

COPY engagement
FROM 'C:\Users\simon\OneDrive\Documents\Desktop\FITNESS FACILITIES RETENTION\2_cleaned_datasets\engagement.csv'
DELIMITER ',' CSV HEADER;

COPY cancellations
FROM 'C:\Users\simon\OneDrive\Documents\Desktop\FITNESS FACILITIES RETENTION\2_cleaned_datasets\cancellations.csv'
DELIMITER ',' CSV HEADER;


