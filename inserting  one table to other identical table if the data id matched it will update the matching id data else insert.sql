-- Create source table
CREATE TABLE employees_source (
    id INT IDENTITY(1,1),
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Insert data into source table
INSERT INTO employees_source (first_name, last_name)
VALUES
    ('anubav', 'pratap'),
    ('atul', 'singh'),
    ('abhi', 'singh'),
    ('himanshu', 'mishra');
    

-- Create destination table
CREATE TABLE employees_destination (
    id INT IDENTITY(1,1),
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Insert data into destination table
INSERT INTO employees_destination (first_name, last_name)
VALUES
    ('vaibhav', 'singh'),
    ('priyanshu', 'sahu'),
    ('aditi', 'sahu'),
    ('abhinav', 'singh'),
    ('ashutosh', 'mishra');

-- Enable IDENTITY_INSERT for employees_destination table
SET IDENTITY_INSERT employees_destination ON;

-- Insert or update data in employees_destination based on matching ID
MERGE INTO employees_destination AS dest
USING employees_source AS src
ON dest.id = src.id
WHEN MATCHED THEN
    UPDATE SET
        dest.first_name = src.first_name,
        dest.last_name = src.last_name
WHEN NOT MATCHED BY TARGET THEN
    INSERT (id, first_name, last_name)
    VALUES (src.id, src.first_name, src.last_name);

-- Disable IDENTITY_INSERT for employees_destination table
SET IDENTITY_INSERT employees_destination OFF;

-- Select data from destination table to verify
SELECT * FROM employees_destination;
