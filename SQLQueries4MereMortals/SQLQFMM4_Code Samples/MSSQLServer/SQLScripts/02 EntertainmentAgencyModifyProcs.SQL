USE EntertainmentAgencyModify;
GO
CREATE PROCEDURE CH15_Calculate_Entertainment_ContractPrice
AS 
UPDATE  Engagements
SET        ContractPrice = ROUND(1.15 * (DateDiff(d, StartDate, EndDate) + 1) *
             (SELECT     EntPricePerDay
              FROM          Entertainers
              WHERE      Entertainers.EntertainerID = Engagements.EntertainerID), 0);
GO

CREATE VIEW CH15_Calculate_Entertainment_ContractPrice_Query
AS 
SELECT EngagementNumber, StartDate, EndDate, ContractPrice, ROUND(1.15 * (DateDiff(d, StartDate, EndDate) + 1) *
             (SELECT     EntPricePerDay
              FROM          Entertainers
              WHERE      Entertainers.EntertainerID = Engagements.EntertainerID), 0)
AS NewContractPrice, EntertainerID
FROM Engagements;
GO

CREATE PROCEDURE CH15_Discount_Good_Customers_October
AS 
UPDATE    Engagements
SET              ContractPrice = ROUND(ContractPrice * 0.98, 0)
WHERE     (CustomerID IN
              (SELECT     Engagements.CustomerID
               FROM          Engagements
               WHERE      (Engagements.StartDate <= '10/31/2017') 
                 AND (Engagements.EndDate >= '10/1/2017')
               GROUP BY Engagements.CustomerID
               HAVING      SUM(Engagements.ContractPrice) > 3000));
GO

CREATE VIEW CH15_Discount_Good_Customers_October_Query
AS 
SELECT      ContractPrice, ROUND(ContractPrice * 0.98, 0) AS NewContractPrice
FROM Engagements 
WHERE     (CustomerID IN
              (SELECT     Engagements.CustomerID
               FROM          Engagements
               WHERE      (Engagements.StartDate <= '10/31/2017') 
                 AND (Engagements.EndDate >= '10/1/2017')
               GROUP BY Engagements.CustomerID
               HAVING      SUM(Engagements.ContractPrice) > 3000)) ;
GO

CREATE PROCEDURE CH15_Give_Agents_6Percent_Raise
AS 
UPDATE    Agents
SET          Salary = ROUND(Salary * 1.06, 0);
GO

CREATE VIEW CH15_Give_Agents_6Percent_Raise_Query
AS 
SELECT Agents.AgentID, Agents.AgtFirstName, Agents.AgtLastName, Agents.Salary, Round((Salary)*1.06,0) AS NewSalary
FROM    Agents;
GO

CREATE PROCEDURE CH15_Reward_Good_Agents
AS 
UPDATE    Agents
SET          CommissionRate = CommissionRate + 0.005
WHERE     (AgentID IN
            (SELECT     AgentID
             FROM          Engagements
             GROUP BY AgentID
             HAVING      SUM(ContractPrice) > 20000));
GO

CREATE VIEW CH15_Reward_Good_Agents_Query
AS 
SELECT      CommissionRate, CommissionRate + 0.005 AS NewCommissionRate
FROM   Agents
WHERE     (AgentID IN
            (SELECT     AgentID
             FROM          Engagements
             GROUP BY AgentID
             HAVING      SUM(ContractPrice) > 20000));
GO

CREATE PROCEDURE CH16_Add_Ent_Customer
AS 
INSERT INTO Customers
                      (CustFirstName, CustLastName, CustStreetAddress, CustCity, CustState, CustZipCode, CustPhoneNumber)
VALUES     ('Kendra', 'Hernandez', '457 211th St NE', 'Bothell', 'WA', '98200', '555-3945');
GO

CREATE VIEW CH16_Add_Ent_Customer_Query
AS 
SELECT 'Kendra' As NewCustFirstName, 'Hernandez' As NewCustLastName, '457 211th St NE' As NewCustStreetAddress, 
   'Bothell' As NewCustCity, 'WA' As NewCustState, '98200' As NewCustZipCode, '555-3945' As NewCustPhoneNumber;
GO

CREATE PROCEDURE CH16_Add_Engagement
AS 
INSERT INTO Engagements
                      (CustomerID, EntertainerID, StartDate, EndDate, StartTime, StopTime, ContractPrice, AgentID)
SELECT     Customers.CustomerID, Entertainers.EntertainerID, '8/15/2018' AS StartDate, '8/16/2018' AS EndDate, '19:00:00' AS StartTime, '23:00:00' AS StopTime, 
                      ROUND(Entertainers.EntPricePerDay * 2 * 1.15, 0) AS ContractPrice, Agents.AgentID
FROM         Customers CROSS JOIN
                      Entertainers CROSS JOIN
                      Agents
WHERE     (Customers.CustFirstName = 'Matt') AND (Customers.CustLastName = 'Berg') AND (Entertainers.EntStageName = 'Jazz Persuasion') AND 
                      (Agents.AgtFirstName = 'Karen') AND (Agents.AgtLastName = 'Smith');
GO

CREATE VIEW CH16_Add_Engagement_Query
AS 
SELECT     Customers.CustomerID, Entertainers.EntertainerID, '8/15/2018' AS StartDate, '8/16/2018' AS EndDate, '19:00:00' AS StartTime, '23:00:00' AS StopTime, 
                      ROUND(Entertainers.EntPricePerDay * 2 * 1.15, 0) AS ContractPrice, Agents.AgentID
FROM         Customers CROSS JOIN
                      Entertainers CROSS JOIN
                      Agents
WHERE     (Customers.CustFirstName = 'Matt') AND (Customers.CustLastName = 'Berg') AND (Entertainers.EntStageName = 'Jazz Persuasion') AND 
                      (Agents.AgtFirstName = 'Karen') AND (Agents.AgtLastName = 'Smith');
GO

CREATE PROCEDURE CH16_Add_Style
AS 
INSERT INTO Musical_Styles
                      (StyleName)
VALUES     ('New Age');
GO

CREATE VIEW CH16_Add_Style_Query
AS
SELECT 'New Age' As NewStyeName;
GO

CREATE PROCEDURE CH16_Archive_Engagements
AS 
INSERT INTO Engagements_Archive 
         (EngagementNumber, StartDate, EndDate, StartTime, StopTime, ContractPrice, 
          CustomerID, AgentID, EntertainerID) 
SELECT Engagements.EngagementNumber, Engagements.StartDate, Engagements.EndDate, 
Engagements.StartTime, Engagements.StopTime, Engagements.ContractPrice, Engagements.CustomerID, 
Engagements.AgentID, Engagements.EntertainerID
FROM Engagements
WHERE Engagements.EndDate < '01/01/2018';
GO

CREATE VIEW CH16_Archive_Engagements_Query
AS 
SELECT Engagements.EngagementNumber, Engagements.StartDate, Engagements.EndDate, 
Engagements.StartTime, Engagements.StopTime, Engagements.ContractPrice, Engagements.CustomerID, 
Engagements.AgentID, Engagements.EntertainerID
FROM Engagements
WHERE Engagements.EndDate < '01/01/2018';
GO

CREATE PROCEDURE CH16_Copy_Agent_To_Customer
AS 
INSERT INTO Customers
                      (CustFirstName, CustLastName, CustStreetAddress, CustCity, CustState, CustZipCode, CustPhoneNumber)
SELECT     AgtFirstName, AgtLastName, AgtStreetAddress, AgtCity, AgtState, AgtZipCode, AgtPhoneNumber
FROM         Agents
WHERE     (AgtFirstName = 'Marianne') AND (AgtLastName = 'Wier');
GO

CREATE VIEW CH16_Copy_Agent_To_Customer_Query
AS 
SELECT     AgtFirstName, AgtLastName, AgtStreetAddress, AgtCity, AgtState, AgtZipCode, AgtPhoneNumber
FROM         Agents
WHERE     (AgtFirstName = 'Marianne') AND (AgtLastName = 'Wier');
GO

CREATE PROCEDURE CH16_Duplicate_Engagement
AS 
INSERT INTO Engagements
                      (StartDate, EndDate, StartTime, StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
SELECT     '8/1/2018' AS StartDate, '8/4/2018' AS EndDate, Engagements.StartTime, Engagements.StopTime, Engagements.ContractPrice, 
                      Engagements.CustomerID, Engagements.AgentID, Engagements.EntertainerID
FROM         Customers INNER JOIN
                      Engagements ON Customers.CustomerID = Engagements.CustomerID
WHERE     (Customers.CustFirstName = 'Doris') AND (Customers.CustLastName = 'Hartwig') AND (Engagements.StartDate = '12/2/2017');
GO

CREATE VIEW CH16_Duplicate_Engagement_Query
AS 
SELECT     '8/1/2018' AS StartDate, '8/4/2018' AS EndDate, Engagements.StartTime, Engagements.StopTime, Engagements.ContractPrice, 
                      Engagements.CustomerID, Engagements.AgentID, Engagements.EntertainerID
FROM         Customers INNER JOIN
                      Engagements ON Customers.CustomerID = Engagements.CustomerID
WHERE     (Customers.CustFirstName = 'Doris') AND (Customers.CustLastName = 'Hartwig') AND (Engagements.StartDate = '12/2/2017');
GO

CREATE PROCEDURE CH17_Delete_Customers_Never_Booked1
AS 
DELETE FROM Musical_Preferences
WHERE     (CustomerID NOT IN
                          (SELECT     CustomerID
                            FROM          Engagements));
GO

CREATE VIEW CH17_Delete_Customers_Never_Booked1_Query
AS 
SELECT * 
FROM Musical_Preferences
WHERE     (CustomerID NOT IN
                          (SELECT     CustomerID
                            FROM          Engagements));
GO

CREATE PROCEDURE CH17_Delete_Customers_Never_Booked2
AS 
DELETE FROM Customers
WHERE     (CustomerID NOT IN
                          (SELECT     CustomerID
                            FROM          Engagements));
GO

CREATE VIEW CH17_Delete_Customers_Never_Booked2_Query
AS 
SELECT * 
FROM Customers
WHERE     (CustomerID NOT IN
                          (SELECT     CustomerID
                            FROM          Engagements));
GO

CREATE PROCEDURE CH17_Delete_Entertainers_Not_Booked1
AS 
DELETE FROM Entertainer_Members
WHERE     (EntertainerID NOT IN
                          (SELECT     EntertainerID
                            FROM          Engagements));
GO

CREATE VIEW CH17_Delete_Entertainers_Not_Booked1_Query
AS 
SELECT * 
FROM Entertainer_Members
WHERE     (EntertainerID NOT IN
                          (SELECT     EntertainerID
                            FROM          Engagements));
GO

CREATE PROCEDURE CH17_Delete_Entertainers_Not_Booked2
AS 
DELETE FROM Entertainer_Styles
WHERE     (EntertainerID NOT IN
                          (SELECT     EntertainerID
                            FROM          Engagements));
GO

CREATE VIEW CH17_Delete_Entertainers_Not_Booked2_Query
AS 
SELECT * 
FROM Entertainer_Styles
WHERE     (EntertainerID NOT IN
                          (SELECT     EntertainerID
                            FROM          Engagements));
GO

CREATE PROCEDURE CH17_Delete_Entertainers_Not_Booked3
AS 
DELETE FROM Entertainers
WHERE     (EntertainerID NOT IN
                          (SELECT     EntertainerID
                            FROM          Engagements));
GO

CREATE VIEW CH17_Delete_Entertainers_Not_Booked3_Query
AS 
SELECT * 
FROM Entertainers
WHERE     (EntertainerID NOT IN
                          (SELECT     EntertainerID
                            FROM          Engagements));
GO

CREATE PROCEDURE CH17_Delete_Members_Not_In_Group
AS 
DELETE FROM Members
WHERE     (MemberID NOT IN
                          (SELECT     MemberID
                            FROM          Entertainer_Members));
GO

CREATE VIEW CH17_Delete_Members_Not_In_Group_Query
AS 
SELECT * 
FROM Members
WHERE     (MemberID NOT IN
                          (SELECT     MemberID
                            FROM          Entertainer_Members));
GO

CREATE PROCEDURE CH17_Delete_Styles_No_Entertainer
AS 
DELETE FROM Musical_Styles
WHERE     (StyleID NOT IN
                          (SELECT     StyleID
                           FROM          Entertainer_Styles))
      AND (StyleID NOT IN 
						  (SELECT StyleID 
						   FROM Musical_Preferences));
GO

CREATE VIEW CH17_Delete_Styles_No_Entertainer_Query
AS 
SELECT * 
FROM Musical_Styles
WHERE     (StyleID NOT IN
                          (SELECT     StyleID
                            FROM          Entertainer_Styles))
      AND (StyleID NOT IN 
						  (SELECT StyleID 
						   FROM Musical_Preferences));
GO

CREATE PROCEDURE CH17_Remove_Archived_Engagements
AS 
DELETE FROM Engagements
WHERE     (EngagementNumber IN
                          (SELECT     EngagementNumber
                            FROM          Engagements_Archive));
GO

CREATE VIEW CH17_Remove_Archived_Engagements_Query
AS 
SELECT * 
FROM Engagements
WHERE     (EngagementNumber IN
                          (SELECT     EngagementNumber
                            FROM          Engagements_Archive));
GO

