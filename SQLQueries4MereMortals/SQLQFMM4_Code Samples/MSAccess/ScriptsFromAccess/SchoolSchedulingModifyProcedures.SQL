CREATE PROCEDURE CH15_Fix_Staff_AreaCode
AS 
UPDATE Staff SET Staff.StfAreaCode = '360'
WHERE Staff.StfZipCode IN ('98270','98271');



CREATE VIEW CH15_Fix_Staff_AreaCode_Query
AS 
SELECT Staff.StfAreaCode, '360' AS NewStfAreaCode
FROM Staff
WHERE (((Staff.StfZipCode) In ('98270','98271')));



CREATE PROCEDURE CH15_Fix_Student_AreaCode
AS 
UPDATE Students SET Students.StudAreaCode = '360'
WHERE Students.StudZipCode IN ('98270','98271');



CREATE VIEW CH15_Fix_Student_AreaCode_Query
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudAreaCode, '360' AS NewStudAreaCode
FROM Students
WHERE (((Students.StudZipCode) In ('98270','98271')));



CREATE PROCEDURE CH15_Give_FullTime_Tenured_Raise
AS 
UPDATE Staff SET Staff.Salary = Round((Salary)*1.05,0)
WHERE Staff.StaffID IN  (Select StaffID FROM Faculty WHERE Faculty.Status = 'Full Time'
AND Faculty.Tenured = -1);



CREATE VIEW CH15_Give_FullTime_Tenured_Raise_Query
AS 
SELECT Staff.Salary, Round((Salary)*1.05,0) AS NewSalary
FROM Staff
WHERE (((Staff.StaffID) In (Select StaffID FROM Faculty WHERE Faculty.Status = 'Full Time'
AND Faculty.Tenured = -1)));



CREATE PROCEDURE CH15_Update_Student_GPA
AS 
UPDATE Students SET Students.StudGPA = NZ(Round(DSum('(Credits)*(Grade)','qryCompletedClasses','StudentID = ' & Students.StudentID)/DSum('(Credits)','qryCompletedClasses','StudentID = ' & Students.StudentID),3),0);



CREATE VIEW CH15_Update_Student_GPA_Query
AS 
SELECT StudentID, StudFirstName, StudLastName, Students.StudGPA, Nz(Round(DSum('(Credits)*(Grade)','qryCompletedClasses','StudentID = ' & Students.StudentID)/DSum('(Credits)','qryCompletedClasses','StudentID = ' & Students.StudentID),3),0) AS NewStudGPA
FROM Students;



CREATE PROCEDURE CH16_Add_Category
AS 
INSERT INTO Categories
SELECT 'ITA' AS CategoryID, 'Italian' AS CategoryDescription, Departments.DepartmentID AS DepartmentID
FROM Departments
WHERE (Departments.DeptName='Humanities');



CREATE VIEW CH16_Add_Category_Query
AS 
SELECT 'ITA' AS CategoryID, 'Italian' AS CategoryDescription, Departments.DepartmentID AS DepartmentID
FROM Departments
WHERE (((Departments.DeptName)='Humanities'));



CREATE PROCEDURE CH16_Add_New_Accounting_Class
AS 
INSERT INTO Classes ( ClassID, SubjectID, ClassRoomID, Credits, StartDate, StartTime, Duration, TuesdaySchedule, ThursdaySchedule )
VALUES (6699, 4, 3315, 5, '1/16/2018', '12/30/1899 15:0:0', 80, -1, -1);



CREATE VIEW CH16_Add_New_Accounting_Class_Query
AS 
SELECT 6699 AS ClassID, 4 AS SubjectID, 3315 AS ClassRoomID, 5 AS Credits, '1/16/2018' AS StartDate, '12/30/1899 15:0:0' AS StartTime, 80 AS Duration, -1 AS TuesdaySchedule, -1 AS ThursdaySchedule;



CREATE PROCEDURE CH16_Add_Student
AS 
INSERT INTO Students ( StudFirstName, StudLastName, StudStreetAddress, StudCity, StudState, StudZipCode, StudAreaCode, StudPhoneNumber )
SELECT 'Angel' AS FName, Students.StudLastName, Students.StudStreetAddress, Students.StudCity, Students.StudState, Students.StudZipCode, Students.StudAreaCode, Students.StudPhoneNumber
FROM Students
WHERE (Students.StudFirstName='John')
AND (Students.StudLastName='Kennedy');



CREATE VIEW CH16_Add_Student_Query
AS 
SELECT 'Angel' AS FName, Students.StudLastName, Students.StudStreetAddress, Students.StudCity, Students.StudState, Students.StudZipCode, Students.StudAreaCode, Students.StudPhoneNumber
FROM Students
WHERE (((Students.StudLastName)='Kennedy')
AND ((Students.StudFirstName)='John'));



CREATE PROCEDURE CH16_Enroll_Staff
AS 
INSERT INTO Students ( StudFirstName, StudLastName, StudStreetAddress, StudCity, StudState, StudZipCode, StudAreaCode, StudPhoneNumber )
SELECT Staff.StfFirstName, Staff.StfLastname, Staff.StfStreetAddress, Staff.StfCity, Staff.StfState, Staff.StfZipCode, Staff.StfAreaCode, Staff.StfPhoneNumber
FROM Staff
WHERE (Staff.StfFirstName='Tim')
AND (Staff.StfLastname='Smith');



CREATE VIEW CH16_Enroll_Staff_Query
AS 
SELECT Staff.StfFirstName, Staff.StfLastname, Staff.StfStreetAddress, Staff.StfCity, Staff.StfState, Staff.StfZipCode, Staff.StfAreaCode, Staff.StfPhoneNumber
FROM Staff
WHERE (((Staff.StfFirstName)='Tim')
AND ((Staff.StfLastname)='Smith'));



CREATE PROCEDURE CH17_Delete_Classes_No_Students_1
AS 
DELETE Faculty_Classes.*
FROM Faculty_Classes
WHERE (Faculty_Classes.ClassID Not In (SELECT ClassID FROM Student_Schedules));



CREATE VIEW CH17_Delete_Classes_No_Students_1_Query
AS 
SELECT Faculty_Classes.*
FROM Faculty_Classes
WHERE (((Faculty_Classes.ClassID) Not In (SELECT ClassID FROM Student_Schedules)));



CREATE PROCEDURE CH17_Delete_Classes_No_Students_2
AS 
DELETE Classes.*
FROM Classes
WHERE (Classes.ClassID Not In (SELECT ClassID FROM Student_Schedules));



CREATE VIEW CH17_Delete_Classes_No_Students_2_Query
AS 
SELECT Classes.*
FROM Classes
WHERE (((Classes.ClassID) Not In (SELECT ClassID FROM Student_Schedules)));



CREATE PROCEDURE CH17_Delete_Students_No_Classes
AS 
DELETE Students.*
FROM Students
WHERE (Students.StudentID Not In (SELECT StudentID FROM Student_Schedules));



CREATE VIEW CH17_Delete_Students_No_Classes_Query
AS 
SELECT Students.*
FROM Students
WHERE (((Students.StudentID) Not In (SELECT StudentID FROM Student_Schedules)));



CREATE PROCEDURE CH17_Delete_Subjects_No_Classes_1
AS 
DELETE Faculty_Subjects.*
FROM Faculty_Subjects
WHERE (Faculty_Subjects.SubjectID Not In (SELECT SubjectID FROM Classes));



CREATE VIEW CH17_Delete_Subjects_No_Classes_1_Query
AS 
SELECT Faculty_Subjects.*
FROM Faculty_Subjects
WHERE (((Faculty_Subjects.SubjectID) Not In (SELECT SubjectID FROM Classes)));



CREATE PROCEDURE CH17_Delete_Subjects_No_Classes_2
AS 
DELETE Subjects.*
FROM Subjects
WHERE (Subjects.SubjectID Not In (SELECT SubjectID FROM Classes));



CREATE VIEW CH17_Delete_Subjects_No_Classes_2_Query
AS 
SELECT Subjects.*
FROM Subjects
WHERE (((Subjects.SubjectID) Not In (SELECT SubjectID FROM Classes)));
