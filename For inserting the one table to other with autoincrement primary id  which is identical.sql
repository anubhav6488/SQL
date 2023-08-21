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
    ('himanshu', 'mishra'),
    ('ashutosh', 'mishra');

-- Create destination table
CREATE TABLE employees_destination (
    id INT IDENTITY(1,1),
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
INSERT INTO employees_destination (first_name, last_name)
VALUES
    ('vaibhav', 'singh'),
    ('priyanshu', 'sahu'),
    ('aditi', 'sahu'),
    ('abhinav', 'singh');

-- Enable IDENTITY_INSERT for employees_destination table
SET IDENTITY_INSERT employees_destination ON;

-- Insert all data from employees_source into employees_destination
INSERT INTO employees_destination (id, first_name, last_name)
SELECT id, first_name, last_name
FROM employees_source;

-- Disable IDENTITY_INSERT for employees_destination table
SET IDENTITY_INSERT employees_destination OFF;

-- Select data from destination table to verify
SELECT * FROM employees_destination;
