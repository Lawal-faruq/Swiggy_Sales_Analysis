-- Check if the database already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'SwiggySales')
BEGIN
    ALTER DATABASE SwiggySales 
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    -- Drop the existing database
    DROP DATABASE SwiggySales;
END
GO

-- Create a fresh instance of the database
CREATE DATABASE SwiggySales;
GO

-- Inspecting the imported data
SELECT *
FROM swiggy_data;
