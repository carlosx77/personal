CREATE VIEW CH04_Bowler_Names_Addresses
AS 
SELECT BowlerLastName, BowlerFirstName, BowlerAddress, BowlerCity, BowlerState, BowlerZip
FROM Bowlers
ORDER BY BowlerLastName, BowlerFirstName;



CREATE VIEW CH04_Bowler_Score_Information
AS 
SELECT Bowler_Scores.*
FROM Bowler_Scores;



CREATE VIEW CH04_Team_List
AS 
SELECT TeamName
FROM Teams
ORDER BY TeamName;



CREATE VIEW CH04_Tourney_Dates
AS 
SELECT TourneyDate, TourneyLocation
FROM Tournaments
ORDER BY TourneyDate DESC , TourneyLocation;



CREATE VIEW CH04_Tourney_Locations
AS 
SELECT DISTINCT TourneyLocation
FROM Tournaments;



CREATE VIEW CH05_Handicap_vs_RawScore
AS 
SELECT BowlerID, MatchID, GameNumber, HandiCapScore, RawScore, HandicapScore-RawScore AS PointDifference
FROM Bowler_Scores
ORDER BY BowlerID, MatchID, GameNumber;



CREATE VIEW CH05_Names_Address_For_Mailing
AS 
SELECT BowlerFirstName || ' ' || BowlerLastName AS FullName, Bowlers.BowlerAddress, BowlerCity || ', ' || BowlerState || '  ' || BowlerZip AS CityStateZip, BowlerZip
FROM Bowlers
ORDER BY BowlerZip;



CREATE VIEW CH05_Next_Years_Tourney_Dates
AS 
SELECT TourneyLocation, TourneyDate, TourneyDate+364 AS NextYearTourneyDate
FROM Tournaments
ORDER BY TourneyLocation;



CREATE VIEW CH05_Phone_List
AS 
SELECT BowlerLastName || ', ' || BowlerFirstName AS Bowler, BowlerPhoneNumber AS Phone
FROM Bowlers
ORDER BY BowlerLastName || ', ' || BowlerFirstName;



CREATE VIEW CH05_Team_Lineups
AS 
SELECT TeamID, BowlerLastName || ', ' || BowlerFirstName AS Bowler
FROM Bowlers
ORDER BY TeamID, BowlerLastName || ', ' || BowlerFirstName;



CREATE VIEW CH06_Eastside_Bowlers_On_Teams_5_Through_8
AS 
SELECT BowlerFirstName, BowlerLastName, BowlerCity, TeamID
FROM Bowlers
WHERE BowlerCity In ('Bellevue','Bothell','Duvall','Redmond','Woodinville') And TeamID Between 5 And 8
ORDER BY BowlerCity, BowlerLastName;



CREATE VIEW CH06_Eastside_Tournaments
AS 
SELECT TourneyLocation, TourneyDate
FROM Tournaments
WHERE TourneyLocation In ('Red Rooster Lanes','Thunderbird Lanes','Bolero Lanes')
ORDER BY TourneyLocation, TourneyDate;



CREATE VIEW CH06_Game3_Top_Ten_Matches
AS 
SELECT WinningTeamID, MatchID, GameNumber
FROM Match_Games
WHERE MatchID<=10 And GameNumber=3;



CREATE VIEW CH06_H_Bowlers_Teams_3_Through_5
AS 
SELECT Bowlers.BowlerFirstName, Bowlers.BowlerLastName, Bowlers.TeamID
FROM Bowlers
WHERE (Bowlers.BowlerLastName Like 'H*')
AND (Bowlers.TeamID In (3,4,5));



CREATE VIEW CH06_September_2017_Tournament_Schedule
AS 
SELECT TourneyDate, TourneyLocation
FROM Tournaments
WHERE TourneyDate Between '9/1/2017' And '9/30/2017';



CREATE VIEW CH08_Bowler_Game_Scores
AS 
SELECT Bowler_Scores.MatchID, Teams.TeamName, (Bowlers.BowlerFirstName || ' ' || Bowlers.BowlerLastName) AS BowlerFullName, Bowler_Scores.GameNumber, Bowler_Scores.RawScore
FROM (Teams
INNER JOIN Bowlers
ON Teams.TeamID=Bowlers.TeamID)
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID;



CREATE VIEW CH08_Bowlers_Same_ZipCode
AS 
SELECT (Bowlers.BowlerLastName || ', ' || Bowlers.BowlerFirstName) AS FirstBowler, Bowlers.BowlerZip, (Bowlers2.BowlerLastName || ', ' || Bowlers2.BowlerFirstName) AS SecondBowler
FROM Bowlers
INNER JOIN Bowlers AS Bowlers2
ON (Bowlers.BowlerID<>Bowlers2.BowlerID)
AND (Bowlers.BowlerZip=Bowlers2.BowlerZip);



CREATE VIEW CH08_Good_Bowlers_TBird_And_Bolero
AS 
SELECT BowlerTbird.BowlerFullName
FROM (SELECT DISTINCT Bowlers.BowlerID, (Bowlers.BowlerLastName || ', ' || Bowlers.BowlerFirstName) AS BowlerFullName FROM ((Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID)
INNER JOIN Tourney_Matches
ON Tourney_Matches.MatchID=Bowler_Scores.MatchID)
INNER JOIN Tournaments
ON Tournaments.TourneyID=Tourney_Matches.TourneyID WHERE Tournaments.TourneyLocation='Thunderbird Lanes' And Bowler_Scores.RawScore>=170)  AS BowlerTbird
INNER JOIN (SELECT DISTINCT Bowlers.BowlerID, (Bowlers.BowlerLastName || ', ' || Bowlers.BowlerFirstName) AS BowlerFullName FROM ((Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID)
INNER JOIN Tourney_Matches
ON Tourney_Matches.MatchID=Bowler_Scores.MatchID)
INNER JOIN Tournaments
ON Tournaments.TourneyID=Tourney_Matches.TourneyID WHERE Tournaments.TourneyLocation='Bolero Lanes' And Bowler_Scores.RawScore>=170)  AS BowlerBolero
ON BowlerTbird.BowlerID=BowlerBolero.BowlerID;



CREATE VIEW CH08_Teams_And_Bowlers
AS 
SELECT Teams.TeamName, (Bowlers.BowlerLastName || ', ' || Bowlers.BowlerFirstName) AS BowlerFullName
FROM Teams
INNER JOIN Bowlers
ON Teams.TeamID=Bowlers.TeamID;



CREATE VIEW CH08_Teams_And_Captains
AS 
SELECT Teams.TeamName, (Bowlers.BowlerLastName || ', ' || Bowlers.BowlerFirstName) AS CaptainName
FROM Teams
INNER JOIN Bowlers
ON Teams.CaptainID=Bowlers.BowlerID;



CREATE VIEW CH08_Tournament_Match_Game_Results
AS 
SELECT Tournaments.TourneyID AS Tourney, Tournaments.TourneyLocation AS Location, Tourney_Matches.MatchID, Tourney_Matches.Lanes, OddTeam.TeamName AS OddLaneTeam, EvenTeam.TeamName AS EvenLaneTeam, Match_Games.GameNumber AS GameNo, Winner.TeamName AS Winner
FROM ((((Tournaments
INNER JOIN Tourney_Matches
ON Tournaments.TourneyID=Tourney_Matches.TourneyID)
INNER JOIN Teams AS OddTeam
ON OddTeam.TeamID=Tourney_Matches.OddLaneTeamID)
INNER JOIN Teams AS EvenTeam
ON EvenTeam.TeamID=Tourney_Matches.EvenLaneTeamID)
INNER JOIN Match_Games
ON Match_Games.MatchID=Tourney_Matches.MatchID)
INNER JOIN Teams AS Winner
ON Winner.TeamID=Match_Games.WinningTeamID;



CREATE VIEW CH09_All_Bowlers_And_Scores_Over_180
AS 
SELECT Bowlers.BowlerLastName || ', ' || Bowlers.BowlerFirstName AS BowlerName, TI.TourneyDate, TI.TourneyLocation, TI.MatchID, TI.RawScore
FROM Bowlers LEFT JOIN (SELECT Tournaments.TourneyDate, Tournaments.TourneyLocation, Bowler_Scores.MatchID, Bowler_Scores.BowlerID, Bowler_Scores.RawScore FROM (Bowler_Scores
INNER JOIN Tourney_Matches
ON Bowler_Scores.MatchID=Tourney_Matches.MatchID)
INNER JOIN Tournaments
ON Tournaments.TourneyID=Tourney_Matches.TourneyID WHERE Bowler_Scores.RawScore>180)  AS TI
ON Bowlers.BowlerID=TI.BowlerID
ORDER BY Bowlers.BowlerLastName || ', ' || Bowlers.BowlerFirstName;



CREATE VIEW CH09_All_Tourneys_Match_Results
AS 
SELECT Tournaments.TourneyID, Tournaments.TourneyDate, Tournaments.TourneyLocation, TM.MatchID, TM.GameNumber, TM.Winner
FROM Tournaments LEFT JOIN (SELECT Tourney_Matches.TourneyID, Tourney_Matches.MatchID, Match_Games.GameNumber, Teams.TeamName AS Winner FROM Tourney_Matches
INNER JOIN (Teams
INNER JOIN Match_Games
ON Teams.TeamID=Match_Games.WinningTeamID)
ON Tourney_Matches.MatchID=Match_Games.MatchID)  AS TM
ON Tournaments.TourneyID=TM.TourneyID
ORDER BY Tournaments.TourneyID;



CREATE VIEW CH09_Matches_Not_Played_Yet
AS 
SELECT Tourney_Matches.MatchID, Tourney_Matches.TourneyID, Teams.TeamName AS OddLaneTeam, Teams_1.TeamName AS EvenLaneTeam
FROM Teams AS Teams_1
INNER JOIN (Teams
INNER JOIN (Tourney_Matches LEFT JOIN Match_Games
ON Tourney_Matches.MatchID=Match_Games.MatchID)
ON Teams.TeamID=Tourney_Matches.OddLaneTeamID)
ON Teams_1.TeamID=Tourney_Matches.EvenLaneTeamID
WHERE Match_Games.MatchID Is Null;



CREATE VIEW CH09_Tourney_Not_Yet_Played
AS 
SELECT Tournaments.TourneyID, Tournaments.TourneyDate, Tournaments.TourneyLocation
FROM Tournaments LEFT JOIN Tourney_Matches
ON Tournaments.TourneyID=Tourney_Matches.TourneyID
WHERE Tourney_Matches.MatchID Is Null;



CREATE VIEW CH10_Bowling_Schedule
AS 
SELECT Tournaments.TourneyLocation, Tournaments.TourneyDate, Tourney_Matches.MatchID, Teams.TeamName, Bowlers.BowlerLastName || ', ' ||  Bowlers.BowlerFirstName As Captain, 'Odd Lane' As Lane
FROM ((Tournaments
INNER JOIN Tourney_Matches
ON Tournaments.TourneyID = Tourney_Matches.TourneyID)
INNER JOIN Teams
ON Teams.TeamID = Tourney_Matches.OddLaneTeamID)
INNER JOIN Bowlers
ON Bowlers.BowlerID = Teams.CaptainID
UNION ALL SELECT Tournaments.TourneyLocation, Tournaments.TourneyDate, Tourney_Matches.MatchID, Teams.TeamName, Bowlers.BowlerLastName || ', ' ||  Bowlers.BowlerFirstName As Captain, 'Even Lane' As Lane
FROM ((Tournaments
INNER JOIN Tourney_Matches
ON Tournaments.TourneyID = Tourney_Matches.TourneyID)
INNER JOIN Teams
ON Teams.TeamID = Tourney_Matches.EvenLaneTeamID)
INNER JOIN Bowlers
ON Bowlers.BowlerID = Teams.CaptainID
ORDER BY 2, 3;



CREATE VIEW CH10_Good_Bowlers_TBird_Bolero_UNION
AS 
SELECT Tournaments.TourneyLocation, Bowlers.BowlerLastName, Bowlers.BowlerFirstName, Bowler_Scores.RawScore
FROM Bowlers
INNER JOIN ((Tournaments
INNER JOIN Tourney_Matches
ON Tournaments.TourneyID = Tourney_Matches.TourneyID)
INNER JOIN Bowler_Scores
ON Tourney_Matches.MatchID = Bowler_Scores.MatchID)
ON Bowlers.BowlerID = Bowler_Scores.BowlerID
WHERE Tournaments.TourneyLocation = 'Thunderbird Lanes'
AND Bowler_Scores.RawScore > 165
UNION SELECT Tournaments.TourneyLocation, Bowlers.BowlerLastName, Bowlers.BowlerFirstName, Bowler_Scores.RawScore
FROM Bowlers
INNER JOIN ((Tournaments
INNER JOIN Tourney_Matches
ON Tournaments.TourneyID = Tourney_Matches.TourneyID)
INNER JOIN Bowler_Scores
ON Tourney_Matches.MatchID = Bowler_Scores.MatchID)
ON Bowlers.BowlerID = Bowler_Scores.BowlerID
WHERE Tournaments.TourneyLocation = 'Bolero Lanes'
AND Bowler_Scores.RawScore > 150;



CREATE VIEW CH10_Good_Bowlers_TBird_Bolero_WHERE
AS 
SELECT Tournaments.TourneyLocation, Bowlers.BowlerLastName, Bowlers.BowlerFirstName, Bowler_Scores.RawScore
FROM Tournaments
INNER JOIN (Bowlers
INNER JOIN (Tourney_Matches
INNER JOIN Bowler_Scores
ON Tourney_Matches.MatchID=Bowler_Scores.MatchID)
ON Bowlers.BowlerID=Bowler_Scores.BowlerID)
ON Tournaments.TourneyID=Tourney_Matches.TourneyID
WHERE (Tournaments.TourneyLocation='Thunderbird Lanes'
AND Bowler_Scores.RawScore>165)
OR (Tournaments.TourneyLocation='Bolero Lanes'
AND Bowler_Scores.RawScore>150);



CREATE VIEW CH11_Bowler_High_Score
AS 
SELECT Bowlers.BowlerFirstName, Bowlers.BowlerLastName, (SELECT MAX(RawScore) FROM Bowler_Scores WHERE Bowler_Scores.BowlerID = Bowlers.BowlerID) AS HighScore
FROM Bowlers;



CREATE VIEW CH11_Bowlers_And_Count_Games
AS 
SELECT Bowlers.BowlerFirstName, Bowlers.BowlerLastName, (SELECT COUNT(*) FROM Bowler_Scores WHERE Bowler_Scores.BowlerID = Bowlers.BowlerID) AS Games
FROM Bowlers;



CREATE VIEW CH11_Bowlers_Low_Score
AS 
SELECT DISTINCT Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName, Bowler_Scores.RawScore
FROM Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID
WHERE Bowler_Scores.RawScore <All  (SELECT BS2.RawScore FROM Bowlers AS B2   
INNER JOIN Bowler_Scores AS BS2    
ON B2.BowlerID = BS2.BowlerID   WHERE B2.BowlerID <> Bowlers.BowlerID     
AND B2.TeamID = Bowlers.TeamID);



CREATE VIEW CH11_Team_Captains_High_Score
AS 
SELECT Teams.TeamName, Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName, Bowler_Scores.HandiCapScore
FROM (Bowlers
INNER JOIN Teams
ON Bowlers.BowlerID=Teams.CaptainID)
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID
WHERE Bowler_Scores.HandiCapScore > All    (SELECT BS2.HandiCapScore     FROM Bowlers AS B2    
INNER JOIN Bowler_Scores AS BS2      
ON B2.BowlerID = BS2.BowlerID     WHERE B2.BowlerID <> Bowlers.BowlerID      
AND B2.TeamID = Bowlers.TeamID);



CREATE VIEW CH12_Better_Than_Overall_Average
AS 
SELECT Bowlers.BowlerLastName, Bowlers.BowlerFirstName
FROM Bowlers
WHERE (SELECT AVG(RawScore) FROM Bowler_Scores AS BS WHERE BS.BowlerID = Bowlers.BowlerID)>=(SELECT AVG(RawScore) FROM Bowler_Scores)
ORDER BY Bowlers.BowlerLastName, Bowlers.BowlerFirstName;



CREATE VIEW CH12_Current_Highest_Handicap
AS 
SELECT Max(ROUND((200 - ROUND((SELECT     AVG(RawScore)
                                                      FROM         Bowler_Scores
                                                      WHERE     Bowler_Scores.BowlerID = Bowlers.BowlerID)
                      , 0)) * 0.9, 0)) AS HighHandicap
FROM Bowlers;



CREATE VIEW CH12_Last_Tourney_Date
AS 
SELECT Max(TourneyDate) AS MostRecentDate
FROM Tournaments;



CREATE VIEW CH12_Number_Of_Tournaments_At_Red_Rooster_Lanes
AS 
SELECT Count(TourneyLocation) AS NumberOfTournaments
FROM Tournaments
WHERE TourneyLocation='Red Rooster Lanes';



CREATE VIEW CH12_Tourney_Locations_For_Earliest_Date
AS 
SELECT TourneyLocation
FROM Tournaments
WHERE TourneyDate = (SELECT MIN(TourneyDate) FROM Tournaments);



CREATE VIEW CH13_Bowler_Average_Handicap
AS 
SELECT Bowler_Scores.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName, Sum(Bowler_Scores.RawScore) AS TotalPins, Count(Bowler_Scores.RawScore) AS GamesBowled, Round(Avg((RawScore)),0) AS CurAvg, Round(0.9*(200-Round(Avg((RawScore)),0)),0) AS CurHcp
FROM Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID
GROUP BY Bowler_Scores.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName;



CREATE VIEW CH13_Bowler_Averages
AS 
SELECT BowlerLastName+', '+BowlerFirstName AS BowlerFullName, Avg(Bowler_Scores.RawScore) AS AvgOfRawScore
FROM Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID
GROUP BY Bowlers.BowlerLastName, Bowlers.BowlerFirstName;



CREATE VIEW CH13_Bowler_High_Score_Group
AS 
SELECT Bowlers.BowlerFirstName, Bowlers.BowlerLastName, Max(Bowler_Scores.RawScore) AS HighScore
FROM Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID
GROUP BY Bowlers.BowlerFirstName, Bowlers.BowlerLastName;



CREATE VIEW CH13_Bowler_High_Score_Subquery
AS 
SELECT Bowlers.BowlerFirstName, Bowlers.BowlerLastName, (SELECT MAX(RawScore) FROM Bowler_Scores WHERE Bowler_Scores.BowlerID = Bowlers.BowlerID) AS HighScore
FROM Bowlers;



CREATE VIEW CH13_Tournament_Match_Team_Results
AS 
SELECT Tournaments.TourneyID, Tournaments.TourneyLocation, Tourney_Matches.MatchID, Teams.TeamName, Sum(Bowler_Scores.HandiCapScore) AS TotHandiCapScore
FROM ((((Tournaments
INNER JOIN Tourney_Matches
ON Tournaments.TourneyID=Tourney_Matches.TourneyID)
INNER JOIN Match_Games
ON Tourney_Matches.MatchID=Match_Games.MatchID)
INNER JOIN Bowler_Scores
ON (Match_Games.GameNumber=Bowler_Scores.GameNumber)
AND (Match_Games.MatchID=Bowler_Scores.MatchID))
INNER JOIN Bowlers
ON Bowlers.BowlerID=Bowler_Scores.BowlerID)
INNER JOIN Teams
ON Teams.TeamID=Bowlers.TeamID
GROUP BY Tournaments.TourneyID, Tournaments.TourneyLocation, Tourney_Matches.MatchID, Teams.TeamName;



CREATE VIEW CH14_Better_Than_Overall_Average_HAVING
AS 
SELECT Bowlers.BowlerLastName, Bowlers.BowlerFirstName
FROM Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID
GROUP BY Bowlers.BowlerLastName, Bowlers.BowlerFirstName
HAVING Avg(Bowler_Scores.RawScore) >= (SELECT AVG(RawScore) FROM Bowler_Scores);



CREATE VIEW CH14_Bowlers_Big_High_Score
AS 
SELECT Bowlers.BowlerFirstName, Bowlers.BowlerLastName, Round(Avg(Bowler_Scores.RawScore),0) AS CurrentAverage, Max(Bowler_Scores.RawScore) AS HighGame
FROM Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID
GROUP BY Bowlers.BowlerFirstName, Bowlers.BowlerLastName
HAVING Max(Bowler_Scores.RawScore)>(Round(Avg(Bowler_Scores.RawScore),0)+20);



CREATE VIEW CH14_Captains_Who_Are_Hotshots
AS 
SELECT Teams.TeamID, Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName, Max(Bowler_Scores.RawScore) AS MaxOfRawScore
FROM (Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID)
INNER JOIN Teams
ON Bowlers.BowlerID=Teams.CaptainID
GROUP BY Teams.TeamID, Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName
HAVING Max(Bowler_Scores.RawScore) > (SELECT MAX(RawScore) FROM (Teams AS T2
INNER JOIN Bowlers AS B2
ON T2.TeamID = B2.TeamID)
INNER JOIN Bowler_Scores
ON B2.BowlerID = Bowler_Scores.BowlerID WHERE T2.TeamID = Teams.TeamID
AND B2.BowlerID <> Bowlers.BowlerID);



CREATE VIEW CH14_Good_Bowlers
AS 
SELECT Bowlers.BowlerFirstName, Bowlers.BowlerLastName, Avg(Bowler_Scores.RawScore) AS AvgScore
FROM Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID
GROUP BY Bowlers.BowlerFirstName, Bowlers.BowlerLastName
HAVING Avg(Bowler_Scores.RawScore)>155;



CREATE VIEW CH18_Bowlers_LTE_165_Thunderbird_Bolero
AS 
SELECT Bowlers.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName
FROM Bowlers
WHERE Bowlers.BowlerID NOT IN 
(SELECT Bowler_Scores.BowlerID 
FROM (Tournaments
INNER JOIN Tourney_Matches 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID) 
INNER JOIN Bowler_Scores  
ON Tourney_Matches.MatchID = Bowler_Scores.MatchID
WHERE (Bowler_Scores.RawScore > 165)
AND (Tournaments.TourneyLocation IN ('Thunderbird Lanes', 'Bolero Lanes')));



CREATE VIEW CH18_Bowlers_Won_LowScore_TBird_Totem_Bolero_RIGHT
AS 
SELECT Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName, Bowler_Scores.MatchID, Bowler_Scores.GameNumber, Bowler_Scores.HandiCapScore, Tournaments.TourneyDate, Tournaments.TourneyLocation
FROM ((Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID)
INNER JOIN Tourney_Matches
ON Bowler_Scores.MatchID=Tourney_Matches.MatchID)
INNER JOIN Tournaments
ON Tournaments.TourneyID=Tourney_Matches.TourneyID
WHERE (Bowler_Scores.HandiCapScore <= 190)
AND (Bowler_Scores.WonGame = -1)
AND (Tournaments.TourneyLocation IN ('Thunderbird Lanes', 'Totem Lanes', 'Bolero Lanes')) 
AND (Bowlers.BowlerID IN  (SELECT Bowler_Scores.BowlerID  FROM (Tournaments
INNER JOIN Tourney_Matches 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID) 
INNER JOIN Bowler_Scores 
ON Tourney_Matches.MatchID = Bowler_Scores.MatchID WHERE Bowler_Scores.WonGame = -1 
AND Bowler_Scores.HandiCapScore <=190 
AND Tournaments.TourneyLocation = 'Thunderbird Lanes'))
AND (Bowlers.BowlerID IN  (SELECT Bowler_Scores.BowlerID  FROM (Tournaments
INNER JOIN Tourney_Matches 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID) 
INNER JOIN Bowler_Scores 
ON Tourney_Matches.MatchID = Bowler_Scores.MatchID WHERE Bowler_Scores.WonGame = -1 
AND Bowler_Scores.HandiCapScore <=190 
AND Tournaments.TourneyLocation = 'Totem Lanes'))
AND (Bowlers.BowlerID IN (SELECT Bowler_Scores.BowlerID  FROM (Tournaments
INNER JOIN Tourney_Matches 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID) 
INNER JOIN Bowler_Scores 
ON Tourney_Matches.MatchID = Bowler_Scores.MatchID WHERE Bowler_Scores.WonGame = -1 
AND Bowler_Scores.HandiCapScore <=190 
AND Tournaments.TourneyLocation = 'Bolero Lanes'));



CREATE VIEW CH18_Bowlers_Won_LowScore_TBird_Totem_Bolero_WRONG
AS 
SELECT Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName, Bowler_Scores.MatchID, Bowler_Scores.GameNumber, Bowler_Scores.HandiCapScore, Tournaments.TourneyDate, Tournaments.TourneyLocation
FROM ((Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID)
INNER JOIN Tourney_Matches
ON Bowler_Scores.MatchID=Tourney_Matches.MatchID)
INNER JOIN Tournaments
ON Tournaments.TourneyID=Tourney_Matches.TourneyID
WHERE (Bowler_Scores.HandiCapScore<=190) And (Bowler_Scores.WonGame=-1) And (Tournaments.TourneyLocation In ('Thunderbird Lanes','Totem Lanes','Bolero Lanes'));



CREATE VIEW CH18_Good_Bowlers_TBird_And_Bolero_EXISTS
AS 
SELECT Bowlers.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName
FROM Bowlers
WHERE EXISTS  
(SELECT *  
FROM (Tournaments
INNER JOIN Tourney_Matches 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID) 
INNER JOIN Bowler_Scores  
ON Tourney_Matches.MatchID = Bowler_Scores.MatchID
WHERE (Bowler_Scores.BowlerID = Bowlers.BowlerID) 
AND (Bowler_Scores.RawScore >= 170)
AND (Tournaments.TourneyLocation = 'Thunderbird Lanes'))
AND EXISTS  
(SELECT *  
FROM (Tournaments
INNER JOIN Tourney_Matches 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID) 
INNER JOIN Bowler_Scores  
ON Tourney_Matches.MatchID = Bowler_Scores.MatchID
WHERE (Bowler_Scores.BowlerID = Bowlers.BowlerID) 
AND (Bowler_Scores.RawScore >= 170)
AND (Tournaments.TourneyLocation = 'Bolero Lanes'));



CREATE VIEW CH18_Mediocre_Bowlers
AS 
SELECT Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName
FROM Bowlers
WHERE NOT EXISTS 
(SELECT * FROM Bowler_Scores 
WHERE Bowler_Scores.RawScore > 150 
AND Bowler_Scores.BowlerID = Bowlers.BowlerID);



CREATE VIEW CH18_Tourney_Not_Yet_Played_NOT_IN
AS 
SELECT Tournaments.TourneyID, Tournaments.TourneyDate, Tournaments.TourneyLocation
FROM Tournaments
WHERE Tournaments.TourneyID NOT IN 
(SELECT Tourney_Matches.TourneyID 
FROM Tourney_Matches);



CREATE VIEW CH19_All_Tournaments_Any_Matches
AS 
SELECT Tournaments.TourneyID, Tournaments.TourneyDate, Tournaments.TourneyLocation, (IIf(IsNull(MatchInfo.MatchID),'Not Played Yet','Match: ' || CStr(MatchInfo.MatchID) || '  Lanes: ' || MatchInfo.Lanes || '  Odd Lane Team: ' || MatchInfo.OddLane || '  Even Lane Team: ' || MatchInfo.EvenLane)) AS (Match)
FROM (SELECT Tourney_Matches.TourneyID, Tourney_Matches.MatchID, Tourney_Matches.Lanes, Teams.TeamName AS OddLane, Teams_1.TeamName AS EvenLane FROM (Tourney_Matches
INNER JOIN Teams
ON Tourney_Matches.OddLaneTeamID=Teams.TeamID)
INNER JOIN Teams AS Teams_1
ON Tourney_Matches.EvenLaneTeamID=Teams_1.TeamID)  AS MatchInfo RIGHT JOIN Tournaments
ON MatchInfo.TourneyID=Tournaments.TourneyID;



CREATE VIEW CH19_All_Tourney_Matches
AS 
SELECT Tournaments.TourneyDate, Tournaments.TourneyLocation, Tourney_Matches.Lanes, Tourney_Matches.MatchID, Teams.TeamName AS OddLaneTeam, Teams_1.TeamName AS EvenLaneTeam, GameResults.GameNumber, (IIf(IsNull(GameResults.TeamName),'Match not played',GameResults.TeamName)) AS Winner
FROM (((Tournaments
INNER JOIN Tourney_Matches
ON Tournaments.TourneyID=Tourney_Matches.TourneyID)
INNER JOIN Teams
ON Tourney_Matches.OddLaneTeamID=Teams.TeamID)
INNER JOIN Teams AS Teams_1
ON Tourney_Matches.EvenLaneTeamID=Teams_1.TeamID) LEFT JOIN (SELECT Match_Games.MatchID, Match_Games.GameNumber, Teams_2.TeamName FROM Match_Games
INNER JOIN Teams AS Teams_2
ON Match_Games.WinningTeamID=Teams_2.TeamID)  AS GameResults
ON Tourney_Matches.MatchID=GameResults.MatchID
ORDER BY Tournaments.TourneyDate, Tourney_Matches.MatchID, GameResults.GameNumber;



CREATE VIEW CH19_Bowler_Averages_Avoid_0_Games
AS 
SELECT Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName, COUNT(Bowler_Scores.MatchID) AS GamesBowled, SUM(Bowler_Scores.RawScore) AS TotalPins, IIf(DCount('MatchID','Bowler_Scores','BowlerID = ' || Bowlers.BowlerID)=0,0,Int(DSum('RawScore','Bowler_Scores','BowlerID = ' || Bowlers.BowlerID)/DCount('MatchID','Bowler_Scores','BowlerID = ' || Bowlers.BowlerID))) AS BowlerAverage
FROM Bowlers LEFT JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID
GROUP BY Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName;



CREATE VIEW CH19_Bowler_Ratings
AS 
SELECT Bowlers.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName, Int(AVG(Bowler_Scores.RawScore)) AS BowlerAverage, (IIf(Int(AVG(Bowler_Scores.RawScore))<140,'Fair',IIf(Int(AVG(Bowler_Scores.RawScore))<160,'Average',IIf(Int(AVG(Bowler_Scores.RawScore))<185,'Good','Excellent')))) AS BowlerRating
FROM Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID
GROUP BY Bowlers.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName;



CREATE VIEW CH20_Bowler_Mailing_Skip_3
AS 
SELECT ' ' As BowlerLastName, ' ' As BowlerFirstName, ' ' As BowlerAddress, ' ' As BowlerCity, ' ' As BowlerState, ' ' As BowlerZip
FROM ztblSkipLabels
WHERE ztblSkipLabels.LabelCount <= 3
UNION ALL SELECT BowlerLastName, BowlerFirstName, BowlerAddress, BowlerCity, BowlerState, BowlerZip
FROM Bowlers
ORDER BY BowlerZip, BowlerLastName;



CREATE VIEW CH20_Bowler_Ratings
AS 
SELECT BScores.BowlerID, BScores.BowlerLastName, BScores.BowlerFirstName, BScores.BowlerAverage, ztblBowlerRatings.BowlerRating
FROM ztblBowlerRatings, (SELECT Bowlers.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName, Int(AVG(Bowler_Scores.RawScore)) AS BowlerAverage FROM Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID GROUP BY Bowlers.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName)  AS BScores
WHERE BScores.BowlerAverage BETWEEN ztblBowlerRatings.BowlerLowAvg
AND ztblBowlerRatings.BowlerHighAvg
ORDER BY BowlerID;



CREATE VIEW CH20_Team_Pairings
AS 
SELECT Teams.TeamID AS Team1ID, Teams.TeamName AS Team1Name, Teams_1.TeamID AS Team2ID, Teams_1.TeamName AS Team2Name
FROM Teams, Teams AS Teams_1
WHERE Teams_1.TeamID>Teams.TeamID
ORDER BY Teams.TeamID, Teams_1.TeamID;



CREATE VIEW CH20_Tournament_Week_Schedule_2017
AS 
SELECT ztblWeeks.WeekStart, (SELECT Tournaments.TourneyLocation FROM Tournaments WHERE Tournaments.TourneyDate BETWEEN ztblWeeks.WeekStart
AND ztblWeeks.WeekEnd) AS BowlingAlley
FROM ztblWeeks
WHERE ztblWeeks.WeekStart<='12/31/2017' And ztblWeeks.WeekEnd>='9/1/2017';



