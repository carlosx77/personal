CREATE PROCEDURE CH15_Calculate_Entertainment_ContractPrice
AS 
UPDATE Engagements SET ContractPrice = ROUND(1.15 * (DateDiff('d', StartDate, EndDate) + 1) *
             DLookup('EntPricePerDay', 'Entertainers', 'EntertainerID = ' & (Engagements)(EntertainerID)), 0);


CREATE VIEW CH15_Calculate_Entertainment_ContractPrice_Query
AS 
SELECT EngagementNumber, StartDate, EndDate, Engagements.ContractPrice, Round(1.15*(DateDiff('d',StartDate,EndDate)+1)*(SELECT     EntPricePerDay
              FROM          Entertainers
              WHERE      Entertainers.EntertainerID = Engagements.EntertainerID),0) AS NewContractPrice
FROM Engagements;


CREATE PROCEDURE CH15_Discount_Good_Customers_October
AS 
UPDATE Engagements SET Engagements.ContractPrice = Round((ContractPrice)*0.98,0)
WHERE Engagements.CustomerID In 
(SELECT Engagements.CustomerID
FROM Engagements
WHERE (Engagements.StartDate<='10/31/2017')
AND (Engagements.EndDate>='10/1/2017')
GROUP BY Engagements.CustomerID
HAVING Sum(Engagements.ContractPrice)>3000);


CREATE VIEW CH15_Discount_Good_Customers_October_Query
AS 
SELECT Engagements.ContractPrice, Round((ContractPrice)*0.98,0) AS NewContractPrice
FROM Engagements
WHERE (((Engagements.CustomerID) In (SELECT Engagements.CustomerID
FROM Engagements
WHERE (Engagements.StartDate<='10/31/2017')
AND (Engagements.EndDate>='10/1/2017')
GROUP BY Engagements.CustomerID
HAVING Sum(Engagements.ContractPrice)>3000)));


CREATE PROCEDURE CH15_Give_Agents_6Percent_Raise
AS 
UPDATE Agents SET Agents.Salary = Round((Salary)*1.06,0);


CREATE VIEW CH15_Give_Agents_6Percent_Raise_Query
AS 
SELECT AgentID, AgtFirstName, AgtLastName, Agents.Salary, Round((Salary)*1.06,0) AS NewSalary
FROM Agents;


CREATE PROCEDURE CH15_Reward_Good_Agents
AS 
UPDATE Agents SET Agents.CommissionRate = (CommissionRate)+0.005
WHERE Agents.AgentID In 
(SELECT AgentID
FROM Engagements
GROUP BY AgentID
HAVING Sum((ContractPrice)) > 20000);


CREATE VIEW CH15_Reward_Good_Agents_Query
AS 
SELECT Agents.CommissionRate, (CommissionRate)+0.005 AS NewCommissionRate
FROM Agents
WHERE (((Agents.AgentID) In (SELECT AgentID
FROM Engagements
GROUP BY AgentID
HAVING Sum((ContractPrice)) > 20000)));


CREATE PROCEDURE CH16_Add_Engagement
AS 
INSERT INTO Engagements ( CustomerID, EntertainerID, StartDate, EndDate, StartTime, StopTime, ContractPrice, AgentID )
SELECT Customers.CustomerID, Entertainers.EntertainerID, '8/15/2018' AS StartDate, '8/16/2018' AS EndDate, '12/30/1899 19:0:0' AS StartTime, '12/30/1899 23:0:0' AS EndTime, Round((EntPricePerDay)*2*1.15,0) AS ContractPrice, Agents.AgentID
FROM Customers, Entertainers, Agents
WHERE (Customers.CustFirstName='Matt')
AND (Customers.CustLastName='Berg')
AND (Entertainers.EntStageName='Jazz Persuasion')
AND (Agents.AgtFirstName='Karen')
AND (Agents.AgtLastName='Smith');


CREATE VIEW CH16_Add_Engagement_Query
AS 
SELECT Customers.CustomerID, Entertainers.EntertainerID, '8/15/2018' AS StartDate, '8/16/2018' AS EndDate, '12/30/1899 19:0:0' AS StartTime, '12/30/1899 23:0:0' AS EndTime, Round((EntPricePerDay)*2*1.15,0) AS ContractPrice, Agents.AgentID
FROM Customers, Entertainers, Agents
WHERE (((Customers.CustFirstName)='Matt')
AND ((Customers.CustLastName)='Berg')
AND ((Entertainers.EntStageName)='Jazz Persuasion')
AND ((Agents.AgtFirstName)='Karen')
AND ((Agents.AgtLastName)='Smith'));


CREATE PROCEDURE CH16_Add_Ent_Customer
AS 
INSERT INTO Customers ( CustFirstName, CustLastName, CustStreetAddress, CustCity, CustState, CustZipCode, CustPhoneNumber )
VALUES ('Kendra', 'Hernandez', '457 211th St NE', 'Bothell', 'WA', '98200', '555-3945');


CREATE VIEW CH16_Add_Ent_Customer_Query
AS 
SELECT 'Kendra' AS NewCustFirstName, 'Hernandez' AS NewCustLastName, '457 211th St NE' AS CustNewStreetAddress, 'Bothell' AS NewCustCity, 'WA' AS NewCustState, '98200' AS NewCustZipCode, '555-3945' AS NewCustPhoneNumber;


CREATE PROCEDURE CH16_Add_Style
AS 
INSERT INTO Musical_Styles ( StyleName )
VALUES ('New Age');


CREATE VIEW CH16_Add_Style_Query
AS 
SELECT 'New Age' AS NewStyleName;


CREATE PROCEDURE CH16_Archive_Engagements
AS 
INSERT INTO Engagements_Archive ( EngagementNumber, StartDate, EndDate, StartTime, StopTime, ContractPrice, CustomerID, AgentID, EntertainerID )
SELECT Engagements.EngagementNumber, Engagements.StartDate, Engagements.EndDate, Engagements.StartTime, Engagements.StopTime, Engagements.ContractPrice, Engagements.CustomerID, Engagements.AgentID, Engagements.EntertainerID
FROM Engagements
WHERE Engagements.EndDate<'1/1/2018';


CREATE VIEW CH16_Archive_Engagements_Query
AS 
SELECT Engagements.EngagementNumber, Engagements.StartDate, Engagements.EndDate, Engagements.StartTime, Engagements.StopTime, Engagements.ContractPrice, Engagements.CustomerID, Engagements.AgentID, Engagements.EntertainerID
FROM Engagements
WHERE (((Engagements.EndDate)<'1/1/2018'));


CREATE PROCEDURE CH16_Copy_Agent_To_Customer
AS 
INSERT INTO Customers ( CustFirstName, CustLastName, CustStreetAddress, CustCity, CustState, CustZipCode, CustPhoneNumber )
SELECT Agents.AgtFirstName, Agents.AgtLastName, Agents.AgtStreetAddress, Agents.AgtCity, Agents.AgtState, Agents.AgtZipCode, Agents.AgtPhoneNumber
FROM Agents
WHERE (Agents.AgtFirstName = 'Marianne')
AND (Agents.AgtLastName = 'Wier');


CREATE VIEW CH16_Copy_Agent_To_Customer_Query
AS 
SELECT Agents.AgtFirstName, Agents.AgtLastName, Agents.AgtStreetAddress, Agents.AgtCity, Agents.AgtState, Agents.AgtZipCode, Agents.AgtPhoneNumber
FROM Agents
WHERE (((Agents.AgtFirstName)='Marianne')
AND ((Agents.AgtLastName)='Wier'));


CREATE PROCEDURE CH16_Duplicate_Engagement
AS 
INSERT INTO Engagements ( StartDate, EndDate, StartTime, StopTime, ContractPrice, CustomerID, AgentID, EntertainerID )
SELECT '8/1/2018' AS StartDate, '8/4/2018' AS EndDate, Engagements.StartTime, Engagements.StopTime, Engagements.ContractPrice, Engagements.CustomerID, Engagements.AgentID, Engagements.EntertainerID
FROM Customers
INNER JOIN Engagements
ON Customers.CustomerID=Engagements.CustomerID
WHERE (((Customers.CustFirstName)='Doris')
AND ((Customers.CustLastName)='Hartwig')
AND ((Engagements.StartDate)='12/2/2017'));


CREATE VIEW CH16_Duplicate_Engagement_Query
AS 
SELECT '8/1/2018' AS StartDate, '8/4/2018' AS EndDate, Engagements.StartTime, Engagements.StopTime, Engagements.ContractPrice, Engagements.CustomerID, Engagements.AgentID, Engagements.EntertainerID
FROM Customers
INNER JOIN Engagements
ON Customers.CustomerID = Engagements.CustomerID
WHERE (((Customers.CustFirstName)='Doris')
AND ((Customers.CustLastName)='Hartwig')
AND ((Engagements.StartDate)='12/2/2017'));


CREATE PROCEDURE CH17_Delete_Customers_Never_Booked1
AS 
DELETE Musical_Preferences.*
FROM Musical_Preferences
WHERE (Musical_Preferences.CustomerID Not In (SELECT CustomerID FROM Engagements));


CREATE VIEW CH17_Delete_Customers_Never_Booked1_Query
AS 
SELECT Musical_Preferences.*
FROM Musical_Preferences
WHERE (Musical_Preferences.CustomerID Not In (SELECT CustomerID FROM Engagements));


CREATE PROCEDURE CH17_Delete_Customers_Never_Booked2
AS 
DELETE Customers.*
FROM Customers
WHERE (Customers.CustomerID Not In (SELECT CustomerID FROM Engagements));


CREATE VIEW CH17_Delete_Customers_Never_Booked2_Query
AS 
SELECT Customers.*
FROM Customers
WHERE (((Customers.CustomerID) Not In (SELECT CustomerID FROM Engagements)));


CREATE PROCEDURE CH17_Delete_Entertainers_Not_Booked1
AS 
DELETE Entertainer_Members.*
FROM Entertainer_Members
WHERE (Entertainer_Members.EntertainerID Not In (SELECT EntertainerID FROM Engagements));


CREATE VIEW CH17_Delete_Entertainers_Not_Booked1_Query
AS 
SELECT Entertainer_Members.*
FROM Entertainer_Members
WHERE (((Entertainer_Members.EntertainerID) Not In (SELECT EntertainerID FROM Engagements)));


CREATE PROCEDURE CH17_Delete_Entertainers_Not_Booked2
AS 
DELETE Entertainer_Styles.*
FROM Entertainer_Styles
WHERE (Entertainer_Styles.EntertainerID Not In (SELECT EntertainerID FROM Engagements));


CREATE VIEW CH17_Delete_Entertainers_Not_Booked2_Query
AS 
SELECT Entertainer_Styles.*
FROM Entertainer_Styles
WHERE Entertainer_Styles.EntertainerID Not In (SELECT EntertainerID FROM Engagements);


CREATE PROCEDURE CH17_Delete_Entertainers_Not_Booked3
AS 
DELETE Entertainers.*
FROM Entertainers
WHERE (Entertainers.EntertainerID Not In (SELECT EntertainerID FROM Engagements));


CREATE VIEW CH17_Delete_Entertainers_Not_Booked3_Query
AS 
SELECT Entertainers.*
FROM Entertainers
WHERE (((Entertainers.EntertainerID) Not In (SELECT EntertainerID FROM Engagements)));


CREATE PROCEDURE CH17_Delete_Members_Not_In_Group
AS 
DELETE Members.*
FROM Members
WHERE (Members.MemberID Not In (SELECT MemberID FROM Entertainer_Members));


CREATE VIEW CH17_Delete_Members_Not_In_Group_Query
AS 
SELECT Members.*
FROM Members
WHERE (((Members.MemberID) Not In (SELECT MemberID FROM Entertainer_Members)));


CREATE PROCEDURE CH17_Delete_Styles_No_Entertainer
AS 
DELETE Musical_Styles.*
FROM Musical_Styles
WHERE (Musical_Styles.StyleID Not In (SELECT StyleID FROM Entertainer_Styles))
AND (Musical_Styles.StyleID Not In (SELECT StyleID FROM Musical_Preferences));


CREATE VIEW CH17_Delete_Styles_No_Entertainer_Query
AS 
SELECT Musical_Styles.*
FROM Musical_Styles
WHERE (Musical_Styles.StyleID Not In (SELECT StyleID FROM Entertainer_Styles))
AND (Musical_Styles.StyleID Not In (SELECT StyleID FROM Musical_Preferences));


CREATE PROCEDURE CH17_Remove_Archived_Engagements
AS 
DELETE Engagements.*
FROM Engagements
WHERE (Engagements.EngagementNumber In (SELECT EngagementNumber FROM Engagements_Archive));


CREATE VIEW CH17_Remove_Archived_Engagements_Query
AS 
SELECT Engagements.*
FROM Engagements
WHERE (((Engagements.EngagementNumber) In (SELECT EngagementNumber FROM Engagements_Archive)));


