CREATE DATABASE SalesOrdersModify
GO

use SalesOrdersModify
GO

CREATE TABLE Categories (
	CategoryID int IDENTITY (1, 1) NOT NULL ,
	CategoryDescription nvarchar (75) NULL 
)
GO

CREATE TABLE Customers (
	CustomerID int IDENTITY (1, 1) NOT NULL ,
	CustFirstName nvarchar (25) NULL ,
	CustLastName nvarchar (25) NULL ,
	CustStreetAddress nvarchar (50) NULL ,
	CustCity nvarchar (30) NULL ,
	CustState nvarchar (2) NULL ,
	CustZipCode nvarchar (10) NULL ,
	CustAreaCode smallint NULL ,
	CustPhoneNumber nvarchar (8) NULL 
)
GO

CREATE TABLE Employees (
	EmployeeID int IDENTITY (1, 1) NOT NULL ,
	EmpFirstName nvarchar (25) NULL ,
	EmpLastName nvarchar (25) NULL ,
	EmpStreetAddress nvarchar (50) NULL ,
	EmpCity nvarchar (30) NULL ,
	EmpState nvarchar (2) NULL ,
	EmpZipCode nvarchar (10) NULL ,
	EmpAreaCode smallint NULL ,
	EmpPhoneNumber nvarchar (8) NULL 
)
GO

CREATE TABLE Order_Details (
	OrderNumber int NOT NULL ,
	ProductNumber int NOT NULL ,
	QuotedPrice money NULL ,
	QuantityOrdered smallint NULL 
)
GO

CREATE TABLE Order_Details_Archive (
	OrderNumber int NOT NULL ,
	ProductNumber int NOT NULL ,
	QuotedPrice money NULL ,
	QuantityOrdered smallint NULL 
)
GO

CREATE TABLE Orders (
	OrderNumber int IDENTITY (1, 1) NOT NULL ,
	OrderDate date NULL ,
	ShipDate date NULL ,
	CustomerID int NULL ,
	EmployeeID int NULL ,
	OrderTotal money NULL 
)
GO

CREATE TABLE Orders_Archive (
	OrderNumber int NOT NULL ,
	OrderDate date NULL ,
	ShipDate date NULL ,
	CustomerID int NULL ,
	EmployeeID int NULL ,
	OrderTotal money NULL 
)
GO

CREATE TABLE Product_Vendors (
	ProductNumber int NOT NULL ,
	VendorID int NOT NULL ,
	WholesalePrice money NULL ,
	DaysToDeliver smallint NULL 
)
GO

CREATE TABLE Products (
	ProductNumber int IDENTITY (1, 1) NOT NULL ,
	ProductName nvarchar (50) NULL ,
	ProductDescription nvarchar (100) NULL ,
	RetailPrice money NULL ,
	QuantityOnHand smallint NULL ,
	CategoryID int NULL 
)
GO

CREATE TABLE Vendors (
	VendorID int IDENTITY (1, 1) NOT NULL ,
	VendName nvarchar (25) NULL ,
	VendStreetAddress nvarchar (50) NULL ,
	VendCity nvarchar (30) NULL ,
	VendState nvarchar (2) NULL ,
	VendZipCode nvarchar (10) NULL ,
	VendPhoneNumber nvarchar (15) NULL ,
	VendFaxNumber nvarchar (15) NULL ,
	VendWebPage ntext NULL ,
	VendEMailAddress nvarchar (50) NULL ,
) 
GO

ALTER TABLE Categories ADD 
	CONSTRAINT Categories_PK PRIMARY KEY    
	(
		CategoryID
	)  
GO

ALTER TABLE Customers ADD 
	CONSTRAINT Cust_Area_Code_Default DEFAULT (0) FOR CustAreaCode,
	CONSTRAINT Customers_PK PRIMARY KEY    
	(
		CustomerID
	)  
GO

 CREATE  INDEX CustAreaCode ON Customers(CustAreaCode)
GO

 CREATE  INDEX CustZipCode ON Customers(CustZipCode)
GO

ALTER TABLE Employees ADD 
	CONSTRAINT Emp_Area_Code_Default DEFAULT (0) FOR EmpAreaCode,
	CONSTRAINT Employees_PK PRIMARY KEY    
	(
		EmployeeID
	)  
GO

 CREATE  INDEX EmpAreaCode ON Employees(EmpAreaCode)
GO

 CREATE  INDEX EmpZipCode ON Employees(EmpZipCode)
GO

ALTER TABLE Order_Details ADD 
	CONSTRAINT OD_Order_Number_Default DEFAULT (0) FOR OrderNumber,
	CONSTRAINT OD_Product_Number_Default DEFAULT (0) FOR ProductNumber,
	CONSTRAINT Quoted_Price_Default DEFAULT (0) FOR QuotedPrice,
	CONSTRAINT Quantity_Ordered_Default DEFAULT (0) FOR QuantityOrdered,
	CONSTRAINT Order_Details_PK PRIMARY KEY    
	(
		OrderNumber,
		ProductNumber
	)  
GO

 CREATE  INDEX OrdersOrder_Details ON Order_Details(OrderNumber)
GO

 CREATE  INDEX ProductsOrder_Details ON Order_Details(ProductNumber)
GO

ALTER TABLE Order_Details_Archive ADD 
	CONSTRAINT ODA_Order_Number_Default DEFAULT (0) FOR OrderNumber,
	CONSTRAINT ODA_Product_Number_Default DEFAULT (0) FOR ProductNumber,
	CONSTRAINT ODA_Quoted_Price_Default DEFAULT (0) FOR QuotedPrice,
	CONSTRAINT ODA_Quantity_Ordered_Default DEFAULT (0) FOR QuantityOrdered,
	CONSTRAINT Order_Details_Archive_PK PRIMARY KEY    
	(
		OrderNumber,
		ProductNumber
	)  
GO

 CREATE  INDEX Orders_ArchiveOrder_Details_Archive ON Order_Details_Archive(OrderNumber)
GO

ALTER TABLE Orders ADD 
	CONSTRAINT O_Customer_ID_Default DEFAULT (0) FOR CustomerID,
	CONSTRAINT O_Employee_ID_Default DEFAULT (0) FOR EmployeeID,
	CONSTRAINT Order_Total_Default DEFAULT (0) FOR OrderTotal,
	CONSTRAINT Orders_PK PRIMARY KEY    
	(
		OrderNumber
	)  
GO

 CREATE  INDEX CustomerID ON Orders(CustomerID)
GO

 CREATE  INDEX EmployeeID ON Orders(EmployeeID)
GO

ALTER TABLE Orders_Archive ADD 
	CONSTRAINT OA_Order_Number_Default DEFAULT (0) FOR OrderNumber,
	CONSTRAINT OA_Customer_ID_Default DEFAULT (0) FOR CustomerID,
	CONSTRAINT OA_Employee_ID_Default DEFAULT (0) FOR EmployeeID,
	CONSTRAINT OA_Order_Total_Default DEFAULT (0) FOR OrderTotal,
	CONSTRAINT Orders_Archive_PK PRIMARY KEY    
	(
		OrderNumber
	)  
GO

 CREATE  INDEX CustomerID ON Orders_Archive(CustomerID)
GO

 CREATE  INDEX EmployeeID ON Orders_Archive(EmployeeID)
GO

ALTER TABLE Product_Vendors ADD 
	CONSTRAINT PV_Product_Number_Default DEFAULT (0) FOR ProductNumber,
	CONSTRAINT PV_Vendor_ID_Default DEFAULT (0) FOR VendorID,
	CONSTRAINT Wholesale_Price_Default DEFAULT (0) FOR WholesalePrice,
	CONSTRAINT Days_To_Deliver_Default DEFAULT (0) FOR DaysToDeliver,
	CONSTRAINT Product_Vendors_PK PRIMARY KEY    
	(
		ProductNumber,
		VendorID
	)  
GO

 CREATE  INDEX ProductsProduct_Vendors ON Product_Vendors(ProductNumber)
GO

 CREATE  INDEX VendorID ON Product_Vendors(VendorID)
GO

ALTER TABLE Products ADD 
	CONSTRAINT Retail_Price_Default DEFAULT (0) FOR RetailPrice,
	CONSTRAINT Quantity_On_Hand_Default DEFAULT (0) FOR QuantityOnHand,
	CONSTRAINT P_Category_ID_Default DEFAULT (0) FOR CategoryID,
	CONSTRAINT Products_PK PRIMARY KEY    
	(
		ProductNumber
	)  
GO

 CREATE  INDEX CategoryID ON Products(CategoryID)
GO

ALTER TABLE Vendors ADD 
	CONSTRAINT Vendors_PK PRIMARY KEY    
	(
		VendorID
	)  
GO

 CREATE  INDEX VendZipCode ON Vendors(VendZipCode)
GO

ALTER TABLE Order_Details ADD 
	CONSTRAINT Order_Details_FK00 FOREIGN KEY 
	(
		OrderNumber
	) REFERENCES Orders (
		OrderNumber
	),
	CONSTRAINT Order_Details_FK01 FOREIGN KEY 
	(
		ProductNumber
	) REFERENCES Products (
		ProductNumber
	)
GO

ALTER TABLE Order_Details_Archive ADD 
	CONSTRAINT Order_Details_Archive_FK00 FOREIGN KEY 
	(
		OrderNumber
	) REFERENCES Orders_Archive (
		OrderNumber
	)
GO

ALTER TABLE Orders ADD 
	CONSTRAINT Orders_FK00 FOREIGN KEY 
	(
		CustomerID
	) REFERENCES Customers (
		CustomerID
	),
	CONSTRAINT Orders_FK01 FOREIGN KEY 
	(
		EmployeeID
	) REFERENCES Employees (
		EmployeeID
	)
GO

ALTER TABLE Product_Vendors ADD 
	CONSTRAINT Product_Vendors_FK00 FOREIGN KEY 
	(
		ProductNumber
	) REFERENCES Products (
		ProductNumber
	),
	CONSTRAINT Product_Vendors_FK01 FOREIGN KEY 
	(
		VendorID
	) REFERENCES Vendors (
		VendorID
	)
GO

ALTER TABLE Products ADD 
	CONSTRAINT Products_FK00 FOREIGN KEY 
	(
		CategoryID
	) REFERENCES Categories (
		CategoryID
	)
GO

