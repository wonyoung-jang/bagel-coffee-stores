-- SQL Script for Bagel Corner and Mister Coffee Database Management

-- Drop the existing database if it exists
-- This ensures a fresh start for the database setup
DROP DATABASE IF EXISTS BagelCornerMisterCoffeeDB;

-- Create main database
-- This database will store all the tables and data for both Bagel Corner and Mister Coffee.
CREATE DATABASE IF NOT EXISTS BagelCornerMisterCoffeeDB;
USE BagelCornerMisterCoffeeDB;

-- Table Creation Section
-- ----------------------------

-- Create COFFEE_SHOP table
-- This table stores basic information about various coffee shops, including their location.
CREATE TABLE COFFEE_SHOP (
    shop_id INT PRIMARY KEY,
    shop_name VARCHAR(50),
    city VARCHAR(50),
    state CHAR(2)
);

-- Create SUPPLIER table
-- This table contains details about suppliers, including contact information.
CREATE TABLE SUPPLIER (
    supplier_id INT PRIMARY KEY,
    company_name VARCHAR(50),
    country VARCHAR(30),
    sales_contact_name VARCHAR(60),
    email VARCHAR(50) NOT NULL
);

-- Create COFFEE table
-- This table stores information about different coffee types offered by the coffee shops.
CREATE TABLE COFFEE (
    coffee_id INT PRIMARY KEY,
    shop_id INT,
    supplier_id INT,
    coffee_name VARCHAR(50),
    price_per_pound NUMERIC(5 , 2 ),
	-- Foreign keys to establish relationships with COFFEE_SHOP and SUPPLIER tables
    FOREIGN KEY (shop_id) REFERENCES COFFEE_SHOP (shop_id),
    FOREIGN KEY (supplier_id) REFERENCES SUPPLIER (supplier_id)
);

-- Create EMPLOYEE table
-- This table includes details about the employees working in the coffee shops.
CREATE TABLE EMPLOYEE (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    hire_date DATE,
    job_title VARCHAR(30),
    shop_id INT,
	-- Foreign key to link to the COFFEE_SHOP table
    FOREIGN KEY (shop_idsys_configsys_config) REFERENCES COFFEE_SHOP (shop_id)
);

-- Data Insertion Section
-- ----------------------------

-- Inserting data into COFFEE_SHOP table
-- These entries are sample data to demonstrate the structure and usage of the table.
INSERT INTO COFFEE_SHOP (shop_id, shop_name, city, state)
	VALUES
	(0, 'Alfreds Coffee Shop', 'New York City', 'NY'),
	(1, 'Billys Coffee Shop', 'Madison', 'WI'),
	(2, 'Cedrics Coffee Shop', 'Morgantown', 'WV');

-- Inserting data into SUPPLIER table
-- Sample data for suppliers, showcasing the intended content for the table.
INSERT INTO SUPPLIER (supplier_id, company_name, country, sales_contact_name, email)
	VALUES
	(0, 'Alfred Supplier', 'USA', 'Mike Alfred', 'mikealfred@alfredcoffeesup.com'),
	(1, 'Billy Supplier', 'USA', 'John Billy', 'johnbilly@billycoffeesup.com'),
	(2, 'Cedric Supplier', 'USA', 'Jill Cedric', 'jillcedriccedric@coffeesup.com');

-- Inserting data into COFFEE table
-- Sample entries for different types of coffee available at the coffee shops.
INSERT INTO COFFEE (coffee_id, shop_id, supplier_id, coffee_name, price_per_pound)
	VALUES
	(0, 0, 0, 'Nicaruaga', 20.00),
	(1, 1, 1, 'Costa Rica', 25.00),
	(2, 2, 2, 'Guatemala', 27.00);

-- Inserting data into EMPLOYEE table
-- Adding sample employee records, including their roles and associated shop IDs.
INSERT INTO EMPLOYEE (employee_id, first_name, last_name, hire_date, job_title, shop_id)
	VALUES
	(0, 'Michael', 'Thompson', '2008-02-10', 'Cashier', 02),
	(1, 'Emily', 'Johnson', '2021-03-04', 'Manager', 00),
	(2, 'Sophia', 'Martinez', '2022-04-06', 'Barista', 01);

-- View Creation
-- ----------------------------

-- Create a view for employee details
-- This view combines first and last names for a complete name view, improving report readability.
CREATE VIEW EMPLOYEE_DETAILS AS
SELECT employee_id, CONCAT(first_name, ' ', last_name) AS full_name, hire_date, job_title, shop_id
FROM EMPLOYEE;

-- Index Creation
-- ----------------------------

-- Create an index on the coffee_name field in the COFFEE table
-- This index improves the performance of queries filtering by coffee_name.
CREATE INDEX idx_coffee_name ON COFFEE (coffee_name);
 
-- Query Section
-- ----------------------------

-- Simple SELECT-FROM-WHERE (SFW) query
-- This example demonstrates a basic query fetching details from a single table.
SELECT * FROM COFFEE_SHOP WHERE city = 'New York City';

-- Complex JOIN query
-- This query joins multiple tables to aggregate information across different aspects of the database.
SELECT E.full_name, C.coffee_name, CS.shop_name
FROM EMPLOYEE AS E
JOIN COFFEE_SHOP AS CS ON E.shop_id = CS.shop_id
JOIN COFFEE AS C ON CS.shop_id = C.shop_id
WHERE E.job_title = 'Barista';