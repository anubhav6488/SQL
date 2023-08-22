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
    ('ashutosh', 'mishra'),
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

-- Construct the dynamic SQL statement for inserting data
DECLARE @columns NVARCHAR(MAX);
DECLARE @sql NVARCHAR(MAX);

SET @columns = STUFF((
    SELECT ', ' + QUOTENAME(column_name)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'employees_destination'
    FOR XML PATH('')
), 1, 2, '');

SET @sql = N'
    INSERT INTO employees_destination (' + @columns + ')
    SELECT ' + @columns + '
    FROM employees_source;
';

-- Execute the dynamic SQL statement
EXEC sp_executesql @sql;

-- Disable IDENTITY_INSERT for employees_destination table
SET IDENTITY_INSERT employees_destination OFF;

-- Select data from destination table to verify
SELECT * FROM employees_destination;
