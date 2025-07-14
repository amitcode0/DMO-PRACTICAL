-- Step 1: Create the database
CREATE DATABASE IF NOT EXISTS OnlineRetailDB;
USE OnlineRetailDB;

-- Step 2: Create Customers table
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Address TEXT
);

-- Step 3: Create Suppliers table
CREATE TABLE Suppliers (
    Supplier_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Contact_Info TEXT
);

-- Step 4: Create Products table
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Supplier_ID INT,
    Price DECIMAL(10,2) CHECK (Price >= 0),
    FOREIGN KEY (Supplier_ID) REFERENCES Suppliers(Supplier_ID)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Step 5: Create Inventory table
CREATE TABLE Inventory (
    Product_ID INT PRIMARY KEY,
    Quantity_Available INT DEFAULT 0 CHECK (Quantity_Available >= 0),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Step 6: Create Orders table
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT,
    Order_Date DATE NOT NULL,
    Status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Step 7: Create Order_Items table (Bridge Table)
CREATE TABLE Order_Items (
    Order_ID INT,
    Product_ID INT,
    Quantity INT CHECK (Quantity > 0),
    Price DECIMAL(10,2) CHECK (Price >= 0),
    PRIMARY KEY (Order_ID, Product_ID),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Step 8: Create Payments table
CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT UNIQUE,
    Amount DECIMAL(10,2) NOT NULL CHECK (Amount >= 0),
    Payment_Date DATE NOT NULL,
    Method VARCHAR(50) NOT NULL,
    Status VARCHAR(50) DEFAULT 'Success',
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
