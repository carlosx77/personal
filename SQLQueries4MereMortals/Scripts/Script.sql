USE salesordersexample;

select VendName from Vendors;

select ProductName, RetailPrice from products;

select distinct (CustState) from customers;
-- Additional
select * from employees e;

select v.`VendCity`, `VendName`
from vendors v
order by `VendCity`asc




use entertainmentagencyexample;

select `EntStageName`, `EntCity`
from entertainers e
order by `EntCity` asc, `EntStageName` asc;

select distinct `StartDate`
from engagements e;

select `AgtFirstName`, `AgtLastName`, `AgtPhoneNumber`
from agents a
order by `AgtLastName` asc, `AgtFirstName` asc;

select * from engagements e;

select `EngagementNumber`, `StartDate` 
from engagements e
order by `StartDate` desc, `EngagementNumber` asc;




use schoolschedulingexample;

select * from classes c;

select `BuildingName`, `NumberOfFloors`
from buildings b
order by `BuildingName` asc;




use bowlingleagueexample;

select distinct `TourneyLocation`
from tournaments t;

select `TourneyDate`, `TourneyLocation`
from tournaments t
order by `TourneyDate` desc, `TourneyLocation` asc;





use recipesexample;

select `RecipeClassID`, `RecipeTitle`
from recipes r
order by `RecipeClassID` asc, r.`RecipeTitle` asc;




