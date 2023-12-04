CREATE DATABASE store;
USE store;

-- #####################Entity#######################

CREATE TABLE Customer (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Sex ENUM('M', 'F', 'O') NOT NULL, -- Assuming 'M' for male, 'F' for female, 'O' for other
    UserName VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Phone VARCHAR(20) NULL,
    Province VARCHAR(255) NULL,
    District VARCHAR(255) NULL,
    Ward VARCHAR(255) NULL,
    Street VARCHAR(255) NULL
    -- Include additional attributes and constraints as necessary.
);

CREATE TABLE Branch (
    Branch_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Province VARCHAR(255) NOT NULL,
    District VARCHAR(255) NOT NULL,
    Ward VARCHAR(255) NOT NULL,
    Street VARCHAR(255) NOT NULL
);

CREATE TABLE Employee (
    Employee_ID INT AUTO_INCREMENT PRIMARY KEY,
    UserName VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Phone_Number VARCHAR(20) NULL,
    DoB DATE NULL,
    Sex ENUM('M', 'F', 'O') NOT NULL, -- Assuming 'M' for male, 'F' for female, 'O' for other
    Email VARCHAR(255) UNIQUE NOT NULL,
    Date_of_Lease DATE NULL,
    Salary DECIMAL(10, 2) NULL, -- Assuming salary will have two decimal places.
    Job_Type VARCHAR(255) NULL,
    Branch_ID INT NULL,
    Manager_ID INT NULL,
    FOREIGN KEY (Manager_ID) REFERENCES Employee(Employee_ID)
);

CREATE TABLE Promotion (
    Promotion_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Application_Date DATE NOT NULL,
    Expiration_Date DATE NOT NULL,
    Application_Terms TEXT NOT NULL,
    Maximum_Discount DECIMAL(5, 2) NOT NULL,
    Discount_Method ENUM('PERCENTAGE', 'AMOUNT') NOT NULL
);

CREATE TABLE Delivery (
    Delivery_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL
);

CREATE TABLE `Order` (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_Date DATETIME NOT NULL,
    Note TEXT,
    Status ENUM('PROCESSING', 'CONFIRMED', 'COMPLETED', 'CANCELLED') NOT NULL,
    Total_Price DECIMAL(10, 2) NOT NULL,
    Customer_ID INT,
    Cashier_ID INT,
    Branch_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Cashier_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID)
);

CREATE TABLE Bill (
    Bill_ID INT AUTO_INCREMENT PRIMARY KEY,
    Feedback TEXT,
    Customer_ID INT,
    Order_ID INT NOT NULL,
    Bill_Date DATE NOT NULL,
    Delivery_Fee DECIMAL(10, 2) NOT NULL,
    Total_Price DECIMAL(10, 2) NOT NULL,
    Method ENUM('CASH', 'MOMO', 'BANKING') NOT NULL,
    Promotion_ID INT,
    Discount_Price DECIMAL(10, 2),
    Discount_Percent DECIMAL(5, 2),
    FOREIGN KEY (Promotion_ID) REFERENCES Promotion(Promotion_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Order_ID) REFERENCES `Order`(Order_ID)
);

CREATE TABLE Items (
    Item_ID VARCHAR(10) PRIMARY KEY,
    Current_Price DECIMAL(10, 2) NOT NULL,
    `Type` ENUM('Product', 'Combo') NOT NULL
);

CREATE TABLE Beverage (
    Beverage_ID INT AUTO_INCREMENT PRIMARY KEY,
    BeverageType VARCHAR(255) NOT NULL
);

CREATE TABLE Food (
    Food_ID INT AUTO_INCREMENT PRIMARY KEY,
    FoodType VARCHAR(255) NOT NULL
);

CREATE TABLE Product (
    Product_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Description TEXT,
    Photo VARCHAR(255),
    Item_ID VARCHAR(10),
    Size VARCHAR(5),
    Food_ID INT,
    Beverage_ID INT,
    FOREIGN KEY (Food_ID) REFERENCES Food(Food_ID),
    FOREIGN KEY (Beverage_ID) REFERENCES Beverage(Beverage_ID),
    FOREIGN KEY (Item_ID) REFERENCES Items(Item_ID)
);

CREATE TABLE Combo (
    Combo_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    Photo VARCHAR(255),
    Item_ID VARCHAR(10),
    FOREIGN KEY (Item_ID) REFERENCES Items(Item_ID)
);

-- #####################Relationship#######################

CREATE TABLE Transport (
    Bill_ID INT,
    Delivery_ID INT,
    Delivery_Date DATE,
    Shipper_Name VARCHAR(255),
    Shipper_Phone VARCHAR(20),
    Shipper_Vehicle VARCHAR(255),
    Shipper_VehicleID VARCHAR(255),
    PRIMARY KEY (Bill_ID, Delivery_ID),
    FOREIGN KEY (Bill_ID) REFERENCES Bill(Bill_ID),
    FOREIGN KEY (Delivery_ID) REFERENCES Delivery(Delivery_ID)
);

CREATE TABLE Event (
    Branch_ID INT,
    Promotion_ID INT,
    PRIMARY KEY (Branch_ID, Promotion_ID),
    FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID),
    FOREIGN KEY (Promotion_ID) REFERENCES Promotion(Promotion_ID)
);

CREATE TABLE Order_Line (
    Order_ID INT,
    Item_ID VARCHAR(10),
    Quantity INT NOT NULL,
    Total_Price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (Order_ID, Item_ID),
    FOREIGN KEY (Order_ID) REFERENCES `Order`(Order_ID),
    FOREIGN KEY (Item_ID) REFERENCES Items(Item_ID)
);

CREATE TABLE Combo_List (
    Combo_ID INT,
    Product_ID INT,
    Quantity INT NOT NULL,
    PRIMARY KEY (Combo_ID, Product_ID),
    FOREIGN KEY (Combo_ID) REFERENCES Combo(Combo_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);









