CREATE VIEW CH04_Customer_States
AS 
SELECT DISTINCT CustState
FROM Customers;


CREATE VIEW CH04_Employee_Information
AS 
SELECT *
FROM Employees;


CREATE VIEW CH04_Product_Price_List
AS 
SELECT ProductName, RetailPrice
FROM Products;


CREATE VIEW CH04_Vendor_Locations
AS 
SELECT VendCity, VendName
FROM Vendors
ORDER BY VendCity;


CREATE VIEW CH04_Vendor_Names
AS 
SELECT VendName
FROM Vendors;


CREATE VIEW CH05_Adjusted_Wholesale_Prices
AS 
SELECT ProductNumber, WholesalePrice, WholeSalePrice-(WholeSalePrice*0.05) AS NewPrice
FROM Product_Vendors;


CREATE VIEW CH05_Orders_By_Customer_And_Date
AS 
SELECT CustomerID, OrderDate, OrderNumber
FROM Orders
ORDER BY CustomerID, OrderDate DESC , OrderNumber;


CREATE VIEW CH05_Product_Inventory_Value
AS 
SELECT ProductName, RetailPrice*QuantityOnHand AS InventoryValue
FROM Products;


CREATE VIEW CH05_Shipping_Days_Analysis
AS 
SELECT OrderNumber, OrderDate, ShipDate, DateDiff('d',OrderDate,ShipDate) AS DaysElapsed
FROM Orders;


CREATE VIEW CH05_Vendor_Addresses
AS 
SELECT VendName, VendStreetAddress || ', ' || VendCity || '  ' || VendState || '  ' || VendZipCode AS VendCompleteAddress, VendPhoneNumber
FROM Vendors
ORDER BY VendName;


CREATE VIEW CH06_Ballard_Bellevue_Redmond_Vendors
AS 
SELECT VendName, VendCity
FROM Vendors
WHERE VendCity In ('Ballard','Bellevue','Redmond')
ORDER BY VendName;


CREATE VIEW CH06_Orders_for_Customer_1001
AS 
SELECT OrderNumber, CustomerID
FROM Orders
WHERE CustomerID=1001;


CREATE VIEW CH06_Products_Priced_Over_125
AS 
SELECT ProductName, RetailPrice
FROM Products
WHERE RetailPrice>=125
ORDER BY ProductName;


CREATE VIEW CH06_Products_That_Begin_With_DOG
AS 
SELECT ProductName
FROM Products
WHERE ProductName Like 'Dog*'
ORDER BY ProductName;


CREATE VIEW CH06_Vendors_With_No_Website
AS 
SELECT VendName, VendWebPage
FROM Vendors
WHERE VendWebPage IS NULL
ORDER BY VendName;


CREATE VIEW CH08_Customers_And_OrderDates
AS 
SELECT (Customers.CustFirstName || ' ' || Customers.CustLastName) AS CustomerFullName, Orders.OrderDate
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
ORDER BY Orders.OrderDate;


CREATE VIEW CH08_Customers_Both_Bikes_And_Helmets
AS 
SELECT CustBikes.CustFirstName, CustBikes.CustLastName
FROM (SELECT DISTINCT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName FROM ((Customers
INNER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID)
INNER JOIN Order_Details
ON Orders.OrderNumber=Order_Details.OrderNumber)
INNER JOIN Products
ON Products.ProductNumber=Order_Details.ProductNumber WHERE Products.ProductName LIKE '*Bike')  AS CustBikes
INNER JOIN (SELECT DISTINCT Customers.CustomerID FROM ((Customers
INNER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID)
INNER JOIN Order_Details
ON Orders.OrderNumber=Order_Details.OrderNumber)
INNER JOIN Products
ON Products.ProductNumber=Order_Details.ProductNumber WHERE Products.ProductName LIKE '*Helmet')  AS CustHelmets
ON CustBikes.CustomerID=CustHelmets.CustomerID;


CREATE VIEW CH08_Customers_Employees_Same_City
AS 
SELECT Customers.CustFirstName, Customers.CustLastName, Employees.EmpFirstName, Employees.EmpLastName, Employees.EmpCity
FROM Customers
INNER JOIN Employees
ON Customers.CustCity=Employees.EmpCity;


CREATE VIEW CH08_Customers_Employees_Same_LastName
AS 
SELECT (Customers.CustFirstName || ' ' || Customers.CustLastName) AS CustFullName, (Employees.EmpFirstName || ' ' || Employees.EmpLastName) AS EmpFullName
FROM Customers
INNER JOIN Employees
ON Customers.CustLastName=Employees.EmpLastName;


CREATE VIEW CH08_Customers_Who_Ordered_Helmets
AS 
SELECT DISTINCT Customers.CustFirstName, Customers.CustLastName
FROM ((Customers
INNER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID)
INNER JOIN Order_Details
ON Orders.OrderNumber=Order_Details.OrderNumber)
INNER JOIN Products
ON Products.ProductNumber=Order_Details.ProductNumber
WHERE Products.ProductName LIKE '*Helmet*';


CREATE VIEW CH08_Employees_And_Customers
AS 
SELECT DISTINCT (Employees.EmpFirstName || ' ' || Employees.EmpLastName) AS EmpFullName, (Customers.CustFirstName || ' ' || Customers.CustLastName) AS CustFullName
FROM (Employees
INNER JOIN Orders
ON Employees.EmployeeID=Orders.EmployeeID)
INNER JOIN Customers
ON Customers.CustomerID=Orders.CustomerID;


CREATE VIEW CH08_Orders_With_Products
AS 
SELECT Orders.OrderNumber AS OrderNo, Orders.OrderDate, Order_Details.ProductNumber AS ProductNo, Products.ProductName AS Product, Order_Details.QuotedPrice AS Price, Order_Details.QuantityOrdered AS Qty, (Order_Details.QuotedPrice*Order_Details.QuantityOrdered) AS AmountOwed
FROM (Orders
INNER JOIN Order_Details
ON Orders.OrderNumber=Order_Details.OrderNumber)
INNER JOIN Products
ON Products.ProductNumber=Order_Details.ProductNumber
ORDER BY Orders.OrderNumber;


CREATE VIEW CH08_Products_And_Categories
AS 
SELECT Categories.CategoryDescription, Products.ProductName
FROM Categories
INNER JOIN Products
ON Categories.CategoryID=Products.CategoryID;


CREATE VIEW CH08_Vendors_And_Products_Less_Than_100
AS 
SELECT Vendors.VendName, Products.ProductName, Product_Vendors.WholesalePrice
FROM (Vendors
INNER JOIN Product_Vendors
ON Vendors.VendorID=Product_Vendors.VendorID)
INNER JOIN Products
ON Products.ProductNumber=Product_Vendors.ProductNumber
WHERE Product_Vendors.WholesalePrice<100;


CREATE VIEW CH09_All_Customers_And_Any_Bike_Orders
AS 
SELECT Customers.CustFirstName || ' ' || Customers.CustLastName AS CustFullName, RD.OrderDate, RD.ProductName, RD.QuantityOrdered, RD.QuotedPrice
FROM Customers LEFT JOIN (SELECT Orders.CustomerID, Orders.OrderDate, Products.ProductName, Order_Details.QuantityOrdered, Order_Details.QuotedPrice FROM ((Orders
INNER JOIN Order_Details
ON Orders.OrderNumber=Order_Details.OrderNumber)
INNER JOIN Products
ON Order_Details.ProductNumber=Products.ProductNumber)
INNER JOIN Categories
ON Categories.CategoryID=Products.CategoryID WHERE Categories.CategoryDescription='Bikes')  AS RD
ON Customers.CustomerID=RD.CustomerID;


CREATE VIEW CH09_All_Products_Any_Order_Dates
AS 
SELECT Products.ProductNumber, Products.ProductName, OD.OrderDate
FROM Products LEFT JOIN (SELECT DISTINCT Order_Details.ProductNumber, Orders.OrderDate FROM Orders
INNER JOIN Order_Details
ON Orders.OrderNumber=Order_Details.OrderNumber)  AS OD
ON Products.ProductNumber=OD.ProductNumber;


CREATE VIEW CH09_Customers_No_Helmets
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers LEFT JOIN (SELECT Orders.CustomerID, Products.ProductName FROM Products
INNER JOIN (Orders
INNER JOIN Order_Details
ON Orders.OrderNumber=Order_Details.OrderNumber)
ON Products.ProductNumber=Order_Details.ProductNumber WHERE Products.ProductName Like '*helmet*')  AS HelmetOrders
ON Customers.CustomerID=HelmetOrders.CustomerID
WHERE HelmetOrders.CustomerID IS NULL;


CREATE VIEW CH09_Customers_No_Rep_Same_Zip
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, Customers.CustZipCode
FROM Customers LEFT JOIN Employees
ON Customers.CustZipCode=Employees.EmpZipCode
WHERE Employees.EmployeeID Is Null;


CREATE VIEW CH09_Products_Never_Ordered
AS 
SELECT Products.ProductNumber, Products.ProductName
FROM Products LEFT JOIN Order_Details
ON Products.ProductNumber=Order_Details.ProductNumber
WHERE Order_Details.OrderNumber Is Null;


CREATE VIEW CH10_Customer_Helmets_Vendor_Helmets
AS 
SELECT Customers.CustLastName + ', ' + Customers.CustFirstName As FullName, Products.ProductName, 'Customer' As RowID 
FROM 
((Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID) 
INNER JOIN Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber)
INNER JOIN Products
ON Products.ProductNumber = Order_Details.ProductNumber
WHERE Products.ProductName LIKE '*helmet*'
UNION SELECT Vendors.VendName, Products.ProductName, 'Vendor' As RowID
FROM
(Vendors
INNER JOIN Product_Vendors
ON Vendors.VendorID = Product_Vendors.VendorID)
INNER JOIN Products
ON Products.ProductNumber = Product_Vendors.ProductNumber
WHERE Products.ProductName LIKE '*helmet*';


CREATE VIEW CH10_Customer_Order_Bikes_UNION_Customer_Order_Helmets
AS 
SELECT Customers.CustFirstName, Customers.CustLastName, 'Bike' As ProdType
FROM 
((Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID) 
INNER JOIN Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber)
INNER JOIN Products
ON Products.ProductNumber = Order_Details.ProductNumber
WHERE Products.ProductName LIKE '*bike*'
UNION SELECT Customers.CustFirstName, Customers.CustLastName, 'Helmet' As ProdType
FROM 
((Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID) 
INNER JOIN Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber)
INNER JOIN Products
ON Products.ProductNumber = Order_Details.ProductNumber
WHERE Products.ProductName LIKE '*helmet*';


CREATE VIEW CH10_Customers_Bikes_Or_Helmets
AS 
SELECT DISTINCT Customers.CustFirstName, Customers.CustLastName
FROM ((Customers
INNER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID)
INNER JOIN Order_Details
ON Orders.OrderNumber=Order_Details.OrderNumber)
INNER JOIN Products
ON Products.ProductNumber=Order_Details.ProductNumber
WHERE Products.ProductName LIKE '*bike*'
OR Products.ProductName LIKE '*helmet*';


CREATE VIEW CH10_Customers_UNION_ALL_Employees
AS 
SELECT Customers.CustFirstName, Customers.CustLastName, Customers.CustStreetAddress, Customers.CustCity, Customers.CustState, Customers.CustZipCode
FROM Customers
UNION ALL SELECT Employees.EmpFirstName, Employees.EmpLastName, Employees.EmpStreetAddress, Employees.EmpCity, Employees.EmpState, Employees.EmpZipCode
FROM Employees
ORDER BY CustZipCode;


CREATE VIEW CH11_Customers_Clothing_OR_Accessories
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE Customers.CustomerID=Any 
(SELECT Orders.CustomerID 
FROM ((Orders 
INNER JOIN Order_Details 
ON Orders.OrderNumber = Order_Details.OrderNumber) 
INNER JOIN Products 
ON Products.ProductNumber = Order_Details.ProductNumber) 
INNER JOIN Categories 
ON Categories.CategoryID = Products.CategoryID 
WHERE Categories.CategoryDescription = 'Clothing'
OR Categories.CategoryDescription = 'Accessories');


CREATE VIEW CH11_Customers_Clothing_OR_Accessories_EXISTS
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE EXISTS 
(SELECT * FROM ((Orders
INNER JOIN Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber) 
INNER JOIN Products
ON Products.ProductNumber = Order_Details.ProductNumber) 
INNER JOIN Categories
ON Categories.CategoryID = Products.CategoryID 
WHERE (Categories.CategoryDescription = 'Clothing'
OR Categories.CategoryDescription = 'Accessories')
AND Customers.CustomerID = Orders.CustomerID);


CREATE VIEW CH11_Customers_Clothing_OR_Accessories_IN
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE Customers.CustomerID IN 
(SELECT Orders.CustomerID FROM ((Orders 
INNER JOIN Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber) 
INNER JOIN Products
ON Products.ProductNumber = Order_Details.ProductNumber) 
INNER JOIN Categories
ON Categories.CategoryID = Products.CategoryID 
WHERE Categories.CategoryDescription = 'Clothing'
OR Categories.CategoryDescription = 'Accessories');


CREATE VIEW CH11_Customers_Ordered_Bikes_EXISTS
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE EXISTS
    (SELECT *
    FROM (Orders
   
INNER JOIN Order_Details
   
ON Orders.OrderNumber = Order_Details.OrderNumber)
   
INNER JOIN Products
   
ON Products.ProductNumber = Order_Details.ProductNumber
   WHERE Products.CategoryID = 2
   
AND Orders.CustomerID = Customers.CustomerID);


CREATE VIEW CH11_Customers_Ordered_Bikes_IN
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE Customers.CustomerID IN 
(SELECT Orders.CustomerID FROM ((Orders 
INNER JOIN Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber) 
INNER JOIN Products
ON Products.ProductNumber = Order_Details.ProductNumber) 
INNER JOIN Categories
ON Categories.CategoryID = Products.CategoryID 
WHERE Categories.CategoryDescription = 'Bikes');


CREATE VIEW CH11_Customers_Ordered_Bikes_JOIN
AS 
SELECT DISTINCT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM ((Customers
INNER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID)
INNER JOIN Order_Details
ON Orders.OrderNumber=Order_Details.OrderNumber)
INNER JOIN Products
ON Products.ProductNumber=Order_Details.ProductNumber
WHERE Products.CategoryID=2;


CREATE VIEW CH11_Products_Last_Date
AS 
SELECT Products.ProductNumber, Products.ProductName, (SELECT MAX(Orders.OrderDate) FROM Orders
INNER JOIN Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber WHERE Order_Details.ProductNumber = Products.ProductNumber) AS LastOrder
FROM Products;


CREATE VIEW CH11_Products_Not_Ordered
AS 
SELECT Products.ProductName
FROM Products
WHERE Products.ProductNumber NOT IN (SELECT Order_Details.ProductNumber FROM Order_Details);


CREATE VIEW CH11_Vendors_Product_Count
AS 
SELECT VendName, (SELECT COUNT(*) FROM Product_Vendors WHERE Product_Vendors.VendorID = Vendors.VendorID) AS VendProductCount
FROM Vendors;


CREATE VIEW CH12_Average_Price_Of_A_Mountain_Bike
AS 
SELECT AVG(RetailPrice) AS AverageCost
FROM Products
WHERE ProductName LIKE '*Mountain Bike*';


CREATE VIEW Ch12_Most_Recent_Order_Date
AS 
SELECT Max(OrderDate) AS MostRecentOrderDate
FROM Orders;


CREATE VIEW CH12_Number_Of_California_Customers
AS 
SELECT Count(*) AS NumberOfCACustomers
FROM Customers
WHERE CustState='CA';



CREATE VIEW CH12_Products_LTE_Avg_Price
AS
SELECT Products.ProductName
FROM Products
WHERE Products.RetailPrice <= (SELECT Avg(RetailPrice) FROM Products);



CREATE VIEW CH12_Quoted_Price_vs_Average_Retail_Price
AS 
SELECT DISTINCT ProductName, Products.ProductNumber
FROM Products
INNER JOIN Order_Details
ON Products.ProductNumber=Order_Details.ProductNumber
WHERE Order_Details.QuotedPrice >=     (SELECT AVG(RetailPrice)     FROM Products);


CREATE VIEW CH12_Total_Amount_For_Order_Number_8
AS 
SELECT SUM(QuantityOrdered*QuotedPrice) AS TotalOrderAmount
FROM Order_Details
WHERE OrderNumber=8;


CREATE VIEW CH13_Order_Totals_By_Customer_And_Date
AS 
SELECT Customers.CustFirstName+' '+Customers.CustLastName AS CustFullName, Orders.OrderDate, SUM(Order_Details.QuotedPrice*Order_Details.QuantityOrdered) AS TotalCost
FROM (Customers
INNER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID)
INNER JOIN Order_Details
ON Orders.OrderNumber=Order_Details.OrderNumber
GROUP BY Customers.CustFirstName, Customers.CustLastName, Orders.OrderDate;


CREATE VIEW CH13_Sales_By_Product
AS 
SELECT Products.ProductName, Sum(Order_Details.QuotedPrice*Order_Details.QuantityOrdered) AS TotalSales
FROM Products
INNER JOIN Order_Details
ON Products.ProductNumber=Order_Details.ProductNumber
GROUP BY Products.ProductName;


CREATE VIEW CH13_Vendor_Avg_Delivery
AS 
SELECT Vendors.VendName, Avg(Product_Vendors.DaysToDeliver) AS AvgDelivery
FROM Vendors
INNER JOIN Product_Vendors
ON Vendors.VendorID=Product_Vendors.VendorID
GROUP BY Vendors.VendName;


CREATE VIEW CH13_Vendors_Product_Count_Group
AS 
SELECT Vendors.VendName, Count(Product_Vendors.ProductNumber) AS CountOfProductNumber
FROM Vendors
INNER JOIN Product_Vendors
ON Vendors.VendorID=Product_Vendors.VendorID
GROUP BY Vendors.VendName;


CREATE VIEW CH13_Vendors_Product_Count_Subquery
AS 
SELECT VendName, (SELECT COUNT(*) FROM Product_Vendors WHERE Product_Vendors.VendorID = Vendors.VendorID) AS VendProductCount
FROM Vendors;


CREATE VIEW CH14_Order_Totals_By_Customer_And_Date_GT1000
AS 
SELECT Customers.CustFirstName || ' ' || Customers.CustLastName AS CustFullName, Orders.OrderDate, SUM(Order_Details.QuotedPrice*Order_Details.QuantityOrdered) AS TotalCost
FROM (Customers
INNER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID)
INNER JOIN Order_Details
ON Orders.OrderNumber=Order_Details.OrderNumber
GROUP BY Customers.CustFirstName, Customers.CustLastName, Orders.OrderDate
HAVING SUM(Order_Details.QuotedPrice*Order_Details.QuantityOrdered)>1000;


CREATE VIEW CH14_Sales_By_Product_GT_Category_Avg
AS 
SELECT Products.ProductName, Sum(Order_Details.QuotedPrice*Order_Details.QuantityOrdered) AS TotalSales
FROM Products
INNER JOIN Order_Details
ON Products.ProductNumber=Order_Details.ProductNumber
GROUP BY Products.CategoryID, Products.ProductName
HAVING Sum(Order_Details.QuotedPrice * Order_Details.QuantityOrdered) > (SELECT Avg(SumCategory) FROM (SELECT P2.CategoryID, Sum(OD2.QuotedPrice * OD2.QuantityOrdered) As SumCategory FROM Products AS P2
INNER JOIN Order_Details AS OD2
ON P2.ProductNumber = OD2.ProductNumber GROUP BY P2.CategoryID, P2.ProductNumber) AS S WHERE S.CategoryID = Products.CategoryID GROUP BY CategoryID);


CREATE VIEW CH14_Single_Item_Order_Count
AS 
SELECT COUNT(*) AS SingleItemOrderCount
FROM (SELECT Order_Details.OrderNumber FROM Order_Details GROUP BY Order_Details.OrderNumber HAVING COUNT(*)=1)  AS SingleOrders;


CREATE VIEW CH14_Vendor_Avg_Delivery_GT_Overall_Avg
AS 
SELECT Vendors.VendName, Avg(Product_Vendors.DaysToDeliver) AS AvgDelivery
FROM Vendors
INNER JOIN Product_Vendors
ON Vendors.VendorID=Product_Vendors.VendorID
GROUP BY Vendors.VendName
HAVING Avg(Product_Vendors.DaysToDeliver) > (SELECT Avg(DaysToDeliver) FROM Product_Vendors);


CREATE VIEW CH14_West_Coast_Big_Order_States
AS 
SELECT Customers.CustState, SUM(Order_Details.QuantityOrdered*Order_Details.QuotedPrice) AS SumOfOrders
FROM (Customers
INNER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID)
INNER JOIN Order_Details
ON Orders.OrderNumber=Order_Details.OrderNumber
WHERE Customers.CustState In ('WA','OR','CA')
GROUP BY Customers.CustState
HAVING SUM(Order_Details.QuantityOrdered*Order_Details.QuotedPrice)>1000000;


CREATE VIEW CH18_Cust_Bikes_And_Helmets_EXISTS
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE EXISTS 
(SELECT *
FROM (Orders
INNER JOIN Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber)
INNER JOIN Products
ON Products.ProductNumber = Order_Details.ProductNumber
WHERE Products.CategoryID = 2
AND Orders.CustomerID = Customers.CustomerID)
AND EXISTS
(SELECT *
FROM (Orders
INNER JOIN Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber)
INNER JOIN Products
ON Products.ProductNumber = Order_Details.ProductNumber
WHERE Products.ProductName LIKE '*Helmet'
AND Orders.CustomerID = Customers.CustomerID);


CREATE VIEW CH18_Cust_Bikes_No_Helmets_EXISTS
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE EXISTS 
(SELECT *
FROM (Orders
INNER JOIN Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber)
INNER JOIN Products
ON Products.ProductNumber = Order_Details.ProductNumber
WHERE Products.CategoryID = 2
AND Orders.CustomerID = Customers.CustomerID)
AND NOT EXISTS
(SELECT *
FROM (Orders
INNER JOIN Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber)
INNER JOIN Products
ON Products.ProductNumber = Order_Details.ProductNumber
WHERE Products.ProductName LIKE '*Helmet'
AND Orders.CustomerID = Customers.CustomerID);


CREATE VIEW CH18_Customer_Bikes_No_Helmets
AS 
SELECT CustomerID, CustFirstName, CustLastName
FROM Customers
WHERE (CustomerID IN
                          (SELECT     Orders.CustomerID
                            FROM          (Orders
INNER JOIN
                                                   Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber)
INNER JOIN
                                                   Products
ON Products.ProductNumber = Order_Details.ProductNumber
                            WHERE      Products.CategoryID = 2)) 
          
AND (CustomerID NOT IN
                          (SELECT     Orders.CustomerID
                            FROM          (Orders
INNER JOIN
                                                   Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber)
INNER JOIN
                                                   Products
ON Products.ProductNumber = Order_Details.ProductNumber
                            WHERE      Products.ProductName LIKE '*Helmet'));


CREATE VIEW CH18_Customers_Bikes_And_Helmets_Same_Order
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, Orders.OrderNumber, Orders.OrderDate
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
WHERE EXISTS  (SELECT * FROM (Orders As O2
INNER JOIN Order_Details
ON O2.OrderNumber = Order_Details.OrderNumber)
INNER JOIN Products
ON Products.ProductNumber = Order_Details.ProductNumber WHERE Products.CategoryID = 2
AND Orders.CustomerID = Customers.CustomerID
AND O2.OrderNumber = Orders.OrderNumber)
AND EXISTS (SELECT * FROM (Orders As O3 
INNER JOIN Order_Details
ON O3.OrderNumber = Order_Details.OrderNumber)
INNER JOIN Products
ON Products.ProductNumber = Order_Details.ProductNumber WHERE Products.ProductName LIKE '*Helmet'
AND Orders.CustomerID = Customers.CustomerID
AND O3.OrderNumber = Orders.OrderNumber);


CREATE VIEW CH18_Customers_No_Orders_JOIN
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, Customers.CustStreetAddress, Customers.CustCity, Customers.CustState
FROM Customers LEFT JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
WHERE Orders.OrderNumber Is Null;


CREATE VIEW CH18_Customers_No_Orders_NOT_IN
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, Customers.CustStreetAddress, Customers.CustCity, Customers.CustState
FROM Customers
WHERE Customers.CustomerID NOT IN
(SELECT Orders.CustomerID FROM Orders);


CREATE VIEW CH18_Customers_Not_Bikes_Or_Tires_NOTIN_1
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE Customers.CustomerID NOT IN
(SELECT CustomerID FROM
(Orders
INNER JOIN Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber)
INNER JOIN Products
ON Order_Details.ProductNumber = Products.ProductNumber
WHERE Products.CategoryID IN (2, 6));


CREATE VIEW CH18_Customers_Not_Bikes_Or_Tires_NOTIN_2
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE Customers.CustomerID NOT IN
(SELECT CustomerID FROM
(Orders
INNER JOIN Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber)
INNER JOIN Products
ON Order_Details.ProductNumber = Products.ProductNumber
WHERE Products.CategoryID = 2)
AND Customers.CustomerID NOT IN 
(SELECT CustomerID FROM
(Orders
INNER JOIN Order_Details
ON Orders.OrderNumber = Order_Details.OrderNumber)
INNER JOIN Products
ON Order_Details.ProductNumber = Products.ProductNumber
WHERE Products.CategoryID = 6);


CREATE VIEW CH18_Orders_Bikes_No_Helmet_EXISTS
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, Orders.OrderNumber, Orders.OrderDate
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
WHERE EXISTS  (SELECT OrderNumber  FROM (Order_Details
INNER JOIN Products
ON Order_Details.ProductNumber = Products.ProductNumber)
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID WHERE Categories.CategoryDescription = 'Bikes'
AND Order_Details.OrderNumber = Orders.OrderNumber)
AND NOT EXISTS  (SELECT *  FROM Order_Details
INNER JOIN Products
ON Order_Details.ProductNumber = Products.ProductNumber WHERE Products.ProductName LIKE '*Helmet'
AND Order_Details.OrderNumber = Orders.OrderNumber);


CREATE VIEW CH18_Vendors_Accessories_CarRacks_Clothing
AS 
SELECT Vendors.VendorID, Vendors.VendName
FROM Vendors
WHERE Vendors.VendorID IN
(SELECT VendorID 
  FROM (Product_Vendors
INNER JOIN Products
 
ON Product_Vendors.ProductNumber = Products.ProductNumber)
 
INNER JOIN Categories
 
ON Products.CategoryID = Categories.CategoryID
  WHERE Categories.CategoryDescription = 'Accessories')
AND Vendors.VendorID IN
(SELECT VendorID 
  FROM (Product_Vendors
INNER JOIN Products
 
ON Product_Vendors.ProductNumber = Products.ProductNumber)
 
INNER JOIN Categories
 
ON Products.CategoryID = Categories.CategoryID
  WHERE Categories.CategoryDescription = 'Car racks')
AND Vendors.VendorID IN
(SELECT VendorID 
  FROM (Product_Vendors
INNER JOIN Products
 
ON Product_Vendors.ProductNumber = Products.ProductNumber)
 
INNER JOIN Categories
 
ON Products.CategoryID = Categories.CategoryID
  WHERE Categories.CategoryDescription = 'Clothing');


CREATE VIEW CH19_Customers_Ordered_FirstWeek_Dec2017
AS 
SELECT CustomerID, CustFirstName, CustLastName, IIf(IsNull(DLookup('CustomerID','Orders','CustomerID = ' || CustomerID || '
AND OrderDate BETWEEN '2017-12-01'
AND '2017-12-07'')),'Not Ordered','Ordered') AS OrderedFirstWeekDec2017
FROM Customers;


CREATE VIEW CH19_Customers_State_Names
AS 
SELECT CustFirstName, CustLastName, IIf(CustState = 'TX', 'Texas', IIf(CustState = 'CA', 'California', IIf(CustState = 'OR', 'Oregon', IIf(CustState = 'WA', 'Washington', 'Unknown')))) AS CustStateName
FROM Customers;


CREATE VIEW CH19_Employee_Age_Feb152018
AS 
SELECT EmployeeID, EmpFirstName, EmpLastName, DATEDIFF('yyyy',EmpBirthDate,'2/15/2018')-IIf(Month(EmpBirthDate)<2,0,IIf(Month(EmpBirthDate)>2,1,IIf(Day(EmpBirthDate)>15,1,0))) AS EmpAge
FROM Employees;


CREATE VIEW CH19_Orders_OrderDetails_Temp
AS 
SELECT Orders.CustomerID, Orders.OrderNumber, Orders.OrderDate, Order_Details.ProductNumber, Order_Details.QuotedPrice, Order_Details.QuantityOrdered
FROM Orders
INNER JOIN Order_Details
ON Orders.OrderNumber=Order_Details.OrderNumber;


CREATE VIEW CH19_Products_And_SalesQuality
AS 
SELECT Products.ProductNumber, Products.ProductName, IIf(DSum('QuantityOrdered','Order_Details','ProductNumber = ' || (ProductNumber))<=200,'Poor',IIf(DSum('QuantityOrdered','Order_Details','ProductNumber = ' || (ProductNumber))<=500,'Average',IIf(DSum('QuantityOrdered','Order_Details','ProductNumber = ' || (ProductNumber))<=1000,'Good','Excellent'))) AS SalesQuality
FROM Products;


CREATE VIEW CH19_Products_Ordered_Dec_2017
AS 
SELECT ProductNumber, ProductName, IIf(Not IsNull(DLookup('ProductNumber','CH19_Orders_OrderDetails_Temp','ProductNumber = ' || (ProductNumber) || '
AND OrderDate BETWEEN '2017-12-01'
AND '2017-12-31'')),'Ordered','Not Ordered') AS ProductOrdered
FROM Products;


CREATE VIEW CH20_Customer_All_Products_PurchasedStatus
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, Customers.CustStreetAddress, Customers.CustCity, Customers.CustState, Customers.CustZipCode, Categories.CategoryDescription, Products.ProductNumber, Products.ProductName, Products.RetailPrice, IIf(Not IsNull(DLookup('ProductNumber','CH19_Orders_OrderDetails_Temp','CustomerID = ' || Customers.CustomerID || '
AND ProductNumber = ' || Products.ProductNumber)),'You purchased this!','') AS ProductOrdered
FROM Customers, Categories
INNER JOIN Products
ON Categories.CategoryID=Products.CategoryID
ORDER BY Customers.CustomerID, Categories.CategoryDescription, Products.ProductNumber;


CREATE VIEW CH20_Customer_Catalog
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, Customers.CustStreetAddress, Customers.CustCity, Customers.CustState, Customers.CustZipCode, Categories.CategoryDescription, Products.ProductNumber, Products.ProductName, Products.RetailPrice
FROM Customers, Categories
INNER JOIN Products
ON Categories.CategoryID=Products.CategoryID
ORDER BY Customers.CustomerID, Categories.CategoryDescription, Products.ProductNumber;


CREATE VIEW CH20_Customer_Dec_2017_Order_Coupons
AS 
SELECT ztblPurchaseCoupons.NumCoupons, CustDecOrderTotal.CustomerID, Customers.CustFirstName, Customers.CustLastName, Customers.CustStreetAddress, Customers.CustCity, Customers.CustState, Customers.CustZipCode, CustDecOrderTotal.Purchase
FROM ztblPurchaseCoupons, Customers
INNER JOIN (SELECT Orders.CustomerID, Sum((QuotedPrice)*(QuantityOrdered)) AS Purchase FROM Orders
INNER JOIN Order_Details
ON Orders.OrderNumber=Order_Details.OrderNumber WHERE Orders.OrderDate Between '12/1/2017' And '12/31/2017' GROUP BY Orders.CustomerID)  AS CustDecOrderTotal
ON Customers.CustomerID=CustDecOrderTotal.CustomerID
WHERE CustDecOrderTotal.Purchase BETWEEN ztblPurchaseCoupons.LowSpend
AND ztblPurchaseCoupons.HighSpend;


CREATE VIEW CH20_Customer_Discount_Coupons_Print
AS 
SELECT CH20_Customer_Dec_2017_Order_Coupons.CustomerID, CH20_Customer_Dec_2017_Order_Coupons.CustFirstName, CH20_Customer_Dec_2017_Order_Coupons.CustLastName, CH20_Customer_Dec_2017_Order_Coupons.CustStreetAddress, CH20_Customer_Dec_2017_Order_Coupons.CustCity, CH20_Customer_Dec_2017_Order_Coupons.CustState, CH20_Customer_Dec_2017_Order_Coupons.CustZipCode
FROM ztblSeqNumbers, CH20_Customer_Dec_2017_Order_Coupons
WHERE (((CH20_Customer_Dec_2017_Order_Coupons.NumCoupons)>=(ztblSeqNumbers)(Sequence)))
ORDER BY CH20_Customer_Dec_2017_Order_Coupons.CustomerID;


CREATE VIEW CH20_Customer_Mailing_Skip_5
AS 
SELECT ' ' As CustFirstName, ' ' As CustLastName, ' ' As CustStreenAddress, ' ' As CustCity, ' ' As CustState, ' ' As CustZipCode 
FROM ztblSeqNumbers
WHERE ztblSeqNumbers.Sequence <= 5
UNION ALL SELECT Customers.CustFirstName, Customers.CustLastName, Customers.CustStreetAddress, Customers.CustCity, Customers.CustState, Customers.CustZipCode
FROM Customers
ORDER BY CustZipCode, CustLastName;


CREATE VIEW CH20_Employees_Same_State_Customers
AS 
SELECT Employees.EmpFirstName, Employees.EmpLastName, Customers.CustFirstName, Customers.CustLastName, Customers.CustAreaCode, Customers.CustPhoneNumber, IIf(Not IsNull(DLookup('OrderNumber','Orders','Orders.CustomerID = ' || Customers.CustomerID || '
AND Orders.EmployeeID = ' || Employees.EmployeeID)),'Ordered from you.',' ') AS CustStatus
FROM Employees, Customers
WHERE Employees.EmpState=Customers.CustState;


CREATE VIEW CH20_Product_Price_Ranges
AS 
SELECT ztblPriceRanges.PriceCategory, Products.ProductName, Products.RetailPrice
FROM ztblPriceRanges, Products
WHERE Products.RetailPrice Between ztblPriceRanges.LowPrice And ztblPriceRanges.HighPrice;


CREATE VIEW CH20_Product_Sales_All_Months_2017_2018
AS 
SELECT ztblMonths.MonthYear, Products.ProductName, (SELECT Sum(Order_Details.QuantityOrdered*Order_Details.QuotedPrice) AS SValue 
FROM  (Products
INNER JOIN Order_Details
ON Products.ProductNumber=Order_Details.ProductNumber)
INNER JOIN Orders
ON Orders.OrderNumber=Order_Details.OrderNumber
WHERE Orders.OrderDate BETWEEN ztblMonths.MonthStart
AND ztblMonths.MonthEnd) AS Sales
FROM ztblMonths, Products
WHERE ztblMonths.YearNumber BETWEEN 2017 And 2018;


CREATE VIEW CH20_Product_Sales_ByMonth
AS 
SELECT ztblMonths.MonthYear, Products.ProductName, Sum(Order_Details.QuantityOrdered*Order_Details.QuotedPrice) AS Sales
FROM ztblMonths, (Products
INNER JOIN Order_Details
ON Products.ProductNumber=Order_Details.ProductNumber)
INNER JOIN Orders
ON Orders.OrderNumber=Order_Details.OrderNumber
WHERE Orders.OrderDate BETWEEN ztblMonths.MonthStart
AND ztblMonths.MonthEnd
GROUP BY ztblMonths.MonthYear, Products.ProductName;


CREATE VIEW CH20_Product_Sales_Month_Pivot
AS 
SELECT Products.ProductName, SUM(Order_Details.QuotedPrice*Order_Details.QuantityOrdered*ztblMonths.January) AS January, SUM(Order_Details.QuotedPrice*Order_Details.QuantityOrdered*ztblMonths.February) AS February, SUM(Order_Details.QuotedPrice*Order_Details.QuantityOrdered*ztblMonths.March) AS March, SUM(Order_Details.QuotedPrice*Order_Details.QuantityOrdered*ztblMonths.April) AS April, SUM(Order_Details.QuotedPrice*Order_Details.QuantityOrdered*ztblMonths.May) AS May, SUM(Order_Details.QuotedPrice*Order_Details.QuantityOrdered*ztblMonths.June) AS June, SUM(Order_Details.QuotedPrice*Order_Details.QuantityOrdered*ztblMonths.July) AS July, SUM(Order_Details.QuotedPrice*Order_Details.QuantityOrdered*ztblMonths.August) AS August, SUM(Order_Details.QuotedPrice*Order_Details.QuantityOrdered*ztblMonths.September) AS September, SUM(Order_Details.QuotedPrice*Order_Details.QuantityOrdered*ztblMonths.October) AS October, SUM(Order_Details.QuotedPrice*Order_Details.QuantityOrdered*ztblMonths.November) AS November, SUM(Order_Details.QuotedPrice*Order_Details.QuantityOrdered*ztblMonths.December) AS December
FROM ztblMonths, (Products
INNER JOIN Order_Details
ON Products.ProductNumber=Order_Details.ProductNumber)
INNER JOIN Orders
ON Orders.OrderNumber=Order_Details.OrderNumber
WHERE Orders.OrderDate BETWEEN ztblMonths.MonthStart
AND ztblMonths.MonthEnd
GROUP BY Products.ProductName;


CREATE VIEW CH20_Product_Stock_Labels
AS 
SELECT ztblSeqNumbers.Sequence, Products.ProductNumber, Products.ProductName
FROM ztblSeqNumbers, Products
WHERE ztblSeqNumbers.Sequence<=Products.QuantityOnHand
ORDER BY Products.ProductNumber, ztblSeqNumbers.Sequence;


