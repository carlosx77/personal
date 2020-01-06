-------------------------------------------------- SALES ORDER ------------------------------------------------
USE salesordersexample;

------------- CHAP 4
select VendName from Vendors;

select ProductName, RetailPrice from products;

select distinct (CustState) from customers;
-- Additional
select * from employees e;

select v.VendCity, VendName
from vendors v
order by VendCityasc;
------------- CHAP 5
select RetailPrice*QuantityOnHand as InventoryValue
from products p;

select OrderNumber, ShipDate, OrderDate, DATEDIFF (ShipDate, OrderDate)
from orders o;
-- Additional

select OrderNumber, ProductNumber 
from order_details od
where OrderNumber in ( 
SELECT DISTINCT OrderNumber FROM Order_Details
WHERE ProductNumber IN (1, 2, 6, 11)
intersect
SELECT DISTINCT OrderNumber FROM Order_Details
WHERE ProductNumber IN (10, 25, 26) )
order by ProductNumber

------------- CHAP 8
select p.ProductName, c.CategoryDescription
from products p inner join categories c using (CategoryID);

select distinct CONCAT (c.CustFirstName, ' ', c.CustLastName) as customer 
from customers c inner join orders o on c.CustomerID = o.CustomerID
                 inner join order_details od on o.OrderNumber = od.OrderNumber
                 inner join products p on od.ProductNumber= p.ProductNumber
where p.ProductNamelike '%helmet%'
order by customer;

-- “Find all the customers who ordered a bicycle and also ordered a helmet.”
-- In other words: 
-- “Find all the customers who ordered a bicycle, then find all the customers who ordered a helmet, and finally list the common customers
-- so that we know who ordered both a bicycle and a helmet.”
select custBikes.CustomerID, CustFirstName, CustLastName
from  ( select distinct c.CustomerID, c.CustFirstName, c.CustLastName
					from customers c inner join orders o using (CustomerId) inner join order_details od using (OrderNumber) inner join products p using (productnumber)
					where ProductNumber IN (1, 2, 6, 11) ) as custBikes 
		inner join 
	  ( select distinct c.CustomerID
					from customers c inner join orders o using (CustomerId) inner join order_details od using (OrderNumber) inner join products p using (productnumber)
					where ProductNumber IN (10, 25, 26) ) as custHelmets on (custbikes.CustomerID = custHelmets.CustomerID);
-- OR USING different where
				select custBikes.CustomerID, CustFirstName, CustLastName
from  ( select distinct c.CustomerID, c.CustFirstName, c.CustLastName
					from customers c inner join orders o using (CustomerId) inner join order_details od using (OrderNumber) inner join products p using (productnumber)
					where ProductName like ('%bike') ) as custBikes 
		inner join 
	  ( select distinct c.CustomerID
					from customers c inner join orders o using (CustomerId) inner join order_details od using (OrderNumber) inner join products p using (productnumber)
					where ProductName like ('%helmet%') ) as custHelmets on (custbikes.CustomerID = custHelmets.CustomerID);

-- Additional
-- 1. “List customers and the dates they placed an order, sorted in order date sequence.”
-- CH08_Customers_And_OrderDates 
select c.CustLastName, c.CustFirstName, o.OrderDate
from customers c inner join orders o using (CustomerID)
order by o.OrderDate;

-- 2. “List employees and the customers for whom they booked an order.”
-- CH08_Employees_And_Customers 
select distinct CONCAT (e.EmpLastName, ' ' ,  e.EmpFirstName) as employee, CONCAT (c.CustLastName, ' ', c.CustFirstName) as customer
from customers c inner join orders o using (CustomerID)
				 inner join employees e using (EmployeeID);
-- 3. “Display all orders, the products in each order, and the amount owed for each product, in order number sequence.”
select o.OrderNumber, p.ProductName, od.QuantityOrdered, od.QuantityOrdered*p.RetailPrice as AmountOwed
from orders o inner join order_details od on (o.OrderNumber=od.OrderNumber)
			  inner join products p on (od.ProductNumber = p.ProductNumber)
			  order by o.OrderNumber;
-- 4. “Show me the vendors and the products they supply to us for products that cost less than $100.”
select v.VendName, p.ProductName, pv.WholesalePrice
from products p inner join product_vendors pv using (productNumber)
				inner join vendors v using (vendorID)
				where pv.WholesalePrice<100;

-- 5. “Show me customers and employees who have the same last name.”
select CONCAT (cust.CustLastName, ' ',  cust.CustFirstName) as custName, CONCAT(emp.EmpLastName, ' ',  emp.EmpFirstName) as empName
from ( (select c.CustLastName, c.CustFirstName 
		from customers c) as cust
		inner join 
		(select e.EmpLastName, e.EmpFirstName from employees e) as emp  on (cust.CustLastName = emp.EmpLastName ) ) ;

-- 6. “Show me customers and employees who live in the same city.”
select CONCAT(c.CustLastName, ' ', c.CustFirstName), CONCAT( e.EmpLastName, ' ', e.EmpFirstName)
from customers c inner join employees e on ( c.CustCity = e.EmpCity);

------------- CHAP 9
-- “What products have never been ordered?”
select products.productname
from products left join order_details using (productnumber) where order_details.ordernumber is null

-- “Display all customers and any orders for bicycles.”
select customers.customerid, customers.custfirstname, customers.custlastname, B.productname
from customers left join 
(select orders.ordernumber, products.productname, orders.customerid
from orders inner join order_details using (ordernumber)
	inner join products 
	using (productnumber) 
	inner join categories 
	using (categoryid)
	where categories.categorydescription like '%Bikes%'  ) as B
 using (customerid)  






-------------------------------------------------- ENTERTAINMENT AGENCY ------------------------------------------------
use entertainmentagencyexample;
------------- CHAP 4
select EntStageName, EntCity
from entertainers e
order by EntCity asc, EntStageName asc;

select distinct StartDate
from engagements e;
-- Additional
select AgtFirstName, AgtLastName, AgtPhoneNumber
from agents a
order by AgtLastName asc, AgtFirstName asc;

select * from engagements e;

select EngagementNumber, StartDate 
from engagements e
order by StartDate desc, EngagementNumber asc;
------------- CHAP 5
select EngagementNumber, EndDate, StartDate, DATEDIFF (EndDate, StartDate) + 1
from engagements e;

select EngagementNumber, ContractPrice, ContractPrice*.12 as ourFee, 
CONCAT ( '$', FORMAT (ContractPrice-(ContractPrice*.12), 2))
from engagements e;
------------- CHAP 8
select e.EntStageName, en.StartDate, en.StopTime, en.ContractPrice
from entertainers e inner join engagements en using (EntertainerID);

-- “List the entertainers who played engagements for both customers Berg and Hallmark.” CH08_Entertainers_Berg_AND_Hallmark
select entBerg.EntertainerID, entBerg.EntStageName
from ( select distinct e.EntertainerID, e.EntStageName
			from entertainers e inner join engagements en using (EntertainerID) inner join customers c on (en.CustomerID = c.CustomerID)
			where c.CustLastName like ('%Berg%') )   as entBerg 
		inner join  (
		( select distinct e.EntertainerID
			from entertainers e inner join engagements en using (EntertainerID) inner join customers c on (en.CustomerID = c.CustomerID)
			where c.CustLastName like ('%Hallmark%') ) as entHall ) on (entBerg.EntertainerID = entHall.EntertainerID);

-- 1. “Display agents and the engagement dates they booked, sorted by booking start date.”
select CONCAT (a.AgtLastName, ' ', a.AgtFirstName) as agentName, e.StartDate
from agents a inner join engagements e on (a.AgentID= e.AgentID)
order by e.StartDate;
-- 2. “List customers and the entertainers they booked.”
select distinct CONCAT (c.CustLastName, ' ', c.CustFirstName) as customer, en.EntStageName
from customers c inner join engagements e on (c.CustomerID = e.CustomerID)
				 inner join entertainers en on (e.EntertainerID=en.EntertainerID);
		
-- 3. “Find the agents and entertainers who live in the same postal code.”
select distinct CONCAT (a.AgtLastName, ' ', a.AgtFirstName), e.EntStageName
from agents a inner join entertainers e on (a.AgtZipCode = e.EntZipCode);

------------- CHAP 9
--  “List entertainers who have never been booked.”
select entertainers.entertainerid, entertainers.entstagename
from entertainers left join engagements using (entertainerid) where engagements.engagementnumber is null

-- “Show me all musical styles and the customers who prefer those styles.”
select ms.stylename, a.customerid, a.custfirstname, a.custlastname
from musical_styles ms left join ( 
		select customers.customerid, customers.custfirstname, customers.custlastname, musical_preferences.styleid
		from customers 
			inner join musical_preferences 
			using (customerid) ) 
		as a using (styleid)



-------------------------------------------------- SCHOOLS SCHEDULING ------------------------------------------------
use schoolschedulingexample;
------------- CHAP 4
select * from classes c;

select BuildingName, NumberOfFloors
from buildings b
order by BuildingName asc;
-- Additional
select SubjectName
from subjects s;

select distinct Title
from faculty f;

select StfLastname, StfFirstName, StfPhoneNumber
from staff s
order by StfLastname, StfFirstName;

------------- CHAP 5
select StfLastname, StfFirstName, DateHired, 
TRUNCATE( DATEDIFF ('2017-10-01', DateHired)/365, 0 ) as years
from staff s
order by StfLastname, StfFirstName;

select CONCAT (StfLastname, ', ', StfFirstName ), Salary, Salary*1.07 as 'increment'
from staff s
order by StfLastname, StfFirstName;

------------- CHAP 8
select distinct s.SubjectName
from subjects s inner join classes c on (c.SubjectID = s.SubjectID)
where c.WednesdaySchedule = 1;

-- “Show me the students and teachers who have the same first name.”
select CONCAT ( s.StudFirstName, ' ', s.StudLastName) as StudName, 
       CONCAT( stf.StfFirstName, ' ', stf.StfLastName) as teacherName
from students s inner join staff stf on ( s.StudFirstName = stf.StfFirstName);

-- 1. “Display buildings and all the classrooms in each building.”
select *
from buildings b inner join class_rooms cr using (buildingCode);

-- 2. “List students and all the classes in which they are currently enrolled.”
select CONCAT (s.StudLastName, ' ', s.StudFirstName) as stuName, su.SubjectName, c.ClassID
from students s inner join student_schedules ss on (s.StudentID=ss.StudentID) 
				inner join classes c on (ss.ClassID=c.ClassID)
				inner join student_class_status scs on (ss.ClassStatus=scs.ClassStatus)
				inner join subjects su on ( su.SubjectID= c.SubjectID)
where scs.ClassStatusDescription='Enrolled';

-- 3. “List the faculty staff and the subject each teaches.”
select CONCAT (s.StfLastname, ' ', s.StfFirstName), su.SubjectName
from staff s inner join faculty_subjects fs using (staffId)
			 inner join subjects su using (subjectId)

-- 4. “Show me the students who have a grade of 85 or better in art and who also have a grade of 85 or better in any computer course.”
select distinct concat (stuArt.StudLastName, ' ', stuArt.StudFirstName)
from (
	(select s.StudLastName, s.StudFirstName, s.StudentID
	from students s inner join student_schedules ss on (s.StudentID=ss.StudentID) 
					inner join classes c on (ss.ClassID=c.ClassID)
					inner join subjects su on (su.SubjectID=c.SubjectID)
	where su.SubjectName like '%art%'
	and ss.Grade > 85 ) as stuArt
	inner join (
	select s.StudentID
	from students s inner join student_schedules ss on (s.StudentID=ss.StudentID) 
					inner join classes c on (ss.ClassID=c.ClassID)
					inner join subjects su on (su.SubjectID=c.SubjectID)
	where su.SubjectName like '%computer%'
	and ss.Grade > 85 
	) as stuComp on (stuArt.StudentID=stuComp.StudentID)  
	) ;

------------- CHAP 9
-- “List the faculty members not teaching a class.”
select s.stflastname, s.stffirstname
from staff s left outer join faculty_classes on faculty_classes.staffid = s.staffid
			where faculty_classes.classid is null
-- “Display students who have never withdrawn from a class.”
select distinct students.studentid, students.studfirstname, students.studlastname
from students left join ( 
	select student_schedules.studentid
	from student_class_status ss
		inner join student_schedules using (classstatus)
	where ss.classstatusdescription like 'withdrawn' ) as a
	on students.studentid = a.studentid
	where a.studentid is null

-- “Show me all subject categories and any classes for all subjects.”
select c.categoryid, c.categorydescription, subjects.subjectname, classes.startdate, classes.starttime, classes.duration
from categories c left join subjects using (categoryid)
				  left join classes using (subjectid) 
				  



-------------------------------------------------- BOWLING LEAGUE ------------------------------------------------

use bowlingleagueexample;
------------- CHAP 4
select distinct TourneyLocation
from tournaments t;

select TourneyDate, TourneyLocation
from tournaments t
order by TourneyDate desc, TourneyLocation asc;
-- Additional
select TeamName from teams t
order by TeamNameasc;

select BowlerID, RawScore, HandiCapScore
from bowler_scores bs;

select BowlerFirstName, BowlerLastName, BowlerAddress
from bowlers b
order by BowlerFirstName, BowlerLastName;
------------- CHAP 5
select CONCAT ( BowlerLastName, ', ', BowlerFirstName) as bowler, 
BowlerAddress,
CONCAT (BowlerCity, ', ', BowlerState, ', ', BowlerZip) as CityStateZip, 
BowlerZip
from bowlers b
order by BowlerZip;

select MatchID, GameNumber, BowlerID, RawScore, HandiCapScore,
HandiCapScore-RawScore as PointSpread
from bowler_scores bs;

------------- CHAP 8
select t.TeamName, b.BowlerFirstName, b.BowlerLastName
from teams t inner join bowlers b on (t.CaptainID = b.BowlerID);

-- select t.TourneyDate, t.TourneyLocation, mg.MatchID, mg.GameNumber, bs.RawScore, bs.HandiCapScore, bs.WonGame
-- from tournaments t inner join tourney_matches tm using (TourneyID) 
-- 					inner join match_games mg using (MatchID) 
-- 					inner join bowler_scores bs using (MatchID, GameNumber)

select tou.TourneyID, tou.TourneyLocation, tm.MatchID, tm.Lanes, mg.GameNumber, tOdd.TeamName as OddLaneTeam, tEven.TeamName as EvenLaneTeam, twin.TeamName as Winner 
from tournaments tou inner join tourney_matches tm on (tm.TourneyID = tou.TourneyID) 
					inner join teams tEven on (tm.EvenLaneTeamID = tEven.TeamID)
					inner join teams tOdd on (tm.OddLaneTeamID = tOdd.TeamID)
					inner join match_games mg on (mg.MatchID= tm.MatchID)
					inner join teams tWin on (mg.WinningTeamID = tWin.TeamID)

-- “Find the bowlers who had a raw score of 170 or better at both Thunderbird Lanes and Bolero Lanes.”
select locThunder.bowlerName
from ( select distinct bowlers.BowlerID, CONCAT ( bowlers.BowlerFirstName, ' ', bowlers.BowlerLastName) as bowlerName
				from bowlers 
				inner join bowler_scores on (bowler_scores.BowlerID = bowlers.BowlerID)
				inner join tourney_matches on ( bowler_scores.MatchID = tourney_matches.MatchID )
				inner join tournaments on ( tourney_matches.TourneyID = tournaments.TourneyID) 
		where tournaments.TourneyLocation like ('%Thunderbird%') 
		and bowler_scores.RawScore >= 170 
		) as locThunder 
		inner join ( ( 
			select distinct bowlers.BowlerID, CONCAT ( bowlers.BowlerFirstName, ' ', bowlers.BowlerLastName)   as bowlerName
			from bowlers 
				inner join bowler_scores on (bowler_scores.BowlerID = bowlers.BowlerID)
				inner join tourney_matches on ( bowler_scores.MatchID = tourney_matches.MatchID )
				inner join tournaments on ( tourney_matches.TourneyID = tournaments.TourneyID) 
			where tournaments.TourneyLocation like ('%Bolero%') 
			and bowler_scores.RawScore >= 170)  as locBol ) on ( locBol.BowlerID = locThunder.BowlerID );
		

-- 1. “List the bowling teams and all the team members.”
select teams.TeamName, concat (bowlers.BowlerLastName, ' ', bowlers.BowlerFirstName)
from teams inner join bowlers on bowlers.TeamID = teams.TeamID;

-- 2. “Display the bowlers, the matches they played in, and the bowler game scores.”
select distinct  bs.MatchID, concat (b.BowlerLastName, ' ', b.BowlerFirstName) as name,  bs.GameNumber,  bs.RawScore
from bowlers b inner join bowler_scores bs on (bs.BowlerID = b.BowlerID)
			 inner join teams t on (b.TeamID=t.TeamID);
			
-- 3. “Find the bowlers who live in the same ZIP Code.”
select distinct concat (b.BowlerLastName, ' ', b.BowlerFirstName), b.BowlerZip, concat (a.BowlerLastName, ' ', a.BowlerFirstName)
from bowlers a inner join bowlers b on a.BowlerZip=b.BowlerZip and b.BowlerID <> a.BowlerId;


------------- CHAP 9
-- “Show me tournaments that haven’t been played yet.”
select tournaments.tourneyid, tournaments.tourneylocation, tourneydate
from tournaments left join tourney_matches using (tourneyid) where tourney_matches.matchid is null

-- "List all bowlers and any games they bowled over 180.”
select Bowlers.BowlerLastName || ', ' ||
    Bowlers.BowlerFirstName AS BowlerName, a.matchid, a.rawscore, a.tourneylocation
from bowlers left join ( 
	select bs.matchid, bs.bowlerid, bs.rawscore, tournaments.tourneydate, tournaments.tourneylocation 
	from bowler_scores bs inner join tourney_matches using (matchid)
	inner join tournaments using (tourneyid)
	where bs.rawscore > 180 ) as a using (bowlerid)

SELECT Bowlers.BowlerLastName || ', ' ||
    Bowlers.BowlerFirstName AS BowlerName,
    TI.TourneyDate, TI.TourneyLocation,
    TI.MatchID, TI.RawScore FROM Bowlers
LEFT OUTER JOIN
    (SELECT Tournaments.TourneyDate,
        Tournaments.TourneyLocation,
        Bowler_Scores.MatchID,
        Bowler_Scores.BowlerID,
        Bowler_Scores.RawScore
    FROM (Bowler_Scores
     INNER JOIN Tourney_Matches
       ON Bowler_Scores.MatchID =
          Tourney_Matches.MatchID)
     INNER JOIN Tournaments
       ON Tournaments.TourneyID =
          Tourney_Matches.TourneyID
     WHERE Bowler_Scores.RawScore > 180)
   AS TI
ON Bowlers.BowlerID = TI.BowlerID





-------------------------------------------------- RECIPES EXAMPLE ------------------------------------------------

use recipesexample;
------------- CHAP 4
select RecipeClassID, RecipeTitle
from recipes r
order by RecipeClassID asc, r.RecipeTitle asc;
-- Additional
select IngredientName
from ingredients i;

select RecipeTitle
from recipes r
order by RecipeTitle asc;
------------- CHAP 8
select distinct RecipeTitle
from recipes r inner join recipe_ingredients ri on (r.RecipeID = ri.RecipeID) 
               inner join ingredients i on (ri.IngredientID = i.IngredientID)
where i.IngredientName like ('%Beef%') or i.IngredientNamelike ('%Garlic%')
order by r.RecipeTitle;

select r.RecipeTitle, i.IngredientName
from recipe_classes rc inner join recipes r using (RecipeClassID)
						inner join recipe_ingredients ri using (RecipeID)
						inner join ingredients i using (ingredientID)
where RecipeClassDescription = 'Main course';

-- “Display all the ingredients for recipes that contain carrots.”
-- select recipes and ingredients, only for recipes resulted from the inner select
select distinct r.RecipeID, r.RecipeTitle, ingredients.IngredientName
from recipes r inner join recipe_ingredients on recipe_ingredients.RecipeID = r.RecipeID
			   inner join ingredients on (ingredients.IngredientID = recipe_ingredients.IngredientID)
			   inner join (
(select r.RecipeID -- select recipes that contains carrots
from recipes r inner join recipe_ingredients on (recipe_ingredients.RecipeID = r.RecipeID)
			 inner join ingredients on (ingredients.IngredientID = recipe_ingredients.IngredientID)
			 where ingredients.IngredientName like ('%carrot%') ) as rec ) on ( r.RecipeID = rec.RecipeID ) ;

-- 1. “List all the recipes for salads.”
select r.RecipeTitle
from recipes r inner join recipe_classes on r.RecipeClassID = recipe_classes.RecipeClassID
where recipe_classes.RecipeClassDescription = 'Salad';

-- 2. “List all recipes that contain a dairy ingredient.”
select distinct r.RecipeTitle
from recipes r inner join recipe_ingredients ri on r.RecipeID=ri.RecipeID
			   inner join ingredients i on ri.IngredientID = i.IngredientID
			   inner join ingredient_classes ic on i.IngredientClassID=ic.IngredientClassID
			   where ic.IngredientClassDescription = 'Dairy';

-- 3. “Find the ingredients that use the same default measurement amount.”
select distinct i1.IngredientName, i2.IngredientName
from ingredients i1 inner join ingredients i2 on i1.IngredientID <> i2.IngredientID and i1.MeasureAmountID=i2.MeasureAmountID;

-- 4. “Show me the recipes that have beef and garlic.”
select rec1.RecipeTitle from ( (
select r.RecipeID, r.RecipeTitle
from recipes r inner join recipe_ingredients on (recipe_ingredients.RecipeID = r.RecipeID)
			 inner join ingredients on (ingredients.IngredientID = recipe_ingredients.IngredientID)
			 where ingredients.IngredientName like ('%beef%')  )  as rec1
			 inner join 
(select r.RecipeID, r.RecipeTitle -- select recipes that contains carrots
from recipes r inner join recipe_ingredients on (recipe_ingredients.RecipeID = r.RecipeID)
			 inner join ingredients on (ingredients.IngredientID = recipe_ingredients.IngredientID)
			 where ingredients.IngredientName like ('%garlic%') ) as rec2   on rec1.RecipeID=rec2.RecipeID)

------------- CHAP 9
-- Explains outer joins (or joins, the "outer" can be ommited for left and rigth)
-- “Show me all the recipe types and any matching recipes in my database.”
select rc.RecipeClassDescription, r.RecipeTitle
from recipe_classes rc left outer join recipes r on r.RecipeClassID = rc.RecipeClassID;
select *
from recipe_classes rc left join recipes r on r.RecipeClassID = rc.RecipeClassID;
-- show me the recipe type that dont have a recipe or
-- -- “List the recipe classes that do not yet have any recipes.”
select *
from recipe_classes rc left outer join recipes r on r.RecipeClassID = rc.RecipeClassID
where r.RecipeID is null;
select *
from recipe_classes rc left join recipes r on r.RecipeClassID = rc.RecipeClassID
where r.RecipeID is null;
select *
from recipe_classes rc left join recipes r using (RecipeClassID)
where r.RecipeID is null;
-- show me all the recipes that have a recipe type or not
select *
from recipe_classes rc right outer join recipes r on r.RecipeClassID = rc.RecipeClassID;
select *
from recipe_classes rc right join recipes r on r.RecipeClassID = rc.RecipeClassID;
-- show me the recipe that dont have a recipe type
select *
from recipe_classes rc right outer join recipes r on r.RecipeClassID = rc.RecipeClassID
where rc.RecipeClassDescription is null; -- there is no recipe with no class (all have at least one class)
select *
from recipe_classes rc right join recipes r on r.RecipeClassID = rc.RecipeClassID
where rc.RecipeClassDescription is null;


-- If interested only on certain recipe classes
SELECT RCFiltered.ClassName, R.RecipeTitle
FROM
    (SELECT RecipeClassID,
        RecipeClassDescription AS ClassName
       FROM Recipe_Classes rc
     WHERE rc.RecipeClassDescription = 'Salad'
     OR rc.recipeclassdescription = 'Soup'
     OR rc.RecipeClassDescription = 'Main course')
   AS RCFiltered
LEFT OUTER JOIN Recipes AS R
  ON RCFiltered.RecipeClassID = R.RecipeClassID

			 
SELECT RCFiltered.ClassName, R.RecipeTitle
from (
	SELECT RecipeClassID, RecipeClassDescription as ClassName
	FROM Recipe_Classes RC
	WHERE RC.RecipeClassDescription = 'Salad'
		OR RC.RecipeClassDescription = 'Soup'
		OR RC.RecipeClassDescription = 'Main course'
	) AS RCFiltered
	LEFT OUTER JOIN
	(
	SELECT Recipes.RecipeClassID, Recipes.RecipeTitle
	FROM Recipes
	WHERE Recipes.RecipeTitle LIKE '%beef%'
	) AS R
	ON RCFiltered.RecipeClassID = R.RecipeClassID

-- Another simple way is to use conditions after the on clause
-- Be careful when using this way of filtering sets or tables
-- WARNNING!!!!!!!!!! this doest work correctly on MySQL, neither on PostgreSQL!!!!!
-- MySql takes the full Recipe table (the left table on left join) even when there is the filter for only Salads, Soup, Main Course
-- only filters recipes (the right table)
SELECT Recipe_Classes.RecipeClassDescription,
   Recipes.RecipeTitle
FROM Recipe_Classes
LEFT JOIN Recipes
ON (Recipe_Classes.RecipeClassID =
   Recipes.RecipeClassID
and 
   (Recipe_Classes.RecipeClassDescription = 'Salads'
OR Recipe_Classes.RecipeClassDescription = 'Soup'
OR Recipe_Classes.RecipeClassDescription = 'Main course') 
AND Recipes.RecipeTitle LIKE '%beef%' );

-- OTHER QUERY:
-- “I need all the recipe types, and the matching recipe names, preparation instructions, ingredient names, 
-- ingredient step numbers, ingredient quantities, and ingredient measurements from my recipes database, 
-- sorted in recipe title and step number sequence.”
-- List filtered recipes types with their ingredients list
-- A common error IS:
SELECT rc.RecipeClassDescription, R.RecipeTitle, ri.RecipeSeqNo, i.IngredientName 
from (recipe_classes rc LEFT OUTER JOIN Recipes R ON (rc.RecipeClassID = r.RecipeClassID) )
inner join recipe_ingredients ri on (r.RecipeID = ri.RecipeID)
inner join ingredients i on (i.IngredientID = ri.IngredientID )
     WHERE rc.RecipeClassDescription = 'Salad'
     OR rc.RecipeClassDescription = 'Soup'
     OR rc.RecipeClassDescription = 'Main course'
order by rc.RecipeClassDescription, R.RecipeTitle, ri.RecipeSeqNo
-- This does not show the recipe class name "Soup"

-- to get the soup we need to rewrite the query as follows
select recipe_classes.RecipeClassDescription, recipes.RecipeTitle, recipe_ingredients.RecipeSeqNo, ingredients.IngredientName, recipe_ingredients.Amount, measurements.MeasurementDescription
from recipe_classes left outer join (
							recipes inner join recipe_ingredients on (recipes.RecipeID=recipe_ingredients.RecipeID)
									inner join ingredients on (ingredients.IngredientID= recipe_ingredients.IngredientID )
									inner join measurements on (recipe_ingredients.MeasureAmountID = measurements.MeasureAmountID)
							) on (recipe_classes.RecipeClassID = recipes.RecipeClassID) 
where recipe_classes.RecipeClassDescription  = 'Salad'
     OR recipe_classes.RecipeClassDescription = 'Soup'
     OR recipe_classes.RecipeClassDescription = 'Main course';
-- the following is the same
SELECT Recipe_Classes.RecipeClassDescription,
    Recipes.RecipeTitle, Recipes.Preparation,
    Ingredients.IngredientName,
    Recipe_Ingredients.RecipeSeqNo,
    Recipe_Ingredients.Amount,
    Measurements.MeasurementDescription
FROM Recipe_Classes LEFT OUTER JOIN
    (((Recipes
    INNER JOIN Recipe_Ingredients
    ON Recipes.RecipeID =
       Recipe_Ingredients.RecipeID)
    INNER JOIN Ingredients
    ON Ingredients.IngredientID =
       Recipe_Ingredients.IngredientID)
    INNER JOIN Measurements
    ON Measurements.MeasureAmountID =
       Recipe_Ingredients.MeasureAmountID)
ON Recipe_Classes.RecipeClassID =
    Recipes.RecipeClassID
ORDER BY RecipeTitle, RecipeSeqNo


-- “I need all the recipe types, and the matching recipe names, preparation instructions, ingredient names, 
-- ingredient step numbers, ingredient quantities, and ingredient measurements from my recipes database, 
-- sorted in recipe title and step number sequence.”
-- VS
-- “I need all the recipe types, and then all the recipe names and preparation instructions, and then any matching ingredient names,
--  ingredient step numbers, ingredient quantities, and ingredient measurements from my recipes database, 
-- sorted in recipe title and step number sequence.”
select * 
from recipe_classes rc left outer join recipes r on r.RecipeClassID = rc.RecipeClassID
					left outer join ( select recipe_ingredients.IngredientID,
											 recipe_ingredients.Amount,
											 measurements.MeasurementDescription
					from recipe_ingredients inner join ingredients on recipe_ingredients.IngredientID = ingredients.IngredientID
								   				   inner join measurements on ingredients.MeasureAmountID = measurements.MeasureAmountID ) as recipe_det
				    on (r.RecipeID = recipe_det.IngredientID) 

SELECT Recipe_Classes.RecipeClassDescription,
    Recipes.RecipeTitle, Recipes.Preparation,
    Recipe_Details.IngredientName,
    Recipe_Details.RecipeSeqNo,
    Recipe_Details.Amount,
    Recipe_Details.MeasurementDescription
FROM (Recipe_Classes
LEFT OUTER JOIN Recipes
  ON Recipe_Classes.RecipeClassID =
     Recipes.RecipeClassID)
LEFT OUTER JOIN
(SELECT Recipe_Ingredients.RecipeID,
    Recipe_Ingredients.RecipeSeqNo,
    Recipe_Ingredients.Amount,
    Ingredients.IngredientName,
    Measurements.MeasurementDescription
  FROM (Recipe_Ingredients
  INNER JOIN Ingredients
    ON Ingredients.IngredientID =
     Recipe_Ingredients.IngredientID)
  INNER JOIN Measurements
    ON Measurements.MeasureAmountID =
      Recipe_Ingredients.MeasureAmountID)
  AS Recipe_Details
  ON Recipes.RecipeID =
     Recipe_Details.RecipeID
ORDER BY RecipeTitle, RecipeSeqNo;

-- Another more difficult:
-- “I need all the recipe types, and then all the recipe names and preparation instructions, 
-- and then any matching ingredient step numbers, ingredient quantities, and ingredient measurements, and finally all ingredient names 
-- from my recipes database, sorted in recipe title and step number sequence.”
-- The previous query can not be obtained using left or right joins, we need FULL OUTER JOIN


select recipe_classes.recipeclassdescription, 
	B.recipeTitle, 	B.preparation, 	C.ingredientname,
	B.recipeseqno,	B.Amount, B.MeasurementDescription
from recipe_classes full outer join (
						select recipe_ingredients.recipeseqno, recipes.preparation, recipes.RecipeTitle, recipe_ingredients.Amount, measurements.MeasurementDescription, recipes.RecipeClassID, recipe_ingredients.ingredientid
						from recipes left join recipe_ingredients using (RecipeID) 
									 inner join measurements using (MeasureAmountID) 
					) as B on (recipe_classes.RecipeClassID= b.RecipeClassID)
				   full outer join (
						select i.IngredientName, m.MeasurementDescription , i.ingredientid
						from ingredients i left join measurements m using (MeasureAmountID)
					) as C on ( B.IngredientID=C.IngredientID) 
ORDER BY RecipeTitle, RecipeSeqNo
					
SELECT Recipe_Classes.RecipeClassDescription,
Recipe_Details.RecipeTitle, Recipe_Details.Preparation,
Ingredients.IngredientName,
Recipe_Details.RecipeSeqNo,
Recipe_Details.Amount,
Recipe_Details.MeasurementDescription
FROM (Recipe_Classes
FULL OUTER JOIN
 (SELECT Recipes.RecipeID, Recipes.RecipeClassID,
    Recipes.RecipeTitle, Recipes.Preparation,
    Recipe_Measures.Amount,
    Recipe_Measures.RecipeSeqNo,
    Recipe_Measures.MeasurementDescription,
    Recipe_Measures.IngredientID
  FROM Recipes
  LEFT OUTER JOIN
    (SELECT Recipe_Ingredients.RecipeID,
       Recipe_Ingredients.IngredientID,
       Recipe_Ingredients.RecipeSeqNo,
       Recipe_Ingredients.Amount,
       Measurements.MeasurementDescription
     FROM Recipe_Ingredients
     INNER JOIN Measurements
       ON Measurements.MeasureAmountID =
         Recipe_Ingredients.MeasureAmountID)
    AS Recipe_Measures
  ON Recipes.RecipeID =
    Recipe_Measures.RecipeID) AS Recipe_Details
ON Recipe_Classes.RecipeClassID =
    Recipe_Details.RecipeClassID)
FULL OUTER JOIN Ingredients
ON Ingredients.IngredientID =
Recipe_Details.IngredientID
ORDER BY RecipeTitle, RecipeSeqNo


-- “List ingredients not used in any recipe yet.”
select *
from ingredients left join recipe_ingredients using (ingredientid) where recipe_ingredients.recipeid is null
			

					
----- EXPRESSIONS
--- working with TIME, DATE AND TIMESTAMP
select CAST('2016-11-22' AS DATE);
select CAST('03:30:25' AS TIME);
select CAST('2008-09-29 14:25:00' AS DATETIME);

-- CONCATENATING
-- literal values 
select "STR1" || " " || "STR2"; -- by default mysql appplies OR
-- set sql_mode to PIPES_AS_CONCAT to force mysql to concatenate strings
select CONCAT ( "STR1" , " " , "STR2");

select CONCAT (StfFirstName, ' ', StfLastname, ' ', DateHired)
from staff s;


--- MATHEMATICAL EXPRESSIONS:
abs() -- absolute value
mod() -- dividend, divisor
ln() -- natural logarithm
exp() -- natual logarithm raised to the power of the expression
power() -- numeric base, numeric exponent, return value base raised to the power of expression
sqrt()
floor() -- returns the largest integer less than or equal the expression
ceil or ceiling () -- returns the smallest greater than or equal the expression
+
-
/
*
 -- WHEN USING CAST and having decimals you need to check 
 -- as some DB round numbers and others not
FORMAT (ContractPrice, 2) -- sets 2 decimals representation
-- INTERVAL
SELECT     TourneyLocation, TourneyDate, 
TourneyDate + Interval 364 Day AS NextYearTourneyDate
FROM          Tournaments
ORDER BY TourneyLocation;


-- Comparing dates
-- on mysql is possible to use
-- date1 < date2 or >< or any other
-- also use between,

-- BETWEEN
-- remenber between is inclusive

-- NOT
-- can be used with between, in, like, null
-- also can be used after a WHERE:
-- where NOT column = value (all except value)


-- INTERSECT 
-- interseca, alias pega, no es muy comun su implementacion en las bd's
-- “Show me the orders that contain both a bike and a helmet.”
-- you could try to do WHERE ProductNumber in (1, 2, 6, 10, 11, 25, 26) BUT this is not correct because it says that on the same
-- order both are present, using IN () will show orders that have bike or helmet, but not both on the same order

select distinct (OrderNumber) 
from order_details od
where OrderNumber in ( 
SELECT DISTINCT OrderNumber FROM Order_Details
WHERE ProductNumber IN (1, 2, 6, 11)
intersect -- THIS IS A VERY EXPENSIVE OPERATION!!!!!!!! check difference with next queries that do the same
SELECT DISTINCT OrderNumber FROM Order_Details
WHERE ProductNumber IN (10, 25, 26) )
order by ProductNumber;
-- Another way to express the same
select distinct OrderNumber
from order_details od
where ProductNumber in (1, 2, 6, 11)
and OrderNumber in ( select distinct OrderNumber from order_details where ProductNumber in (10, 25, 26) );
-- Also we could rewrite it using group by!!!!
select distinct OrderNumber
from order_details od
group by OrderNumber
having max(ProductNumberin(1, 2, 6, 11)) > 0 and max(ProductNumber in (10, 25, 26)) > 0 
-- having clause because I find it flexible for a wide range of conditions, such as bike and helmet, but not wheels. Or three of bike, helmet, wheels, and other product
-- ANOTHER SOLUTION IS USING inner join (in a very similar way as the following example)

-- “Find all the customers who ordered a bicycle and also ordered a helmet.”
select custBikes.CustomerID, CustFirstName, CustLastName
from  ( select distinct c.CustomerID, c.CustFirstName, c.CustLastName
					from customers c inner join orders o using (CustomerId) inner join order_details od using (OrderNumber) inner join products p using (productnumber)
					where ProductNumber IN (1, 2, 6, 11) ) as custBikes 
		inner join 
	  ( select distinct c.CustomerID
					from customers c inner join orders o using (CustomerId) inner join order_details od using (OrderNumber) inner join products p using (productnumber)
					where ProductNumber IN (10, 25, 26) ) as custHelmets on (custbikes.CustomerID = custHelmets.CustomerID);

SELECT CustBikes.CustFirstName, CustBikes.CustLastName
from  ( SELECT DISTINCT Customers.CustomerID,  Customers.CustFirstName,  Customers.CustLastName 
	                FROM ((Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID) INNER JOIN Order_Details ON Orders.OrderNumber = Order_Details.OrderNumber)
                           INNER JOIN Products ON Products.ProductNumber = Order_Details.ProductNumber
							WHERE Products.ProductName LIKE '%Bike') AS CustBikes 
	    INNER join
	    (SELECT DISTINCT Customers.CustomerID 
	                FROM ((Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID) INNER JOIN Order_Details ON Orders.OrderNumber = Order_Details.OrderNumber)
							INNER JOIN Products ON Products.ProductNumber = Order_Details.ProductNumber 
							WHERE Products.ProductName LIKE '%Helmet') AS CustHelmets ON CustBikes.CustomerID = CustHelmets.CustomerID



-- INCORRECT:
SELECT DISTINCT OrderNumber
FROM Order_Details
WHERE ProductNumber IN
(1, 2, 6, 10) and ProductNumber in (11, 25, 26)

-- IF DONT WANT TO USE INTERSECT CHECK CHAP 8


-- EXCEPT

-- “Show me the orders that contain a bike but not a helmet.”
-- Lo primero que hubiera hecho sería:
SELECT DISTINCT OrderNumber FROM Order_Details WHERE ProductNumber IN (1, 2, 6, 11) AND ProductNumber NOT IN (10, 25, 26);
-- Pero entrega ordenes que solo entregan byke, la demostracion es que es igual al siguiente query
SELECT DISTINCT OrderNumber FROM Order_Details WHERE ProductNumber IN (1, 2, 6, 11)

-- La solución es except:
SELECT DISTINCT OrderNumber
FROM Order_Details
WHERE ProductNumber IN (1, 2, 6, 11)
EXCEPT
SELECT DISTINCT OrderNumber
FROM Order_Details
WHERE ProductNumber IN (10, 25, 26);
-- another option is:
SELECT DISTINCT OrderNumber FROM Order_Details 
WHERE ProductNumber IN (1, 2, 6, 11) 
and OrderNumber not in (select distinct OrderNumber from order_details where ProductNumber in (10, 25, 26) )


-- UNION
-- “Show me the orders that contain either a bike or a helmet.”
-- In this case filtering with IN works! but its because we are joining the same table, if there were two tables involved
-- it would no be as easy
SELECT DISTINCT OrderNumber
FROM Order_Details
WHERE ProductNumber IN (1, 2, 6, 10, 11, 25, 26)

SELECT DISTINCT OrderNumber
FROM Order_Details
WHERE ProductNumber IN (1, 2, 6, 11)
UNION
SELECT DISTINCT OrderNumber
FROM Order_Details
WHERE ProductNumber IN (10, 25, 26)


-- JOIN
-- “Show me the recipe title, preparation, and recipe class description of all recipes in my database.”
select * 
from recipe_classes rc inner join recipes r on (r.RecipeClassID = rc.RecipeClassID);
-- these two are equivalent
select * 
from recipe_classes rc inner join recipes r using (recipeclassId);


-- Change the table name by a DERIVED TABLE (the derived table is a select)
SELECT R.RecipeTitle, R.Preparation,
RCFiltered.RecipeClassDescription
FROM
	  (SELECT RecipeClassID,
	 RecipeClassDescription
	FROM Recipe_Classes
	WHERE RecipeClassDescription = 'Main course' OR
	 RecipeClassDescription = 'Dessert')  RCFiltered
INNER JOIN Recipes AS R
	  ON RCFiltered.RecipeClassID = R.RecipeClassID;

-- “I need the recipe type, recipe name, preparation instructions, 
-- ingredient names, ingredient step numbers, ingredient quantities, 
-- and ingredient measurements from my recipes database, 
-- sorted in step number sequence.”
SELECT Recipe_Classes.RecipeClassDescription, Recipes.RecipeTitle, Recipes.Preparation,
       Ingredients.IngredientName, Recipe_Ingredients.RecipeSeqNo, Recipe_Ingredients.Amount,
       Measurements.MeasurementDescription
FROM (((Recipe_Classes INNER JOIN Recipes ON Recipe_Classes.RecipeClassID = Recipes.RecipeClassID)
					   INNER JOIN Recipe_Ingredients ON Recipes.RecipeID = Recipe_Ingredients.RecipeID)
					   INNER JOIN Ingredients ON Ingredients.IngredientID = Recipe_Ingredients.IngredientID)
					   INNER JOIN Measurements ON Measurements.MeasureAmountID = Recipe_Ingredients.MeasureAmountID
					   ORDER BY RecipeTitle, RecipeSeqNo
-- Another way to write it
SELECT Recipe_Classes.RecipeClassDescription, Recipes.RecipeTitle, Recipes.Preparation,
       Ingredients.IngredientName, Recipe_Ingredients.RecipeSeqNo, Recipe_Ingredients.Amount,
       Measurements.MeasurementDescription
FROM Recipe_Classes INNER JOIN (((Recipes INNER JOIN Recipe_Ingredients ON Recipes.RecipeID = Recipe_Ingredients.RecipeID)
                    					  INNER JOIN Ingredients ON Ingredients.IngredientID = Recipe_Ingredients.IngredientID)
                    					  INNER JOIN Measurements ON Measurements.MeasureAmountID = Recipe_Ingredients.MeasureAmountID) 
                    ON Recipe_Classes.RecipeClassID = Recipes.RecipeClassID 
ORDER BY RecipeTitle, RecipeSeqNo


-- No hay necesidad de tanto parentesis, y es mas claro:
select r.RecipeClassID, r.RecipeTitle, 
ri.RecipeSeqNo, i.IngredientName, 
ri.Amount, m.MeasurementDescription
from (recipe_classes rc inner join recipes r on (rc.RecipeClassID = r.RecipeClassID) 
                        inner join recipe_ingredients ri on (ri.RecipeID = r.RecipeID) 
                        inner join ingredients i on (i.IngredientID = ri.IngredientID)
                        inner join measurements m on (m.MeasureAmountID =  ri.MeasureAmountID) )
order by r.RecipeTitle, ri.RecipeSeqNo;
                        
-- Puedo usar INNER JOINS para encontrar valores iguales en dos tablas (o en la misma pero con alias) sobre columnas
--  que no necesariamente son ids

