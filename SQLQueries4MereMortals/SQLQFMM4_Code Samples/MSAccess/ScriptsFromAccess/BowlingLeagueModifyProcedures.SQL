CREATE PROCEDURE CH15_Calc_Bowler_Pins_Avg_Hcp
AS 
UPDATE Bowlers SET Bowlers.BowlerTotalPins = DSum('RawScore','Bowler_Scores ','Bowler_Scores.BowlerID = ' & Bowlers.BowlerID), Bowlers.BowlerGamesBowled = DCount('RawScore','Bowler_Scores','Bowler_Scores.BowlerID = ' & Bowlers.BowlerID), Bowlers.BowlerCurrentAverage = NZ(Round(DAvg('Bowler_Scores.RawScore','Bowler_Scores','Bowler_Scores.BowlerID = ' & Bowlers.BowlerID),0),0), Bowlers.BowlerCurrentHcp = NZ(Round(0.9*(200-Round(DAvg('Bowler_Scores.RawScore','Bowler_Scores','Bowler_Scores.BowlerID = ' & Bowlers.BowlerID),0)),0),0);



CREATE VIEW CH15_Calc_Bowler_Pins_Avg_Hcp_Query
AS 
SELECT Bowlers.BowlerID, Bowlers.BowlerTotalPins, DSum('RawScore','Bowler_Scores ','Bowler_Scores.BowlerID = ' & Bowlers.BowlerID) AS NewBowlerTotalPins, Bowlers.BowlerGamesBowled, DCount('RawScore','Bowler_Scores','Bowler_Scores.BowlerID = ' & Bowlers.BowlerID) AS NewBowlerGamesBowled, Bowlers.BowlerCurrentAverage, Nz(Round(DAvg('Bowler_Scores.RawScore','Bowler_Scores','Bowler_Scores.BowlerID = ' & Bowlers.BowlerID),0),0) AS NewBowlerCurrentAverage, Bowlers.BowlerCurrentHcp, Nz(Round(0.9*(200-Round(DAvg('Bowler_Scores.RawScore','Bowler_Scores','Bowler_Scores.BowlerID = ' & Bowlers.BowlerID),0)),0),0) AS NewBowlerCurrentHcp
FROM Bowlers;



CREATE PROCEDURE CH15_Change_Huckleberry_Name
AS 
UPDATE Teams SET Teams.TeamName = 'Manta Rays'
WHERE Teams.TeamName = 'Huckleberrys';



CREATE VIEW CH15_Change_Huckleberry_Name_Query
AS 
SELECT Teams.TeamName, 'Manta Rays' AS NewTeamName
FROM Teams
WHERE (((Teams.TeamName)='Huckleberrys'));



CREATE PROCEDURE CH15_Change_Tourney_Location
AS 
UPDATE Tournaments SET Tournaments.TourneyLocation = 'Oasis Lanes'
WHERE Tournaments.TourneyLocation = 'Sports World Lanes';



CREATE VIEW CH15_Change_Tourney_Location_Query
AS 
SELECT Tournaments.TourneyID, Tournaments.TourneyLocation, 'Oasis Lanes' AS NewTourneyLocation
FROM Tournaments
WHERE (((Tournaments.TourneyLocation)='Sports World Lanes'));



CREATE PROCEDURE CH15_Update_Bowler_City_State
AS 
UPDATE Bowlers SET BowlerCity = DLookup('City', 'WAZips', 'ZIP = '' & (BowlerZip) & '''), BowlerState = DLookup('State', 'WAZips', 'ZIP = '' & (BowlerZip) & ''')
WHERE (BowlerCity <>
(SELECT     City
  FROM          WAZips
   WHERE      Bowlers.BowlerZip = WAZips.ZIP)) OR
    (BowlerState <>
                (SELECT     State
                  FROM          WAZips
                  WHERE      Bowlers.BowlerZip = WAZips.ZIP));



CREATE VIEW CH15_Update_Bowler_City_State_Query
AS 
SELECT Bowlers.BowlerCity, (SELECT     City
  FROM          WAZips
  WHERE      Bowlers.BowlerZip = WAZips.ZIP) AS NewBowlerCity, Bowlers.BowlerState, (SELECT     State
               FROM          WAZips
                WHERE      Bowlers.BowlerZip = WAZips.ZIP) AS NewBowlerState
FROM Bowlers
WHERE (((Bowlers.(BowlerCity))<>(SELECT     City
  FROM          WAZips
   WHERE      Bowlers.BowlerZip = WAZips.ZIP)))
OR (((Bowlers.(BowlerState))<>(SELECT     State
                  FROM          WAZips
                  WHERE      Bowlers.BowlerZip = WAZips.ZIP)));



CREATE PROCEDURE CH16_Add_Bowler
AS 
INSERT INTO Bowlers ( BowlerLastName, BowlerFirstName, BowlerAddress, BowlerCity, BowlerState, BowlerZip, BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, BowlerCurrentAverage, BowlerCurrentHcp )
SELECT Bowlers.BowlerLastName, 'Matthew' AS BowlerFirstName, Bowlers.BowlerAddress, Bowlers.BowlerCity, Bowlers.BowlerState, Bowlers.BowlerZip, Bowlers.BowlerPhoneNumber, Bowlers.TeamID, 0, 0, 0, 0
FROM Bowlers
WHERE (Bowlers.BowlerLastName='Patterson')
AND (Bowlers.BowlerFirstName='Neil');



CREATE VIEW CH16_Add_Bowler_Query
AS 
SELECT Bowlers.BowlerLastName, 'Matthew' AS BowlerFirstName, Bowlers.BowlerAddress, Bowlers.BowlerCity, Bowlers.BowlerState, Bowlers.BowlerZip, Bowlers.BowlerPhoneNumber, Bowlers.TeamID, 0 AS Expr1, 0 AS Expr2, 0 AS Expr3, 0 AS Expr4
FROM Bowlers
WHERE (((Bowlers.BowlerLastName)='Patterson')
AND ((Bowlers.BowlerFirstName)='Neil'));



CREATE PROCEDURE CH16_Add_Team
AS 
INSERT INTO Teams ( TeamName, CaptainID )
VALUES ('Aardvarks', Null);



CREATE VIEW CH16_Add_Team_Query
AS 
SELECT 'Aardvarks' AS TeamName, Null AS CaptainID;



CREATE PROCEDURE CH16_Archive_2017_Tournaments_1
AS 
INSERT INTO Tournaments_Archive
SELECT Tournaments.TourneyID AS TourneyID, Tournaments.TourneyDate AS TourneyDate, Tournaments.TourneyLocation AS TourneyLocation
FROM Tournaments
WHERE (Tournaments.TourneyDate Between '1/1/2017'
AND '12/31/2017');



CREATE VIEW CH16_Archive_2017_Tournaments_1_Query
AS 
SELECT Tournaments.TourneyID AS TourneyID, Tournaments.TourneyDate AS TourneyDate, Tournaments.TourneyLocation AS TourneyLocation
FROM Tournaments
WHERE (((Tournaments.TourneyDate) Between '1/1/2017'
AND '12/31/2017'));



CREATE PROCEDURE CH16_Archive_2017_Tournaments_2
AS 
INSERT INTO Tourney_Matches_Archive
SELECT Tourney_Matches.MatchID AS MatchID, Tourney_Matches.TourneyID AS TourneyID, Tourney_Matches.Lanes AS Lanes, Tourney_Matches.OddLaneTeamID AS OddLaneTeamID, Tourney_Matches.EvenLaneTeamID AS EvenLaneTeamID
FROM Tourney_Matches
WHERE (Tourney_Matches.TourneyID In (SELECT TourneyID FROM Tournaments WHERE TourneyDate BETWEEN '1/1/2017'
AND '12/31/2017'));



CREATE VIEW CH16_Archive_2017_Tournaments_2_Query
AS 
SELECT Tourney_Matches.MatchID AS MatchID, Tourney_Matches.TourneyID AS TourneyID, Tourney_Matches.Lanes AS Lanes, Tourney_Matches.OddLaneTeamID AS OddLaneTeamID, Tourney_Matches.EvenLaneTeamID AS EvenLaneTeamID
FROM Tourney_Matches
WHERE (((Tourney_Matches.TourneyID) In (SELECT TourneyID FROM Tournaments WHERE TourneyDate BETWEEN '1/1/2017'
AND '12/31/2017')));



CREATE PROCEDURE CH16_Archive_2017_Tournaments_3
AS 
INSERT INTO Match_Games_Archive
SELECT Match_Games.MatchID AS MatchID, Match_Games.GameNumber AS GameNumber, Match_Games.WinningTeamID AS WinningTeamID
FROM Match_Games
WHERE Match_Games.MatchID IN
(SELECT Tourney_Matches.MatchID
FROM Tourney_Matches 
INNER JOIN Tournaments 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID
WHERE Tournaments.TourneyDate BETWEEN '1/1/2017'
AND '12/31/2017');



CREATE VIEW CH16_Archive_2017_Tournaments_3_Query
AS 
SELECT Match_Games.MatchID AS MatchID, Match_Games.GameNumber AS GameNumber, Match_Games.WinningTeamID AS WinningTeamID
FROM Match_Games
WHERE (((Match_Games.MatchID) In (SELECT Tourney_Matches.MatchID
FROM Tourney_Matches 
INNER JOIN Tournaments 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID
WHERE Tournaments.TourneyDate BETWEEN '1/1/2017'
AND '12/31/2017')));



CREATE PROCEDURE CH16_Archive_2017_Tournaments_4
AS 
INSERT INTO Bowler_Scores_Archive
SELECT Bowler_Scores.MatchID AS MatchID, Bowler_Scores.GameNumber AS GameNumber, Bowler_Scores.BowlerID AS BowlerID, Bowler_Scores.RawScore AS RawScore, Bowler_Scores.HandiCapScore AS HandiCapScore, Bowler_Scores.WonGame AS WonGame
FROM Bowler_Scores
WHERE Bowler_Scores.MatchID In (SELECT Tourney_Matches.MatchID
FROM Tourney_Matches 
INNER JOIN Tournaments 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID
WHERE Tournaments.TourneyDate BETWEEN '1/1/2017'
AND '12/31/2017');



CREATE VIEW CH16_Archive_2017_Tournaments_4_Query
AS 
SELECT Bowler_Scores.MatchID AS MatchID, Bowler_Scores.GameNumber AS GameNumber, Bowler_Scores.BowlerID AS BowlerID, Bowler_Scores.RawScore AS RawScore, Bowler_Scores.HandiCapScore AS HandiCapScore, Bowler_Scores.WonGame AS WonGame
FROM Bowler_Scores
WHERE (((Bowler_Scores.MatchID) In (SELECT Tourney_Matches.MatchID
FROM Tourney_Matches 
INNER JOIN Tournaments 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID
WHERE Tournaments.TourneyDate BETWEEN '1/1/2017'
AND '12/31/2017')));



CREATE PROCEDURE CH16_Copy_2017_Tournaments_1
AS 
INSERT INTO Tournaments ( TourneyID, TourneyDate, TourneyLocation )
SELECT Tournaments.TourneyID+25 AS TourneyID, Tournaments.TourneyDate+728 AS TourneyDate, Tournaments.TourneyLocation
FROM Tournaments
WHERE Tournaments.(TourneyDate) Between '1/1/2017'
AND '12/31/2017';



CREATE VIEW CH16_Copy_2017_Tournaments_1_Query
AS 
SELECT Tournaments.TourneyID+25 AS TourneyID, Tournaments.TourneyDate+728 AS TourneyDate, Tournaments.TourneyLocation
FROM Tournaments
WHERE (((Tournaments.TourneyDate) Between '1/1/2017'
AND '12/31/2017'));



CREATE PROCEDURE CH16_Copy_2017_Tournaments_2
AS 
INSERT INTO Tourney_Matches ( TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID )
SELECT Tourney_Matches.TourneyID+25 AS TourneyID, Tourney_Matches.Lanes, Tourney_Matches.OddLaneTeamID, Tourney_Matches.EvenLaneTeamID
FROM Tourney_Matches
WHERE Tourney_Matches.TourneyID IN
(Select TourneyID FROM Tournaments WHERE Tournaments.(TourneyDate) Between '1/1/2017'
AND '12/31/2017');



CREATE VIEW CH16_Copy_2017_Tournaments_2_Query
AS 
SELECT Tourney_Matches.TourneyID+25 AS TourneyID, Tourney_Matches.Lanes, Tourney_Matches.OddLaneTeamID, Tourney_Matches.EvenLaneTeamID
FROM Tourney_Matches
WHERE Tourney_Matches.TourneyID IN
(Select TourneyID FROM Tournaments WHERE Tournaments.(TourneyDate) Between '1/1/2017'
AND '12/31/2017');



CREATE PROCEDURE CH17_Delete_Archived_2017_Tournaments_1
AS 
DELETE Bowler_Scores.*
FROM Bowler_Scores
WHERE Bowler_Scores.MatchID In (SELECT Tourney_Matches_Archive.MatchID
FROM Tourney_Matches_Archive);



CREATE VIEW CH17_Delete_Archived_2017_Tournaments_1_Query
AS 
SELECT Bowler_Scores.*
FROM Bowler_Scores
WHERE (((Bowler_Scores.MatchID) In (SELECT Tourney_Matches_Archive.MatchID
FROM Tourney_Matches_Archive)));



CREATE PROCEDURE CH17_Delete_Archived_2017_Tournaments_1_WRONG
AS 
DELETE Bowler_Scores.*
FROM Bowler_Scores
WHERE Bowler_Scores.MatchID In (SELECT Tourney_Matches.MatchID
FROM Tourney_Matches 
INNER JOIN Tournaments 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID
WHERE Tournaments.TourneyDate BETWEEN '1/1/2017'
AND '12/31/2017');



CREATE VIEW CH17_Delete_Archived_2017_Tournaments_1_WRONG_Query
AS 
SELECT Bowler_Scores.*
FROM Bowler_Scores
WHERE (((Bowler_Scores.MatchID) In (SELECT Tourney_Matches.MatchID
FROM Tourney_Matches 
INNER JOIN Tournaments 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID
WHERE Tournaments.TourneyDate BETWEEN '1/1/2017'
AND '12/31/2017')));



CREATE PROCEDURE CH17_Delete_Archived_2017_Tournaments_2
AS 
DELETE Match_Games.*
FROM Match_Games
WHERE Match_Games.MatchID IN
(SELECT Tourney_Matches_Archive.MatchID
FROM Tourney_Matches_Archive);



CREATE VIEW CH17_Delete_Archived_2017_Tournaments_2_Query
AS 
SELECT Match_Games.*
FROM Match_Games
WHERE (((Match_Games.MatchID) In (SELECT Tourney_Matches_Archive.MatchID
FROM Tourney_Matches_Archive)));



CREATE PROCEDURE CH17_Delete_Archived_2017_Tournaments_3
AS 
DELETE Tourney_Matches.*
FROM Tourney_Matches
WHERE Tourney_Matches.MatchID In 
(SELECT MatchID FROM Tourney_Matches_Archive);



CREATE VIEW CH17_Delete_Archived_2017_Tournaments_3_Query
AS 
SELECT Tourney_Matches.*
FROM Tourney_Matches
WHERE (((Tourney_Matches.MatchID) In (SELECT MatchID FROM Tourney_Matches_Archive)));



CREATE PROCEDURE CH17_Delete_Archived_2017_Tournaments_4
AS 
DELETE Tournaments.*
FROM Tournaments
WHERE (Tournaments.TourneyID IN
(SELECT Tournaments_Archive.TourneyID
FROM Tournaments_Archive));



CREATE VIEW CH17_Delete_Archived_2017_Tournaments_4_Query
AS 
SELECT Tournaments.*
FROM Tournaments
WHERE (((Tournaments.TourneyID) In (SELECT Tournaments_Archive.TourneyID
FROM Tournaments_Archive)));



CREATE PROCEDURE CH17_Delete_Bowlers_No_Games
AS 
DELETE Bowlers.*
FROM Bowlers
WHERE BowlerGamesBowled=0;



CREATE VIEW CH17_Delete_Bowlers_No_Games_Query
AS 
SELECT Bowlers.*
FROM Bowlers
WHERE (((Bowlers.(BowlerGamesBowled))=0));



CREATE PROCEDURE CH17_Delete_Bowlers_No_Games_Safe
AS 
DELETE Bowlers.*
FROM Bowlers
WHERE Bowlers.BowlerID NOT IN
(SELECT BowlerID FROM Bowler_Scores);



CREATE VIEW CH17_Delete_Bowlers_No_Games_Safe_Query
AS 
SELECT Bowlers.*
FROM Bowlers
WHERE (((Bowlers.BowlerID) Not In (SELECT BowlerID FROM Bowler_Scores)));



CREATE PROCEDURE CH17_Delete_Matches_Not_Played
AS 
DELETE Tourney_Matches.*
FROM Tourney_Matches
WHERE (Tourney_Matches.MatchID Not In (SELECT MatchID FROM Bowler_Scores))
AND (Tourney_Matches.MatchID Not In (SELECT MatchID FROM Match_Games));



CREATE VIEW CH17_Delete_Matches_Not_Played_Query
AS 
SELECT Tourney_Matches.*
FROM Tourney_Matches
WHERE (Tourney_Matches.MatchID Not In (SELECT MatchID FROM Bowler_Scores))
AND (Tourney_Matches.MatchID Not In (SELECT MatchID FROM Match_Games));



