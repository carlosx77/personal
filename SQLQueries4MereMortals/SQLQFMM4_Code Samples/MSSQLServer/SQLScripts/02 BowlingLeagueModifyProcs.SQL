USE BowlingLeagueModify;
GO

CREATE PROCEDURE CH15_Calc_Bowler_Pins_Avg_Hcp
AS 
UPDATE    Bowlers
SET              BowlerTotalPins =
                          (SELECT     SUM(RawScore)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID), BowlerGamesBowled =
                          (SELECT     COUNT(Bowler_Scores.RawScore)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID), BowlerCurrentAverage =
                          IsNull((SELECT     Round(AVG(Bowler_Scores.RawScore), 0)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID), 0), BowlerCurrentHcp =
                          IsNull((SELECT     Round(0.9 * (200 - Round(AVG(Bowler_Scores.RawScore), 0)), 0)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID), 0);
GO

CREATE VIEW CH15_Calc_Bowler_Pins_Avg_Hcp_Query
AS 
SELECT Bowlers.BowlerID, Bowlers.BowlerTotalPins, 
                          (SELECT     SUM(RawScore)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID) 
AS NewBowlerTotalPins, Bowlers.BowlerGamesBowled, 
                          (SELECT     COUNT(Bowler_Scores.RawScore)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID) 
AS NewBowlerGamesBowled, Bowlers.BowlerCurrentAverage, 
                          IsNull((SELECT     Round(AVG(Bowler_Scores.RawScore), 0)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID), 0) 
AS NewBowlerCurrentAverage, Bowlers.BowlerCurrentHcp, 
                          IsNull((SELECT     Round(0.9 * (200 - Round(AVG(Bowler_Scores.RawScore), 0)), 0)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID), 0) 
AS NewBowlerCurrentHcp
FROM Bowlers;
GO

CREATE PROCEDURE CH15_Change_Huckleberry_Name
AS 
UPDATE    Teams
SET              TeamName = 'Manta Rays'
WHERE     (TeamName = 'Huckleberrys');
GO

CREATE VIEW CH15_Change_Huckleberry_Name_Query
AS 
SELECT Teams.TeamName, 'Manta Rays' AS NewTeamName
FROM Teams
WHERE Teams.TeamName = 'Huckleberrys';
GO

CREATE PROCEDURE CH15_Change_Tourney_Location
AS 
UPDATE    Tournaments
SET              TourneyLocation = 'Oasis Lanes'
WHERE     (TourneyLocation = 'Sports World Lanes');
GO

CREATE VIEW CH15_Change_Tourney_Location_Query
AS 
SELECT Tournaments.TourneyID, Tournaments.TourneyLocation, 'Oasis Lanes' AS NewTourneyLocation
FROM Tournaments
WHERE (Tournaments.TourneyLocation = 'Sports World Lanes');
GO

CREATE PROCEDURE CH15_Update_Bowler_City_State
AS 
UPDATE    Bowlers
SET              BowlerCity =
                          (SELECT     City
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP), BowlerState =
                          (SELECT     State
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP)
WHERE     (BowlerCity <>
                          (SELECT     City
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP)) OR
                      (BowlerState <>
                          (SELECT     State
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP));
GO

CREATE VIEW CH15_Update_Bowler_City_State_Query
AS 
SELECT Bowlers.BowlerCity, 
                          (SELECT     City
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP) AS NewBowlerCity, Bowlers.BowlerState, 
                          (SELECT     State
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP) AS NewBowlerState
FROM Bowlers
WHERE     (BowlerCity <>
                          (SELECT     City
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP)) OR
                      (BowlerState <>
                          (SELECT     State
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP));
GO

CREATE PROCEDURE CH16_Add_Bowler
AS 
INSERT INTO Bowlers
                      (BowlerLastName, BowlerFirstName, BowlerAddress, BowlerCity, BowlerState, BowlerZip, BowlerPhoneNumber, TeamID, BowlerTotalPins, 
                      BowlerGamesBowled, BowlerCurrentAverage, BowlerCurrentHcp)
SELECT     BowlerLastName, 'Matthew' AS BowlerFirstName, BowlerAddress, BowlerCity, BowlerState, BowlerZip, BowlerPhoneNumber, TeamID, 0 AS BowlerTotalPins, 0 AS BowlerGamesBowled, 0 AS BolwerCurrentAverage, 0 AS BowlerCurrentHcp
FROM         Bowlers
WHERE     (BowlerLastName = 'Patterson') AND (BowlerFirstName = 'Neil');
GO

CREATE VIEW CH16_Add_Bowler_Query
AS 
SELECT Bowlers.BowlerLastName, 'Matthew' AS BowlerFirstName, Bowlers.BowlerAddress, Bowlers.BowlerCity, Bowlers.BowlerState, Bowlers.BowlerZip, Bowlers.BowlerPhoneNumber, Bowlers.TeamID, 0 AS BowlerTotalPins, 0 AS BowlerGamesBowled, 0 AS BowlerCurrentAverage, 0 AS BowlerCurrentHcp
FROM Bowlers
WHERE (((Bowlers.BowlerLastName)='Patterson') AND ((Bowlers.BowlerFirstName)='Neil'));
GO

CREATE PROCEDURE CH16_Add_Team
AS 
INSERT INTO Teams
                      (TeamName, CaptainID)
VALUES     ('Aardvarks', NULL);
GO

CREATE VIEW CH16_Add_Team_Query
AS
SELECT 'Aardvarks' As TeamName, Null As CaptainID;
GO

CREATE PROCEDURE CH16_Archive_2017_Tournaments_1
AS 
INSERT INTO Tournaments_Archive
SELECT     TourneyID, TourneyDate, TourneyLocation
FROM         Tournaments
WHERE     (TourneyDate BETWEEN '1/1/2017' AND '12/31/2017');
GO

CREATE VIEW CH16_Archive_2017_Tournaments_1_Query
AS 
SELECT     TourneyID, TourneyDate, TourneyLocation
FROM         Tournaments
WHERE     (TourneyDate BETWEEN '1/1/2017' AND '12/31/2017');
GO

CREATE PROCEDURE CH16_Archive_2017_Tournaments_2
AS 
INSERT INTO Tourney_Matches_Archive
SELECT     MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID
FROM         Tourney_Matches
WHERE     (TourneyID IN
                          (SELECT     TourneyID
                            FROM          Tournaments
                            WHERE      TourneyDate BETWEEN '1/1/2017' AND '12/31/2017'));
GO

CREATE VIEW CH16_Archive_2017_Tournaments_2_Query
AS 
SELECT     MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID
FROM         Tourney_Matches
WHERE     (TourneyID IN
                          (SELECT     TourneyID
                            FROM          Tournaments
                            WHERE      TourneyDate BETWEEN '1/1/2017' AND '12/31/2017'));
GO

CREATE PROCEDURE CH16_Archive_2017_Tournaments_3
AS 
INSERT INTO Match_Games_Archive
SELECT     MatchID, GameNumber, NULL AS WinTeam
FROM         Match_Games
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches.MatchID
                            FROM          Tourney_Matches INNER JOIN
                                                   Tournaments ON Tournaments.TourneyID = Tourney_Matches.TourneyID
                            WHERE      Tournaments.TourneyDate BETWEEN '1/1/2017' AND '12/31/2017'));
GO

CREATE VIEW CH16_Archive_2017_Tournaments_3_Query
AS 
SELECT     MatchID, GameNumber, NULL AS WinTeam
FROM         Match_Games
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches.MatchID
                            FROM          Tourney_Matches INNER JOIN
                                                   Tournaments ON Tournaments.TourneyID = Tourney_Matches.TourneyID
                            WHERE      Tournaments.TourneyDate BETWEEN '1/1/2017' AND '12/31/2017'));
GO

CREATE PROCEDURE CH16_Archive_2017_Tournaments_4
AS 
INSERT INTO Bowler_Scores_Archive
SELECT     MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, WonGame
FROM         Bowler_Scores
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches.MatchID
                            FROM          Tourney_Matches INNER JOIN
                                                   Tournaments ON Tournaments.TourneyID = Tourney_Matches.TourneyID
                            WHERE      Tournaments.TourneyDate BETWEEN '1/1/2017' AND '12/31/2017'));
GO

CREATE VIEW CH16_Archive_2017_Tournaments_4_Query
AS 
SELECT     MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, WonGame
FROM         Bowler_Scores
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches.MatchID
                            FROM          Tourney_Matches INNER JOIN
                                                   Tournaments ON Tournaments.TourneyID = Tourney_Matches.TourneyID
                            WHERE      Tournaments.TourneyDate BETWEEN '1/1/2017' AND '12/31/2017'));
GO

CREATE PROCEDURE CH16_Copy_2017_Tournaments_1
AS 
SET IDENTITY_INSERT Tournaments ON
INSERT INTO Tournaments
                      (TourneyID, TourneyDate, TourneyLocation)
SELECT     TourneyID + 25 AS Expr1, DateAdd(d, 728, TourneyDate) AS Expr2, TourneyLocation
FROM         Tournaments
WHERE     (TourneyDate BETWEEN '1/1/2017' AND '12/31/2017');
SET IDENTITY_INSERT Tournaments OFF
GO

CREATE VIEW CH16_Copy_2017_Tournaments_1_Query
AS 
SELECT     TourneyID + 25 AS NewTourneyID, DateAdd(d, 728, TourneyDate) AS NewTourneyDate, TourneyLocation
FROM         Tournaments
WHERE     (TourneyDate BETWEEN '1/1/2017' AND '12/31/2017');
GO

CREATE PROCEDURE CH16_Copy_2017_Tournaments_2
AS 
INSERT INTO Tourney_Matches
                      (TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
SELECT     TourneyID + 25 AS NewTourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID
FROM         Tourney_Matches
WHERE Tourney_Matches.TourneyID IN
(SELECT TourneyID 
 FROM Tournaments
 WHERE Tournaments.TourneyDate Between '1/1/2017' And '12/31/2017');
GO

CREATE VIEW CH16_Copy_2017_Tournaments_2_Query
AS 
SELECT     MatchID, TourneyID + 25 AS NewTourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID
FROM         Tourney_Matches
WHERE Tourney_Matches.TourneyID IN
(SELECT TourneyID 
 FROM Tournaments
 WHERE Tournaments.TourneyDate Between '1/1/2017' And '12/31/2017');
GO

CREATE PROCEDURE CH17_Delete_Archived_2017_Tournaments_1
AS 
DELETE FROM Bowler_Scores
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches_Archive.MatchID
                            FROM          Tourney_Matches_Archive));
GO

CREATE VIEW CH17_Delete_Archived_2017_Tournaments_1_Query
AS 
SELECT * FROM Bowler_Scores
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches_Archive.MatchID
                            FROM          Tourney_Matches_Archive));
GO

CREATE PROCEDURE CH17_Delete_Archived_2017_Tournaments_1_WRONG
AS 
DELETE FROM Bowler_Scores
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches.MatchID
                            FROM          Tourney_Matches INNER JOIN
                                                   Tournaments ON Tournaments.TourneyID = Tourney_Matches.TourneyID
                            WHERE      Tournaments.TourneyDate BETWEEN '1/1/2017' AND '12/31/2017'));
GO

CREATE VIEW CH17_Delete_Archived_2017_Tournaments_1_WRONG_Query
AS 
SELECT * FROM Bowler_Scores
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches.MatchID
                            FROM          Tourney_Matches INNER JOIN
                                                   Tournaments ON Tournaments.TourneyID = Tourney_Matches.TourneyID
                            WHERE      Tournaments.TourneyDate BETWEEN '1/1/2017' AND '12/31/2017'));
GO

CREATE PROCEDURE CH17_Delete_Archived_2017_Tournaments_2
AS 
DELETE FROM Match_Games
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches_Archive.MatchID
                            FROM          Tourney_Matches_Archive));
GO

CREATE VIEW CH17_Delete_Archived_2017_Tournaments_2_Query
AS 
SELECT * FROM Match_Games
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches_Archive.MatchID
                            FROM          Tourney_Matches_Archive));
GO

CREATE PROCEDURE CH17_Delete_Archived_2017_Tournaments_3
AS 
DELETE FROM Tourney_Matches
WHERE     (MatchID IN
                          (SELECT     MatchID
                            FROM          Tourney_Matches_Archive));
GO

CREATE VIEW CH17_Delete_Archived_2017_Tournaments_3_Query
AS 
SELECT * FROM Tourney_Matches
WHERE     (MatchID IN
                          (SELECT     MatchID
                            FROM          Tourney_Matches_Archive));
GO

CREATE PROCEDURE CH17_Delete_Archived_2017_Tournaments_4
AS 
DELETE FROM Tournaments
WHERE     (TourneyID IN
                          (SELECT     Tournaments_Archive.TourneyID
                            FROM          Tournaments_Archive));
GO

CREATE VIEW CH17_Delete_Archived_2017_Tournaments_4_Query
AS 
SELECT * FROM Tournaments
WHERE     (TourneyID IN
                          (SELECT     Tournaments_Archive.TourneyID
                            FROM          Tournaments_Archive));
GO

CREATE PROCEDURE CH17_Delete_Bowlers_No_Games
AS 
DELETE FROM Bowlers
WHERE     (BowlerGamesBowled = 0);
GO

CREATE VIEW CH17_Delete_Bowlers_No_Games_Query
AS 
SELECT * FROM Bowlers
WHERE     (BowlerGamesBowled = 0);
GO

CREATE PROCEDURE CH17_Delete_Bowlers_No_Games_Safe
AS 
DELETE FROM dbo.Bowlers
WHERE     (BowlerID NOT IN
                          (SELECT     BowlerID
                            FROM          Bowler_Scores));
GO

CREATE VIEW CH17_Delete_Bowlers_No_Games_Safe_Query
AS 
SELECT * FROM dbo.Bowlers
WHERE     (BowlerID NOT IN
                          (SELECT     BowlerID
                            FROM          Bowler_Scores));
GO

CREATE PROCEDURE CH17_Delete_Matches_Not_Played
AS 
DELETE FROM Tourney_Matches
WHERE     (MatchID NOT IN
                          (SELECT     MatchID
                            FROM          Bowler_Scores))
	AND   (MatchID NOT IN
                          (SELECT     MatchID
                            FROM          Match_Games));
GO

CREATE VIEW CH17_Delete_Matches_Not_Played_Query
AS 
SELECT * FROM Tourney_Matches
WHERE     (MatchID NOT IN
                          (SELECT     MatchID
                            FROM          Bowler_Scores))
	AND   (MatchID NOT IN
                          (SELECT     MatchID
                            FROM          Match_Games));
GO

