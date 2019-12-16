CREATE VIEW CH04_Building_List
AS 
SELECT BuildingName, NumberOfFloors
FROM Buildings
ORDER BY BuildingName;


CREATE VIEW CH04_Class_Information
AS 
SELECT Classes.*
FROM Classes;


CREATE VIEW CH04_Faculty_Titles
AS 
SELECT DISTINCT Title
FROM Faculty;


CREATE VIEW CH04_Staff_Phone_List
AS 
SELECT StfLastname, StfFirstName, StfPhoneNumber
FROM Staff
ORDER BY StfLastname, StfFirstName;


CREATE VIEW CH04_Subject_List
AS 
SELECT Subjects.SubjectName
FROM Subjects;


CREATE VIEW CH05_Length_Of_Service
AS 
SELECT StfLastName || ', ' || StfFirstName AS Staff, DateHired, Int(DateDiff('d',DateHired,'10/1/2017')/365) AS YearsWithSchool
FROM Staff
ORDER BY StfLastName || ', ' || StfFirstName;


CREATE VIEW CH05_Proposed_Bonuses
AS 
SELECT (StfLastName) || ', ' || (StfFirstName) AS Staff, Salary, (Salary)*0.07 AS Bonus
FROM Staff
ORDER BY (StfLastName) || ', ' || (StfFirstName);


CREATE VIEW CH05_Staff_List_By_Salary
AS 
SELECT Salary, (StfLastName) || ', ' || (StfFirstName) AS StaffMember
FROM Staff
ORDER BY Staff.Salary DESC , (StfLastName) || ', ' || (StfFirstName);


CREATE VIEW CH05_Staff_Member_Phone_List
AS 
SELECT (StfLastName) || ', ' || (StfFirstName) AS StaffMember, '(' || (StfAreaCode) || ') ' || (StfPhoneNumber) AS Phone
FROM Staff
ORDER BY (StfLastName) || ', ' || (StfFirstName);


CREATE VIEW CH05_Students_By_City
AS 
SELECT StudCity, (StudLastName) || ', ' || (StudFirstName) AS Student
FROM Students
ORDER BY StudCity, (StudLastName) || ', ' || (StudFirstName);


CREATE VIEW CH06_Full_Time_Associate_Professors
AS 
SELECT Faculty.StaffID, Faculty.Title, Faculty.Status
FROM Faculty
WHERE (((Faculty.Title)='Associate Professor')
AND ((Faculty.Status)='Full Time'));


CREATE VIEW CH06_Seattle_Students_and_Students_Named_Kennedy
AS 
SELECT StudFirstName, StudLastName, StudCity
FROM Students
WHERE StudLastName = 'Kennedy'
OR StudCity = 'Seattle';


CREATE VIEW CH06_Staff_Salaries_40K_To_50K
AS 
SELECT StfFirstName, StfLastname, Salary
FROM Staff
WHERE Salary Between 40000 And 50000
ORDER BY StfLastName, StfFirstName;


CREATE VIEW CH06_Staff_Using_POBoxes
AS 
SELECT StfFirstName, StfLastname, StfStreetAddress
FROM Staff
WHERE StfStreetAddress Like '*Box*'
ORDER BY StfFirstName, StfLastname;


CREATE VIEW CH06_Students_Residing_Outside_PNW
AS 
SELECT StudLastName || ' ' || StudFirstName AS StudentName, StudAreaCode, StudPhoneNumber, StudState
FROM Students
WHERE StudState NOT IN ('ID',  'OR', 'WA');


CREATE VIEW CH06_Subjects_With_MUS_In_SubjectCode
AS 
SELECT SubjectName, SubjectDescription, SubjectCode
FROM Subjects
WHERE SubjectCode LIKE 'MUS*';


CREATE VIEW CH08_Buildings_Classrooms
AS 
SELECT Buildings.BuildingName, Class_Rooms.ClassRoomID
FROM Buildings
INNER JOIN Class_Rooms
ON Buildings.BuildingCode = Class_Rooms.BuildingCode;


CREATE VIEW CH08_Good_Art_CS_Students
AS 
SELECT StudArt.StudFullName
FROM (SELECT DISTINCT Students.StudentID, (Students.StudLastName || ', ' || Students.StudFirstName) AS StudFullName FROM (((Students
INNER JOIN Student_Schedules
ON Students.StudentID = Student_Schedules.StudentID)
INNER JOIN Classes
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Subjects
ON Subjects.SubjectID = Classes.SubjectID)
INNER JOIN Categories
ON Categories.CategoryID = Subjects.CategoryID WHERE Categories.CategoryDescription = 'Art'
AND Student_Schedules.Grade >= 85)  AS StudArt
INNER JOIN (SELECT DISTINCT Student_Schedules.StudentID FROM ((Student_Schedules
INNER JOIN Classes
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Subjects
ON Subjects.SubjectID = Classes.SubjectID)
INNER JOIN Categories
ON Categories.CategoryID = Subjects.CategoryID WHERE Categories.CategoryDescription LIKE '*Computer*'
AND Student_Schedules.Grade >= 85)  AS StudCS
ON StudArt.StudentID = StudCS.StudentID;


CREATE VIEW CH08_Staff_Subjects
AS 
SELECT (Staff.StfLastName || ', ' || Staff.StfFirstName) AS StfFullName, Subjects.SubjectName
FROM (Staff
INNER JOIN Faculty_Subjects
ON Staff.StaffID = Faculty_Subjects.StaffID)
INNER JOIN Subjects
ON Subjects.SubjectID = Faculty_Subjects.SubjectID;


CREATE VIEW CH08_Student_Enrollments
AS 
SELECT (Students.StudLastName || ', ' || Students.StudFirstName) AS StudentFullName, Classes.ClassID, Subjects.SubjectName
FROM (((Students
INNER JOIN Student_Schedules
ON Students.StudentID = Student_Schedules.StudentID)
INNER JOIN Student_Class_Status
ON Student_Schedules.ClassStatus = Student_Class_Status.ClassStatus)
INNER JOIN Classes
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Subjects
ON Subjects.SubjectID = Classes.SubjectID
WHERE Student_Class_Status.ClassStatusDescription = 'Enrolled';


CREATE VIEW CH08_Students_Staff_Same_FirstName
AS 
SELECT (Students.StudFirstName || ' ' || Students.StudLastName) AS StudFullName, (Staff.StfFirstName || ' ' || Staff.StfLastName) AS StfFullName
FROM Students
INNER JOIN Staff
ON Students.StudFirstName = Staff.StfFirstName;


CREATE VIEW CH08_Subjects_On_Wednesday
AS 
SELECT DISTINCT Subjects.SubjectName
FROM Subjects
INNER JOIN Classes
ON Subjects.SubjectID = Classes.SubjectID
WHERE Classes.WednesdaySchedule = -1;


CREATE VIEW CH09_All_Categories_All_Subjects_Any_Classes
AS 
SELECT Categories.CategoryDescription, Subjects.SubjectName, Classes.ClassRoomID, Classes.StartDate, Classes.StartTime, Classes.Duration
FROM (Categories LEFT JOIN Subjects
ON Categories.CategoryID = Subjects.CategoryID) LEFT JOIN Classes
ON Subjects.SubjectID = Classes.SubjectID;


CREATE VIEW CH09_All_Faculty_And_Any_Classes
AS 
SELECT Staff.StfLastName || ', ' || Staff.StfFirstName AS StaffName, Sched.SubjectName, Sched.ClassID, Sched.ClassRoomID, Sched.StartTime, Sched.Duration
FROM Staff LEFT JOIN (SELECT Faculty_Classes.StaffID, Subjects.SubjectName, Classes.ClassID, Classes.ClassRoomID, Classes.StartTime, Classes.Duration FROM Subjects
INNER JOIN (Classes
INNER JOIN Faculty_Classes
ON Classes.ClassID = Faculty_Classes.ClassID)
ON Subjects.SubjectID = Classes.SubjectID)  AS Sched
ON Staff.StaffID = Sched.StaffID;


CREATE VIEW CH09_Classes_No_Students_Enrolled
AS 
SELECT Subjects.SubjectName, Classes.ClassRoomID, Classes.StartTime, Classes.Duration
FROM Subjects
INNER JOIN (Classes LEFT JOIN (SELECT Student_Schedules.ClassID FROM Student_Class_Status
INNER JOIN Student_Schedules
ON Student_Class_Status.ClassStatus = Student_Schedules.ClassStatus WHERE Student_Class_Status.ClassStatusDescription = 'enrolled')  AS Enrolled
ON Classes.ClassID = Enrolled.ClassID)
ON Subjects.SubjectID = Classes.SubjectID
WHERE Enrolled.ClassID IS NULL;


CREATE VIEW CH09_Staff_Not_Teaching
AS 
SELECT Staff.StfFirstName, Staff.StfLastname
FROM Staff LEFT JOIN Faculty_Classes
ON Staff.StaffID = Faculty_Classes.StaffID
WHERE Faculty_Classes.ClassID Is Null;


CREATE VIEW CH09_Students_Never_Withdrawn
AS 
SELECT Students.StudLastName ||  ', ' ||  Students.StudFirstName AS StudFullName
FROM Students LEFT JOIN (SELECT Student_Schedules.StudentID FROM Student_Class_Status
INNER JOIN Student_Schedules
ON Student_Class_Status.ClassStatus = Student_Schedules.ClassStatus WHERE Student_Class_Status.ClassStatusDescription = 'withdrew')  AS Withdrew
ON Students.StudentID = Withdrew.StudentID
WHERE Withdrew.StudentID IS NULL;


CREATE VIEW CH09_Students_Not_Currently_Enrolled
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName
FROM Students LEFT JOIN (SELECT StudentID, ClassID, ClassStatus FROM Student_Schedules WHERE ClassStatus = 1)  AS Sched
ON Students.StudentID = Sched.StudentID
WHERE Sched.StudentID Is Null;


CREATE VIEW CH09_Subjects_No_Faculty
AS 
SELECT Subjects.SubjectID, Subjects.SubjectCode, Subjects.SubjectName
FROM Subjects LEFT JOIN Faculty_Subjects
ON Subjects.SubjectID = Faculty_Subjects.SubjectID
WHERE Faculty_Subjects.StaffID Is Null;


CREATE VIEW CH10_Good_Art_Students_And_Faculty
AS 
SELECT Students.StudFirstName As FirstName, Students.StudLastName As LastName, Student_Schedules.Grade AS Score, 'Student' AS Type
FROM (((Students
INNER JOIN Student_Schedules
ON Students.StudentID = Student_Schedules.StudentID)
INNER JOIN Student_Class_Status
ON Student_Class_Status.ClassStatus = Student_Schedules.ClassStatus)
INNER JOIN Classes
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Subjects
ON Subjects.SubjectID = Classes.SubjectID
WHERE Student_Class_Status.ClassStatusDescription='Completed'
AND Student_Schedules.Grade>=85
AND Subjects.CategoryID='ART'
UNION SELECT Staff.StfFirstName, Staff.StfLastname, Faculty_Subjects.ProficiencyRating AS Score, 'Faculty' AS Type
FROM (Staff
INNER JOIN Faculty_Subjects
ON Staff.StaffID = Faculty_Subjects.StaffID)
INNER JOIN Subjects 
ON Subjects.SubjectID = Faculty_Subjects.SubjectID
WHERE Faculty_Subjects.ProficiencyRating>8
AND Subjects.CategoryID='ART';


CREATE VIEW CH10_Student_Staff_Mailing_List
AS 
SELECT Students.StudFirstName || ' ' ||  Students.StudLastName As Name, Students.StudStreetAddress, Students.StudCity, Students.StudState, Students.StudZipCode
FROM Students UNION SELECT Staff.StfFirstName || ' ' || Staff.StfLastname As Name, Staff.StfStreetAddress, Staff.StfCity, Staff.StfState, Staff.StfZipCode
FROM Staff
ORDER BY 5;


CREATE VIEW CH11_Staff_Class_Count
AS 
SELECT Staff.StaffID, Staff.StfFirstName, Staff.StfLastname, (SELECT COUNT(*) FROM Faculty_Classes WHERE Faculty_Classes.StaffID = Staff.StaffID) AS ClassCount
FROM Staff;


CREATE VIEW CH11_Students_In_Class_Tuesdays
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName
FROM Students
WHERE Students.StudentID IN 
(SELECT StudentID 
FROM Student_Schedules
INNER JOIN Classes
ON Student_Schedules.ClassID = Classes.ClassID 
WHERE Classes.TuesdaySchedule = -1);


CREATE VIEW CH11_Students_Never_Withdrawn
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName
FROM Students
WHERE Students.StudentID NOT IN 
(SELECT Student_Schedules.StudentID 
FROM Student_Schedules
INNER JOIN Student_Class_Status
ON Student_Schedules.ClassStatus = Student_Class_Status.ClassStatus 
WHERE Student_Class_Status.ClassStatusDescription = 'Withdrew');


CREATE VIEW CH11_Subjects_Monday_Count
AS 
SELECT Subjects.SubjectName, (SELECT Count(*) FROM Classes WHERE MondaySchedule = -1
AND Classes.SubjectID = Subjects.SubjectID) AS MondayCount
FROM Subjects;


CREATE VIEW CH11_Subjects_On_Wednesday
AS 
SELECT Categories.CategoryDescription, Subjects.SubjectID, Subjects.SubjectCode, Subjects.SubjectName
FROM Categories
INNER JOIN Subjects
ON Categories.CategoryID = Subjects.CategoryID
WHERE Subjects.SubjectID IN (SELECT SubjectID FROM Classes WHERE Classes.WednesdaySchedule = -1);


CREATE VIEW CH12_Average_Class_Duration
AS 
SELECT AVG(Duration) AS AverageClassDuration
FROM Classes;


CREATE VIEW CH12_Largest_Staff_Salary
AS 
SELECT MAX(Salary) AS LargestStaffSalary
FROM Staff;


CREATE VIEW CH12_Most_Senior_Staff_Members
AS 
SELECT StfLastName + ', ' + StfFirstName AS StaffMember
FROM Staff
WHERE DateHired = (SELECT MIN(DateHired) FROM Staff);


CREATE VIEW CH12_Number_Of_Classes_Held_In_Room_3346
AS 
SELECT COUNT(*) AS TotalNumberOfClasses
FROM Classes
WHERE ClassRoomID = 3346;


CREATE VIEW CH12_Total_Salary_Paid_To_California_Staff
AS 
SELECT Sum(Salary) AS TotalAmountPaid
FROM Staff
WHERE StfState='CA';


CREATE VIEW CH13_Category_Class_Count
AS 
SELECT Categories.CategoryDescription, Count(*) AS ClassCount
FROM (Categories
INNER JOIN Subjects
ON Categories.CategoryID = Subjects.CategoryID)
INNER JOIN Classes
ON Subjects.SubjectID = Classes.SubjectID
GROUP BY Categories.CategoryDescription;


CREATE VIEW CH13_Staff_Class_Count
AS 
SELECT Staff.StfFirstName, Staff.StfLastname, Count(*) AS ClassCount
FROM Staff
INNER JOIN Faculty_Classes
ON Staff.StaffID = Faculty_Classes.StaffID
GROUP BY Staff.StfFirstName, Staff.StfLastname;


CREATE VIEW CH13_Staff_Class_Count_Subquery
AS 
SELECT Staff.StaffID, Staff.StfFirstName, Staff.StfLastname, (SELECT COUNT(*) FROM Faculty_Classes WHERE Faculty_Classes.StaffID = Staff.StaffID) AS ClassCount
FROM Staff;


CREATE VIEW CH13_Student_GradeAverage_By_Category
AS 
SELECT Categories.CategoryDescription, Students.StudFirstName, Students.StudLastName, Avg(Student_Schedules.Grade) AS AvgOfGrade
FROM ((((Categories
INNER JOIN Subjects
ON Categories.CategoryID = Subjects.CategoryID)
INNER JOIN Classes
ON Subjects.SubjectID = Classes.SubjectID)
INNER JOIN Student_Schedules
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Student_Class_Status
ON Student_Class_Status.ClassStatus = 
   Student_Schedules.ClassStatus)
INNER JOIN Students
ON Students.StudentID = 
   Student_Schedules.StudentID
WHERE Student_Class_Status.ClassStatusDescription = 
   'Completed'
GROUP BY Categories.CategoryDescription, Students.StudFirstName, Students.StudLastName;


CREATE VIEW CH14_A_Students
AS 
SELECT Categories.CategoryDescription, Students.StudFirstName, Students.StudLastName, AVG(Student_Schedules.Grade) AS AvgOfGrade
FROM ((((Categories
INNER JOIN Subjects
ON Categories.CategoryID = Subjects.CategoryID)
INNER JOIN Classes
ON Subjects.SubjectID = Classes.SubjectID)
INNER JOIN Student_Schedules
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Student_Class_Status
ON Student_Class_Status.ClassStatus = 
   Student_Schedules.ClassStatus)
INNER JOIN Students
ON Students.StudentID = 
   Student_Schedules.StudentID
WHERE Student_Class_Status.ClassStatusDescription = 
   'Completed'
GROUP BY Categories.CategoryDescription, Students.StudFirstName, Students.StudLastName
HAVING AVG(Student_Schedules.Grade) > 90;


CREATE VIEW CH14_Category_Class_Count_3_Or_More
AS 
SELECT Categories.CategoryDescription, Count(*) AS ClassCount
FROM Categories
INNER JOIN (Subjects
INNER JOIN Classes
ON Subjects.SubjectID = Classes.SubjectID)
ON Categories.CategoryID = Subjects.CategoryID
GROUP BY Categories.CategoryDescription
HAVING (((Count(*))>3));


CREATE VIEW CH14_Count_Of_Biology_Professors
AS 
SELECT COUNT(Faculty.StaffID) AS BiologyProfessors
FROM (Faculty
INNER JOIN Faculty_Categories
ON Faculty.StaffID = 
   Faculty_Categories.StaffID)
INNER JOIN Categories
ON Categories.CategoryID = 
   Faculty_Categories.CategoryID
WHERE Categories.CategoryDescription = 'Biology' 
AND Faculty.Title = 'Professor';


CREATE VIEW CH14_Staff_Class_Count_1_To_3
AS 
SELECT Staff.StfFirstName, Staff.StfLastname, Count(*) AS ClassCount
FROM Staff
INNER JOIN Faculty_Classes
ON Staff.StaffID = Faculty_Classes.StaffID
GROUP BY Staff.StfFirstName, Staff.StfLastname
HAVING COUNT(*) < 3;


CREATE VIEW CH14_Staff_Class_Count_GROUPED_RIGHT
AS 
SELECT Staff.StfFirstName, Staff.StfLastname, Count(Faculty_Classes.StaffID) AS ClassCount
FROM Staff LEFT JOIN Faculty_Classes
ON Staff.StaffID=Faculty_Classes.StaffID
GROUP BY Staff.StfFirstName, Staff.StfLastname;


CREATE VIEW CH14_Staff_Class_Count_GROUPED_WRONG
AS 
SELECT Staff.StfFirstName, Staff.StfLastname, Count(*) AS ClassCount
FROM Staff
INNER JOIN Faculty_Classes
ON Staff.StaffID = Faculty_Classes.StaffID
GROUP BY Staff.StfFirstName, Staff.StfLastname;


CREATE VIEW CH14_Staff_Class_Count_Subquery
AS 
SELECT Staff.StfFirstName, Staff.StfLastname, (SELECT COUNT(*) FROM Faculty_Classes WHERE Faculty_Classes.StaffID = Staff.StaffID) AS ClassCount
FROM Staff
ORDER BY stfFirstName, stfLastName;

CREATE VIEW CH14_Staff_Teaching_LessThan_3
AS 
SELECT Staff.StfLastName || ', ' || Staff.StfFirstName AS StaffName, (SELECT COUNT(S2.StaffID)  
 FROM Staff As S2
INNER JOIN Faculty_Classes
ON S2.StaffID = Faculty_Classes.StaffID
WHERE S2.StaffID = Staff.StaffID) AS StaffClassCount
FROM Staff
WHERE (SELECT COUNT(S3.StaffID)
   FROM Staff As S3
  
INNER JOIN Faculty_Classes
  
ON S3.StaffID = 
      Faculty_Classes.StaffID
   WHERE S3.StaffID = Staff.StaffID) < 3;


CREATE VIEW CH14_Subjects_Fewer_3_Professors_Join_RIGHT
AS 
SELECT Categories.CategoryDescription, Count(FCP.StaffID) AS ProfCount
FROM Categories LEFT JOIN (SELECT Faculty_Categories.CategoryID, Faculty_Categories.StaffID FROM Faculty_Categories
INNER JOIN Faculty
ON Faculty_Categories.StaffID=Faculty.StaffID WHERE Faculty.Title='Professor')  AS FCP
ON Categories.CategoryID=FCP.CategoryID
GROUP BY Categories.CategoryDescription
HAVING Count(FCP.StaffID)<3;


CREATE VIEW CH14_Subjects_Fewer_3_Professors_RIGHT
AS 
SELECT Categories.CategoryDescription, (SELECT COUNT(Faculty.StaffID)
FROM (Faculty
INNER JOIN Faculty_Categories
ON Faculty.StaffID = Faculty_Categories.StaffID)
INNER JOIN Categories As C2
ON C2.CategoryID = Faculty_Categories.CategoryID
WHERE C2.CategoryID = Categories.CategoryID
AND Faculty.Title = 'Professor') AS ProfCount
FROM Categories
WHERE (SELECT COUNT(Faculty.StaffID)
FROM (Faculty
INNER JOIN Faculty_Categories
ON Faculty.StaffID = Faculty_Categories.StaffID)
INNER JOIN Categories As C3
ON C3.CategoryID = Faculty_Categories.CategoryID
WHERE C3.CategoryID = Categories.CategoryID
AND Faculty.Title = 'Professor') < 3;


CREATE VIEW CH14_Subjects_Fewer_3_Professors_WRONG
AS 
SELECT Categories.CategoryDescription, Count(Faculty_Categories.StaffID) AS ProfCount
FROM (Categories
INNER JOIN Faculty_Categories
ON Categories.CategoryID = Faculty_Categories.CategoryID)
INNER JOIN Faculty
ON Faculty.StaffID = Faculty_Categories.StaffID
WHERE Faculty.Title='Professor'
GROUP BY Categories.CategoryDescription
HAVING Count(Faculty_Categories.StaffID) < 3;


CREATE VIEW CH18_Classes_No_Students_Enrolled_NOT_IN
AS 
SELECT Subjects.SubjectName, Classes.ClassRoomID, Classes.StartTime, Classes.Duration
FROM Subjects
INNER JOIN Classes
ON Subjects.SubjectID=Classes.SubjectID
WHERE Classes.ClassID NOT IN (SELECT Student_Schedules.ClassID  FROM Student_Schedules
INNER JOIN Student_Class_Status
ON Student_Schedules.ClassStatus = Student_Class_Status.ClassStatus WHERE Student_Class_Status.ClassStatusDescription = 'Enrolled');


CREATE VIEW CH18_Good_Art_CS_Students_EXISTS
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName
FROM Students
WHERE EXISTS 
(SELECT Student_Schedules.StudentID
FROM ((Student_Schedules
INNER JOIN Classes
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Subjects
ON Subjects.SubjectID = Classes.SubjectID)
INNER JOIN Categories
ON Categories.CategoryID = Subjects.CategoryID
WHERE Categories.CategoryDescription = 'Art'
AND Student_Schedules.Grade >= 85
AND Student_Schedules.StudentID = Students.StudentID)
AND EXISTS 
(SELECT Student_Schedules.StudentID
FROM ((Student_Schedules
INNER JOIN Classes
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Subjects
ON Subjects.SubjectID = Classes.SubjectID)
INNER JOIN Categories
ON Categories.CategoryID = Subjects.CategoryID
WHERE Categories.CategoryDescription LIKE  '*Computer*'
AND Student_Schedules.Grade >= 85
AND Student_Schedules.StudentID = Students.StudentID);


CREATE VIEW CH18_Good_Art_CS_Students_IN
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName
FROM Students
WHERE Students.StudentID IN
(SELECT Student_Schedules.StudentID 
FROM ((Student_Schedules
INNER JOIN Classes 
ON Classes.ClassID = Student_Schedules.ClassID) 
INNER JOIN Subjects 
ON Subjects.SubjectID = Classes.SubjectID) 
INNER JOIN Categories 
ON Categories.CategoryID = Subjects.CategoryID 
WHERE Categories.CategoryDescription = 'Art' 
AND Student_Schedules.Grade >= 85) 
AND Students.StudentID IN 
(SELECT Student_Schedules.StudentID 
FROM ((Student_Schedules
INNER JOIN Classes 
ON Classes.ClassID = Student_Schedules.ClassID) 
INNER JOIN Subjects 
ON Subjects.SubjectID = Classes.SubjectID) 
INNER JOIN Categories 
ON Categories.CategoryID = Subjects.CategoryID 
WHERE Categories.CategoryDescription LIKE '*Computer*' 
AND Student_Schedules.Grade >= 85);


CREATE VIEW CH18_Staff_Not_Teaching_EXISTS
AS 
SELECT Staff.StfFirstName, Staff.StfLastname
FROM Staff
WHERE NOT EXISTS
(SELECT * FROM Faculty_Classes 
WHERE Faculty_Classes.StaffID = Staff.StaffID);


CREATE VIEW CH18_Staff_Teaching_NonAccredited_Classes
AS 
SELECT Staff.StaffID, Staff.StfFirstName, Staff.StfLastname, Classes.ClassID, Classes.ClassRoomID, Classes.StartDate, Classes.SubjectID, Subjects.SubjectCode, Subjects.SubjectName
FROM ((Classes
INNER JOIN Faculty_Classes
ON Classes.ClassID=Faculty_Classes.ClassID)
INNER JOIN Subjects
ON Classes.SubjectID=Subjects.SubjectID)
INNER JOIN Staff
ON Staff.StaffID=Faculty_Classes.StaffID
WHERE Classes.SubjectID Not In (SELECT SubjectID FROM Faculty_Subjects WHERE StaffID = Staff.StaffID);


CREATE VIEW CH18_Students_Missing_Prerequisites
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName, Classes.StartDate, Subjects.SubjectCode, Subjects.SubjectName, Subjects.SubjectPreReq
FROM ((Students
INNER JOIN Student_Schedules
ON Students.StudentID=Student_Schedules.StudentID)
INNER JOIN Classes
ON Classes.ClassID=Student_Schedules.ClassID)
INNER JOIN Subjects
ON Subjects.SubjectID=Classes.SubjectID
WHERE Subjects.SubjectPreReq Is Not Null  
AND Subjects.SubjectPreReq NOT IN  
(SELECT Subjects.SubjectCode  FROM 
((Subjects
INNER JOIN Classes As C2 
ON Subjects.SubjectID = C2.SubjectID)  
INNER JOIN Student_Schedules  
ON C2.ClassID = Student_Schedules.ClassID)  
INNER JOIN Student_Class_Status  
ON Student_Schedules.ClassStatus = Student_Class_Status.ClassStatus  
WHERE Student_Class_Status.ClassStatusDescription <> 'Withdrew'  
AND Student_Schedules.StudentID = Students.StudentID  
AND C2.StartDate <=  Classes.StartDate);


CREATE VIEW CH18_Students_Never_Withdrawn_EXISTS
AS 
SELECT Students.StudLastName || ', ' || Students.StudFirstName AS StudFullName
FROM Students
WHERE NOT EXISTS  (SELECT * FROM Student_Class_Status 
INNER JOIN Student_Schedules 
ON Student_Class_Status.ClassStatus = Student_Schedules.ClassStatus  WHERE Student_Class_Status.ClassStatusDescription = 'withdrew'
AND Student_Schedules.StudentID = Students.StudentID);


CREATE VIEW CH18_Students_Not_Currently_Enrolled_NOT_IN
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName
FROM Students
WHERE Students.StudentID NOT IN 
(SELECT Student_Schedules.StudentID 
FROM Student_Schedules
INNER JOIN Student_Class_Status
ON Student_Schedules.ClassStatus = Student_Class_Status.ClassStatus
WHERE Student_Class_Status.ClassStatusDescription = 'Enrolled');


CREATE VIEW CH18_Students_Passed_All_Grade_GTE_80
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName
FROM Students
INNER JOIN Student_Schedules
ON Students.StudentID=Student_Schedules.StudentID
WHERE (Student_Schedules.Grade>80) And (Student_Schedules.ClassStatus=2)
GROUP BY Students.StudentID, Students.StudFirstName, Students.StudLastName
HAVING Count(Students.StudentID) =  
(SELECT COUNT(*)  
FROM Student_Schedules  
WHERE Student_Schedules.ClassStatus = 2  
AND Student_Schedules.StudentID = Students.StudentID);


CREATE VIEW CH18_Subjects_No_Faculty_NOT_IN
AS 
SELECT Subjects.SubjectID, Subjects.SubjectCode, Subjects.SubjectName
FROM Subjects
WHERE Subjects.SubjectID NOT IN
(SELECT Faculty_Subjects.SubjectID
FROM Faculty_Subjects);


CREATE VIEW CH19_FullTime_Instructor_Raises
AS 
SELECT Staff.StaffID, Staff.StfFirstName, Staff.StfLastname, Faculty.Title, Faculty.Status, Staff.Salary, (IIf(Title = 'Instructor', ROUND(Salary * 1.05, 0), 
                  IIf(Title = 'Associate Professor', ROUND(Salary * 1.04, 0), 
                  IIf(Title = 'Professor', ROUND(Salary * 1.035, 0), Salary)))) AS NewSalary
FROM Staff
INNER JOIN Faculty
ON Staff.StaffID = Faculty.StaffID
WHERE (Faculty.Status = 'Full Time');


CREATE VIEW CH19_Length_Of_Service
AS 
SELECT StaffID, StfFirstName, StfLastname, DateHired, YEAR('10/1/2017')-YEAR(DateHired)-IIf(Month(DateHired)<10,0,IIf(Month(DateHired)>10,1,IIf(Day(DateHired)>1,1,0))) AS LenghtOfService
FROM Staff
ORDER BY StfLastName, StfFirstName;


CREATE VIEW CH19_Male_Students
AS 
SELECT StudentID, StudFirstName, StudLastName, 'Male' AS Gender
FROM Students
WHERE ('Male'=(IIf(StudGender='M','Male','Nomatch')));


CREATE VIEW CH19_Student_Age_Nov15_2017
AS 
SELECT StudentID, StudFirstName, StudLastName, StudBirthDate, DATEDIFF('yyyy',StudBirthDate,'11/15/2017')-IIf(Month(StudBirthDate)<11,0,IIf(Month(StudBirthDate)>11,1,IIf(Day(StudBirthDate)>15,1,0))) AS StudAge
FROM Students;


CREATE VIEW CH19_Student_Gender
AS 
SELECT StudentID, StudFirstName, StudLastName, (IIf(StudGender='M','Male',IIf(StudGender='F','Female','Not Specified'))) AS Gender
FROM Students;


CREATE VIEW CH19_Student_GPA_Avoid_0_Passed
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName, COUNT(SClasses.StudentID) AS NumberCompleted, SUM(SClasses.Credits) AS TotalCredits, (IIf(COUNT(SClasses.StudentID)=0,0,ROUND(SUM(SClasses.Credits*SClasses.Grade)/SUM(SClasses.Credits),3))) AS GPA
FROM Students LEFT JOIN (SELECT Student_Schedules.StudentID, Student_Schedules.Grade, Classes.Credits FROM (Student_Schedules
INNER JOIN Student_Class_Status
ON Student_Schedules.ClassStatus=Student_Class_Status.ClassStatus)
INNER JOIN Classes
ON Student_Schedules.ClassID=Classes.ClassID WHERE (Student_Class_Status.ClassStatusDescription='Completed') And (Student_Schedules.Grade>=67))  AS SClasses
ON Students.StudentID=SClasses.StudentID
GROUP BY Students.StudentID, Students.StudFirstName, Students.StudLastName;


CREATE VIEW CH19_Student_Mailing_List
AS 
SELECT (IIf(StudGender = 'M', 'Mr. ', 
                                IIf(StudMaritalStatus = 'S', 'Ms. ', 'Mrs. '))) || StudFirstName || ' ' || StudLastName AS NameLine, StudStreetAddress AS StreetLine, StudCity || ', ' || StudState || '  ' || StudZipCode AS CityLine
FROM Students;


CREATE VIEW CH19_Student_Marital_Status
AS 
SELECT StudentID, StudFirstName, StudLastName, (IIf(StudMaritalStatus='M','Married',IIf(StudMaritalStatus='S','Single',IIf(StudMaritalStatus='W','Widowed',IIf(StudMaritalStatus='D','Divorced','Not Specified'))))) AS Gender
FROM Students;


CREATE VIEW CH19_Students_Classes_Letter_Grades
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName, Classes.ClassID, Classes.StartDate, Subjects.SubjectCode, Subjects.SubjectName, Student_Schedules.Grade, (IIf(Grade Between 97 And 100,'A+',IIf(Grade Between 93 And 96.99,'A',IIf(Grade Between 90 And 92.99,'A-',IIf(Grade Between 87 And 89.99,'B+',IIf(Grade Between 83 And 86.99,'B',IIf(Grade Between 80 And 82.99,'B-',IIf(Grade Between 77 And 79.99,'C+',IIf(Grade Between 73 And 76.99,'C',IIf(Grade Between 70 And 72.99,'C-',IIf(Grade Between 67 And 69.99,'D+',IIf(Grade Between 63 And 66.99,'D',IIf(Grade Between 60 And 62.99,'D-','F'))))))))))))) AS LetterGrade
FROM (((Students
INNER JOIN Student_Schedules
ON Students.StudentID=Student_Schedules.StudentID)
INNER JOIN Classes
ON Student_Schedules.ClassID=Classes.ClassID)
INNER JOIN Subjects
ON Classes.SubjectID=Subjects.SubjectID)
INNER JOIN Student_Class_Status
ON Student_Schedules.ClassStatus=Student_Class_Status.ClassStatus
WHERE (Student_Class_Status.ClassStatusDescription='Completed');


CREATE VIEW CH20_Class_Schedule_Calendar
AS 
SELECT ztblSemesterDays.SemesterNo, ztblSemesterDays.SemDate, Classes.StartTime, ztblSemesterDays.SemDayName, Subjects.SubjectCode, Subjects.SubjectName, Class_Rooms.BuildingCode, Class_Rooms.ClassRoomID
FROM ztblSemesterDays, (Subjects
INNER JOIN Classes
ON Subjects.SubjectID=Classes.SubjectID)
INNER JOIN Class_Rooms
ON Class_Rooms.ClassRoomID=Classes.ClassRoomID
WHERE Classes.SemesterNumber=ztblSemesterDays.SemesterNo And Classes.StartDate<=ztblSemesterDays.SemDate And (IIf(ztblSemesterDays.SemDayName='Monday' And Classes.MondaySchedule<>0,True,False)
OR IIf(ztblSemesterDays.SemDayName='Tuesday' And Classes.TuesdaySchedule<>0,True,False)
OR IIf(ztblSemesterDays.SemDayName='Wednesday' And Classes.WednesdaySchedule<>0,True,False)
OR IIf(ztblSemesterDays.SemDayName='Thursday' And Classes.ThursdaySchedule<>0,True,False)
OR IIf(ztblSemesterDays.SemDayName='Friday' And Classes.FridaySchedule<>0,True,False)
OR IIf(ztblSemesterDays.SemDayName='Saturday' And Classes.SaturdaySchedule<>0,True,False))
ORDER BY ztblSemesterDays.SemesterNo, ztblSemesterDays.SemDate, Subjects.SubjectCode, Class_Rooms.BuildingCode, Class_Rooms.ClassRoomID, Classes.StartTime;


CREATE VIEW CH20_English_Student_Quintiles
AS 
SELECT S1.SubjectID, S1.StudFirstName, S1.StudLastName, S1.ClassStatus, S1.Grade, S1.CategoryID, S1.SubjectName, S1.RankInCategory, StudCount.NumStudents, IIf(RankInCategory<=0.2*NumStudents,'First',IIf(RankInCategory<=0.4*NumStudents,'Second',IIf(RankInCategory<=0.6*NumStudents,'Third',IIf(RankInCategory<=0.8*NumStudents,'Fourth','Fifth')))) AS Quintile
FROM (SELECT Subjects.SubjectID, Students.StudFirstName, Students.StudLastName, Student_Schedules.ClassStatus, Student_Schedules.Grade, Subjects.CategoryID, Subjects.SubjectName, (SELECT Count(*)   FROM (Classes
INNER JOIN Student_Schedules AS SS2    
ON Classes.ClassID = SS2.ClassID)  
INNER JOIN Subjects As S3  
ON S3.SubjectID = Classes.SubjectID   WHERE S3.CategoryID = 'ENG'
AND SS2.Grade >= Student_Schedules.Grade) AS RankInCategory FROM Subjects
INNER JOIN (Classes
INNER JOIN (Students
INNER JOIN Student_Schedules
ON Students.StudentID=Student_Schedules.StudentID)
ON Classes.ClassID=Student_Schedules.ClassID)
ON Subjects.SubjectID=Classes.SubjectID WHERE Student_Schedules.ClassStatus=2 And Subjects.CategoryID='ENG')  AS S1, (SELECT Count(*) AS NumStudents FROM (Classes AS C2
INNER JOIN Student_Schedules AS SS3
ON C2.ClassID=SS3.ClassID)
INNER JOIN Subjects AS S2
ON S2.SubjectID=C2.SubjectID WHERE SS3.ClassStatus=2 And S2.CategoryID='ENG')  AS StudCount
ORDER BY S1.Grade DESC;


CREATE VIEW CH20_Staff_Proficiency_Ratings
AS 
SELECT StfRatings.StaffID, StfRatings.StfFirstName, StfRatings.StfLastName, StfRatings.Title, StfRatings.AvgRating, ztblProfRatings.ProfRatingDesc
FROM ztblProfRatings, (SELECT Staff.StaffID, Staff.StfFirstName, Staff.StfLastname, Faculty.Title, Avg(Faculty_Subjects.ProficiencyRating) AS AvgRating FROM (Staff
INNER JOIN Faculty
ON Staff.StaffID=Faculty.StaffID)
INNER JOIN Faculty_Subjects
ON Faculty.StaffID=Faculty_Subjects.StaffID GROUP BY Staff.StaffID, Staff.StfFirstName, Staff.StfLastname, Faculty.Title)  AS StfRatings
WHERE StfRatings.AvgRating BETWEEN ztblProfRatings.ProfRatingLow
AND ztblProfRatings.ProfRatingHigh;


CREATE VIEW CH20_Student_Crosstab_Gender_MaritalStatus
AS 
SELECT Students.StudState, Sum(Male*Married) AS MarriedMale, Sum(Male*Single) AS SingleMale, Sum(Male*Widowed) AS WidowedMale, Sum(Male*Divorced) AS DivorcedMale, Sum(Female*Married) AS MarriedFemale, Sum(Female*Single) AS SingleFemale, Sum(Female*Widowed) AS WidowedFemale, Sum(Female*Divorced) AS DivorcedFemale, Sum((Male*Married)+(Male*Single)+(Male*Widowed)+(Male*Divorced)) AS StateMaleTotal, Sum((Female*Married)+(Female*Single)+(Female*Widowed)+(Female*Divorced)) AS StateFemaleTotal, Sum(((Male*Married)+(Male*Single)+(Male*Widowed)+(Male*Divorced))+((Female*Married)+(Female*Single)+(Female*Widowed)+(Female*Divorced))) AS StateTotal
FROM (Students
INNER JOIN ztblMaritalStatusMatrix
ON Students.StudMaritalStatus=ztblMaritalStatusMatrix.MaritalStatus)
INNER JOIN ztblGenderMatrix
ON Students.StudGender=ztblGenderMatrix.Gender
GROUP BY Students.StudState;


CREATE VIEW CH20_Student_Mailing_Skip_2
AS 
SELECT ' ' AS StudFirstName, ' ' AS StudLastName, ' ' AS StudStreetAddress, ' ' AS StudCity, ' ' AS StudState, ' ' AS StudZipCode
FROM ztblSequenceNos 
WHERE ztblSequenceNos.SequenceNo <= 2
UNION ALL SELECT Students.StudFirstName, Students.StudLastName, Students.StudStreetAddress, Students.StudCity, Students.StudState, Students.StudZipCode
FROM Students
ORDER BY StudZipCode, StudLastName;


CREATE VIEW CH20_Students_Additional_Courses
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName, Subjects.SubjectID, Subjects.CategoryID, Subjects.SubjectCode, Subjects.SubjectName, Subjects.SubjectPreReq
FROM Students, Subjects
INNER JOIN Classes
ON Subjects.SubjectID=Classes.SubjectID
WHERE Subjects.SubjectID Not In  (SELECT Su2.SubjectID  FROM (Subjects AS Su2
INNER JOIN Classes 
ON Su2.SubjectID = Classes.SubjectID) 
INNER JOIN Student_Schedules 
ON Classes.ClassID = Student_Schedules.ClassID WHERE Student_Schedules.StudentID = Students.StudentID
AND Student_Schedules.ClassStatus IN (1,2))
ORDER BY Students.StudentID, Subjects.SubjectID;


CREATE VIEW CH20_Students_Classes_Letter_Grades
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName, Classes.ClassID, Classes.StartDate, Subjects.SubjectCode, Subjects.SubjectName, Student_Schedules.Grade, ztblLetterGrades.LetterGrade
FROM ztblLetterGrades, (((Students
INNER JOIN Student_Schedules
ON Students.StudentID=Student_Schedules.StudentID)
INNER JOIN Classes
ON Student_Schedules.ClassID=Classes.ClassID)
INNER JOIN Subjects
ON Classes.SubjectID=Subjects.SubjectID)
INNER JOIN Student_Class_Status
ON Student_Schedules.ClassStatus=Student_Class_Status.ClassStatus
WHERE (Student_Class_Status.ClassStatusDescription='Completed') And (Student_Schedules.Grade Between ztblLetterGrades.LowGradePoint And ztblLetterGrades.HighGradePoint);


 
CREATE VIEW CH04_Building_List
AS 
SELECT BuildingName, NumberOfFloors
FROM Buildings
ORDER BY BuildingName;


CREATE VIEW CH04_Class_Information
AS 
SELECT Classes.*
FROM Classes;


CREATE VIEW CH04_Faculty_Titles
AS 
SELECT DISTINCT Title
FROM Faculty;


CREATE VIEW CH04_Staff_Phone_List
AS 
SELECT StfLastname, StfFirstName, StfPhoneNumber
FROM Staff
ORDER BY StfLastname, StfFirstName;


CREATE VIEW CH04_Subject_List
AS 
SELECT Subjects.SubjectName
FROM Subjects;


CREATE VIEW CH05_Length_Of_Service
AS 
SELECT StfLastName || ', ' || StfFirstName AS Staff, DateHired, Int(DateDiff('d',DateHired,'10/1/2017')/365) AS YearsWithSchool
FROM Staff
ORDER BY StfLastName || ', ' || StfFirstName;


CREATE VIEW CH05_Proposed_Bonuses
AS 
SELECT (StfLastName) || ', ' || (StfFirstName) AS Staff, Salary, (Salary)*0.07 AS Bonus
FROM Staff
ORDER BY (StfLastName) || ', ' || (StfFirstName);


CREATE VIEW CH05_Staff_List_By_Salary
AS 
SELECT Salary, (StfLastName) || ', ' || (StfFirstName) AS StaffMember
FROM Staff
ORDER BY Staff.Salary DESC , (StfLastName) || ', ' || (StfFirstName);


CREATE VIEW CH05_Staff_Member_Phone_List
AS 
SELECT (StfLastName) || ', ' || (StfFirstName) AS StaffMember, '(' || (StfAreaCode) || ') ' || (StfPhoneNumber) AS Phone
FROM Staff
ORDER BY (StfLastName) || ', ' || (StfFirstName);


CREATE VIEW CH05_Students_By_City
AS 
SELECT StudCity, (StudLastName) || ', ' || (StudFirstName) AS Student
FROM Students
ORDER BY StudCity, (StudLastName) || ', ' || (StudFirstName);


CREATE VIEW CH06_Full_Time_Associate_Professors
AS 
SELECT Faculty.StaffID, Faculty.Title, Faculty.Status
FROM Faculty
WHERE (((Faculty.Title)='Associate Professor')
AND ((Faculty.Status)='Full Time'));


CREATE VIEW CH06_Seattle_Students_and_Students_Named_Kennedy
AS 
SELECT StudFirstName, StudLastName, StudCity
FROM Students
WHERE StudLastName = 'Kennedy'
OR StudCity = 'Seattle';


CREATE VIEW CH06_Staff_Salaries_40K_To_50K
AS 
SELECT StfFirstName, StfLastname, Salary
FROM Staff
WHERE Salary Between 40000 And 50000
ORDER BY StfLastName, StfFirstName;


CREATE VIEW CH06_Staff_Using_POBoxes
AS 
SELECT StfFirstName, StfLastname, StfStreetAddress
FROM Staff
WHERE StfStreetAddress Like '*Box*'
ORDER BY StfFirstName, StfLastname;


CREATE VIEW CH06_Students_Residing_Outside_PNW
AS 
SELECT StudLastName || ' ' || StudFirstName AS StudentName, StudAreaCode, StudPhoneNumber, StudState
FROM Students
WHERE StudState NOT IN ('ID',  'OR', 'WA');


CREATE VIEW CH06_Subjects_With_MUS_In_SubjectCode
AS 
SELECT SubjectName, SubjectDescription, SubjectCode
FROM Subjects
WHERE SubjectCode LIKE 'MUS*';


CREATE VIEW CH08_Buildings_Classrooms
AS 
SELECT Buildings.BuildingName, Class_Rooms.ClassRoomID
FROM Buildings
INNER JOIN Class_Rooms
ON Buildings.BuildingCode = Class_Rooms.BuildingCode;


CREATE VIEW CH08_Good_Art_CS_Students
AS 
SELECT StudArt.StudFullName
FROM (SELECT DISTINCT Students.StudentID, (Students.StudLastName || ', ' || Students.StudFirstName) AS StudFullName FROM (((Students
INNER JOIN Student_Schedules
ON Students.StudentID = Student_Schedules.StudentID)
INNER JOIN Classes
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Subjects
ON Subjects.SubjectID = Classes.SubjectID)
INNER JOIN Categories
ON Categories.CategoryID = Subjects.CategoryID WHERE Categories.CategoryDescription = 'Art'
AND Student_Schedules.Grade >= 85)  AS StudArt
INNER JOIN (SELECT DISTINCT Student_Schedules.StudentID FROM ((Student_Schedules
INNER JOIN Classes
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Subjects
ON Subjects.SubjectID = Classes.SubjectID)
INNER JOIN Categories
ON Categories.CategoryID = Subjects.CategoryID WHERE Categories.CategoryDescription LIKE '*Computer*'
AND Student_Schedules.Grade >= 85)  AS StudCS
ON StudArt.StudentID = StudCS.StudentID;


CREATE VIEW CH08_Staff_Subjects
AS 
SELECT (Staff.StfLastName || ', ' || Staff.StfFirstName) AS StfFullName, Subjects.SubjectName
FROM (Staff
INNER JOIN Faculty_Subjects
ON Staff.StaffID = Faculty_Subjects.StaffID)
INNER JOIN Subjects
ON Subjects.SubjectID = Faculty_Subjects.SubjectID;


CREATE VIEW CH08_Student_Enrollments
AS 
SELECT (Students.StudLastName || ', ' || Students.StudFirstName) AS StudentFullName, Classes.ClassID, Subjects.SubjectName
FROM (((Students
INNER JOIN Student_Schedules
ON Students.StudentID = Student_Schedules.StudentID)
INNER JOIN Student_Class_Status
ON Student_Schedules.ClassStatus = Student_Class_Status.ClassStatus)
INNER JOIN Classes
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Subjects
ON Subjects.SubjectID = Classes.SubjectID
WHERE Student_Class_Status.ClassStatusDescription = 'Enrolled';


CREATE VIEW CH08_Students_Staff_Same_FirstName
AS 
SELECT (Students.StudFirstName || ' ' || Students.StudLastName) AS StudFullName, (Staff.StfFirstName || ' ' || Staff.StfLastName) AS StfFullName
FROM Students
INNER JOIN Staff
ON Students.StudFirstName = Staff.StfFirstName;


CREATE VIEW CH08_Subjects_On_Wednesday
AS 
SELECT DISTINCT Subjects.SubjectName
FROM Subjects
INNER JOIN Classes
ON Subjects.SubjectID = Classes.SubjectID
WHERE Classes.WednesdaySchedule = -1;


CREATE VIEW CH09_All_Categories_All_Subjects_Any_Classes
AS 
SELECT Categories.CategoryDescription, Subjects.SubjectName, Classes.ClassRoomID, Classes.StartDate, Classes.StartTime, Classes.Duration
FROM (Categories LEFT JOIN Subjects
ON Categories.CategoryID = Subjects.CategoryID) LEFT JOIN Classes
ON Subjects.SubjectID = Classes.SubjectID;


CREATE VIEW CH09_All_Faculty_And_Any_Classes
AS 
SELECT Staff.StfLastName || ', ' || Staff.StfFirstName AS StaffName, Sched.SubjectName, Sched.ClassID, Sched.ClassRoomID, Sched.StartTime, Sched.Duration
FROM Staff LEFT JOIN (SELECT Faculty_Classes.StaffID, Subjects.SubjectName, Classes.ClassID, Classes.ClassRoomID, Classes.StartTime, Classes.Duration FROM Subjects
INNER JOIN (Classes
INNER JOIN Faculty_Classes
ON Classes.ClassID = Faculty_Classes.ClassID)
ON Subjects.SubjectID = Classes.SubjectID)  AS Sched
ON Staff.StaffID = Sched.StaffID;


CREATE VIEW CH09_Classes_No_Students_Enrolled
AS 
SELECT Subjects.SubjectName, Classes.ClassRoomID, Classes.StartTime, Classes.Duration
FROM Subjects
INNER JOIN (Classes LEFT JOIN (SELECT Student_Schedules.ClassID FROM Student_Class_Status
INNER JOIN Student_Schedules
ON Student_Class_Status.ClassStatus = Student_Schedules.ClassStatus WHERE Student_Class_Status.ClassStatusDescription = 'enrolled')  AS Enrolled
ON Classes.ClassID = Enrolled.ClassID)
ON Subjects.SubjectID = Classes.SubjectID
WHERE Enrolled.ClassID IS NULL;


CREATE VIEW CH09_Staff_Not_Teaching
AS 
SELECT Staff.StfFirstName, Staff.StfLastname
FROM Staff LEFT JOIN Faculty_Classes
ON Staff.StaffID = Faculty_Classes.StaffID
WHERE Faculty_Classes.ClassID Is Null;


CREATE VIEW CH09_Students_Never_Withdrawn
AS 
SELECT Students.StudLastName ||  ', ' ||  Students.StudFirstName AS StudFullName
FROM Students LEFT JOIN (SELECT Student_Schedules.StudentID FROM Student_Class_Status
INNER JOIN Student_Schedules
ON Student_Class_Status.ClassStatus = Student_Schedules.ClassStatus WHERE Student_Class_Status.ClassStatusDescription = 'withdrew')  AS Withdrew
ON Students.StudentID = Withdrew.StudentID
WHERE Withdrew.StudentID IS NULL;


CREATE VIEW CH09_Students_Not_Currently_Enrolled
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName
FROM Students LEFT JOIN (SELECT StudentID, ClassID, ClassStatus FROM Student_Schedules WHERE ClassStatus = 1)  AS Sched
ON Students.StudentID = Sched.StudentID
WHERE Sched.StudentID Is Null;


CREATE VIEW CH09_Subjects_No_Faculty
AS 
SELECT Subjects.SubjectID, Subjects.SubjectCode, Subjects.SubjectName
FROM Subjects LEFT JOIN Faculty_Subjects
ON Subjects.SubjectID = Faculty_Subjects.SubjectID
WHERE Faculty_Subjects.StaffID Is Null;


CREATE VIEW CH10_Good_Art_Students_And_Faculty
AS 
SELECT Students.StudFirstName As FirstName, Students.StudLastName As LastName, Student_Schedules.Grade AS Score, 'Student' AS Type
FROM (((Students
INNER JOIN Student_Schedules
ON Students.StudentID = Student_Schedules.StudentID)
INNER JOIN Student_Class_Status
ON Student_Class_Status.ClassStatus = Student_Schedules.ClassStatus)
INNER JOIN Classes
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Subjects
ON Subjects.SubjectID = Classes.SubjectID
WHERE Student_Class_Status.ClassStatusDescription='Completed'
AND Student_Schedules.Grade>=85
AND Subjects.CategoryID='ART'
UNION SELECT Staff.StfFirstName, Staff.StfLastname, Faculty_Subjects.ProficiencyRating AS Score, 'Faculty' AS Type
FROM (Staff
INNER JOIN Faculty_Subjects
ON Staff.StaffID = Faculty_Subjects.StaffID)
INNER JOIN Subjects 
ON Subjects.SubjectID = Faculty_Subjects.SubjectID
WHERE Faculty_Subjects.ProficiencyRating>8
AND Subjects.CategoryID='ART';


CREATE VIEW CH10_Student_Staff_Mailing_List
AS 
SELECT Students.StudFirstName || ' ' ||  Students.StudLastName As Name, Students.StudStreetAddress, Students.StudCity, Students.StudState, Students.StudZipCode
FROM Students UNION SELECT Staff.StfFirstName || ' ' || Staff.StfLastname As Name, Staff.StfStreetAddress, Staff.StfCity, Staff.StfState, Staff.StfZipCode
FROM Staff
ORDER BY 5;


CREATE VIEW CH11_Staff_Class_Count
AS 
SELECT Staff.StaffID, Staff.StfFirstName, Staff.StfLastname, (SELECT COUNT(*) FROM Faculty_Classes WHERE Faculty_Classes.StaffID = Staff.StaffID) AS ClassCount
FROM Staff;


CREATE VIEW CH11_Students_In_Class_Tuesdays
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName
FROM Students
WHERE Students.StudentID IN 
(SELECT StudentID 
FROM Student_Schedules
INNER JOIN Classes
ON Student_Schedules.ClassID = Classes.ClassID 
WHERE Classes.TuesdaySchedule = -1);


CREATE VIEW CH11_Students_Never_Withdrawn
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName
FROM Students
WHERE Students.StudentID NOT IN 
(SELECT Student_Schedules.StudentID 
FROM Student_Schedules
INNER JOIN Student_Class_Status
ON Student_Schedules.ClassStatus = Student_Class_Status.ClassStatus 
WHERE Student_Class_Status.ClassStatusDescription = 'Withdrew');


CREATE VIEW CH11_Subjects_Monday_Count
AS 
SELECT Subjects.SubjectName, (SELECT Count(*) FROM Classes WHERE MondaySchedule = -1
AND Classes.SubjectID = Subjects.SubjectID) AS MondayCount
FROM Subjects;


CREATE VIEW CH11_Subjects_On_Wednesday
AS 
SELECT Categories.CategoryDescription, Subjects.SubjectID, Subjects.SubjectCode, Subjects.SubjectName
FROM Categories
INNER JOIN Subjects
ON Categories.CategoryID = Subjects.CategoryID
WHERE Subjects.SubjectID IN (SELECT SubjectID FROM Classes WHERE Classes.WednesdaySchedule = -1);


CREATE VIEW CH12_Average_Class_Duration
AS 
SELECT AVG(Duration) AS AverageClassDuration
FROM Classes;


CREATE VIEW CH12_Largest_Staff_Salary
AS 
SELECT MAX(Salary) AS LargestStaffSalary
FROM Staff;


CREATE VIEW CH12_Most_Senior_Staff_Members
AS 
SELECT StfLastName + ', ' + StfFirstName AS StaffMember
FROM Staff
WHERE DateHired = (SELECT MIN(DateHired) FROM Staff);


CREATE VIEW CH12_Number_Of_Classes_Held_In_Room_3346
AS 
SELECT COUNT(*) AS TotalNumberOfClasses
FROM Classes
WHERE ClassRoomID = 3346;


CREATE VIEW CH12_Total_Salary_Paid_To_California_Staff
AS 
SELECT Sum(Salary) AS TotalAmountPaid
FROM Staff
WHERE StfState='CA';


CREATE VIEW CH13_Category_Class_Count
AS 
SELECT Categories.CategoryDescription, Count(*) AS ClassCount
FROM (Categories
INNER JOIN Subjects
ON Categories.CategoryID = Subjects.CategoryID)
INNER JOIN Classes
ON Subjects.SubjectID = Classes.SubjectID
GROUP BY Categories.CategoryDescription;


CREATE VIEW CH13_Staff_Class_Count
AS 
SELECT Staff.StfFirstName, Staff.StfLastname, Count(*) AS ClassCount
FROM Staff
INNER JOIN Faculty_Classes
ON Staff.StaffID = Faculty_Classes.StaffID
GROUP BY Staff.StfFirstName, Staff.StfLastname;


CREATE VIEW CH13_Staff_Class_Count_Subquery
AS 
SELECT Staff.StaffID, Staff.StfFirstName, Staff.StfLastname, (SELECT COUNT(*) FROM Faculty_Classes WHERE Faculty_Classes.StaffID = Staff.StaffID) AS ClassCount
FROM Staff;


CREATE VIEW CH13_Student_GradeAverage_By_Category
AS 
SELECT Categories.CategoryDescription, Students.StudFirstName, Students.StudLastName, Avg(Student_Schedules.Grade) AS AvgOfGrade
FROM ((((Categories
INNER JOIN Subjects
ON Categories.CategoryID = Subjects.CategoryID)
INNER JOIN Classes
ON Subjects.SubjectID = Classes.SubjectID)
INNER JOIN Student_Schedules
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Student_Class_Status
ON Student_Class_Status.ClassStatus = 
   Student_Schedules.ClassStatus)
INNER JOIN Students
ON Students.StudentID = 
   Student_Schedules.StudentID
WHERE Student_Class_Status.ClassStatusDescription = 
   'Completed'
GROUP BY Categories.CategoryDescription, Students.StudFirstName, Students.StudLastName;


CREATE VIEW CH14_A_Students
AS 
SELECT Categories.CategoryDescription, Students.StudFirstName, Students.StudLastName, AVG(Student_Schedules.Grade) AS AvgOfGrade
FROM ((((Categories
INNER JOIN Subjects
ON Categories.CategoryID = Subjects.CategoryID)
INNER JOIN Classes
ON Subjects.SubjectID = Classes.SubjectID)
INNER JOIN Student_Schedules
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Student_Class_Status
ON Student_Class_Status.ClassStatus = 
   Student_Schedules.ClassStatus)
INNER JOIN Students
ON Students.StudentID = 
   Student_Schedules.StudentID
WHERE Student_Class_Status.ClassStatusDescription = 
   'Completed'
GROUP BY Categories.CategoryDescription, Students.StudFirstName, Students.StudLastName
HAVING AVG(Student_Schedules.Grade) > 90;


CREATE VIEW CH14_Category_Class_Count_3_Or_More
AS 
SELECT Categories.CategoryDescription, Count(*) AS ClassCount
FROM Categories
INNER JOIN (Subjects
INNER JOIN Classes
ON Subjects.SubjectID = Classes.SubjectID)
ON Categories.CategoryID = Subjects.CategoryID
GROUP BY Categories.CategoryDescription
HAVING (((Count(*))>3));


CREATE VIEW CH14_Count_Of_Biology_Professors
AS 
SELECT COUNT(Faculty.StaffID) AS BiologyProfessors
FROM (Faculty
INNER JOIN Faculty_Categories
ON Faculty.StaffID = 
   Faculty_Categories.StaffID)
INNER JOIN Categories
ON Categories.CategoryID = 
   Faculty_Categories.CategoryID
WHERE Categories.CategoryDescription = 'Biology' 
AND Faculty.Title = 'Professor';


CREATE VIEW CH14_Staff_Class_Count_1_To_3
AS 
SELECT Staff.StfFirstName, Staff.StfLastname, Count(*) AS ClassCount
FROM Staff
INNER JOIN Faculty_Classes
ON Staff.StaffID = Faculty_Classes.StaffID
GROUP BY Staff.StfFirstName, Staff.StfLastname
HAVING COUNT(*) < 3;


CREATE VIEW CH14_Staff_Class_Count_GROUPED_RIGHT
AS 
SELECT Staff.StfFirstName, Staff.StfLastname, Count(Faculty_Classes.StaffID) AS ClassCount
FROM Staff LEFT JOIN Faculty_Classes
ON Staff.StaffID=Faculty_Classes.StaffID
GROUP BY Staff.StfFirstName, Staff.StfLastname;


CREATE VIEW CH14_Staff_Class_Count_GROUPED_WRONG
AS 
SELECT Staff.StfFirstName, Staff.StfLastname, Count(*) AS ClassCount
FROM Staff
INNER JOIN Faculty_Classes
ON Staff.StaffID = Faculty_Classes.StaffID
GROUP BY Staff.StfFirstName, Staff.StfLastname;


CREATE VIEW CH14_Staff_Class_Count_Subquery
AS 
SELECT Staff.StaffID, Staff.StfFirstName, Staff.StfLastname, (SELECT COUNT(*) FROM Faculty_Classes WHERE Faculty_Classes.StaffID = Staff.StaffID) AS ClassCount
FROM Staff;


CREATE VIEW CH14_Staff_Teaching_LessThan_3
AS 
SELECT Staff.StfLastName || ', ' || Staff.StfFirstName AS StaffName, (SELECT COUNT(S2.StaffID)  
 FROM Staff As S2
INNER JOIN Faculty_Classes
ON S2.StaffID = Faculty_Classes.StaffID
WHERE S2.StaffID = Staff.StaffID) AS StaffClassCount
FROM Staff
WHERE (SELECT COUNT(S3.StaffID)
   FROM Staff As S3
  
INNER JOIN Faculty_Classes
  
ON S3.StaffID = 
      Faculty_Classes.StaffID
   WHERE S3.StaffID = Staff.StaffID) < 3;


CREATE VIEW CH14_Subjects_Fewer_3_Professors_Join_RIGHT
AS 
SELECT Categories.CategoryDescription, Count(FCP.StaffID) AS ProfCount
FROM Categories LEFT JOIN (SELECT Faculty_Categories.CategoryID, Faculty_Categories.StaffID FROM Faculty_Categories
INNER JOIN Faculty
ON Faculty_Categories.StaffID=Faculty.StaffID WHERE Faculty.Title='Professor')  AS FCP
ON Categories.CategoryID=FCP.CategoryID
GROUP BY Categories.CategoryDescription
HAVING Count(FCP.StaffID)<3;


CREATE VIEW CH14_Subjects_Fewer_3_Professors_RIGHT
AS 
SELECT Categories.CategoryDescription, (SELECT COUNT(Faculty.StaffID)
FROM (Faculty
INNER JOIN Faculty_Categories
ON Faculty.StaffID = Faculty_Categories.StaffID)
INNER JOIN Categories As C2
ON C2.CategoryID = Faculty_Categories.CategoryID
WHERE C2.CategoryID = Categories.CategoryID
AND Faculty.Title = 'Professor') AS ProfCount
FROM Categories
WHERE (SELECT COUNT(Faculty.StaffID)
FROM (Faculty
INNER JOIN Faculty_Categories
ON Faculty.StaffID = Faculty_Categories.StaffID)
INNER JOIN Categories As C3
ON C3.CategoryID = Faculty_Categories.CategoryID
WHERE C3.CategoryID = Categories.CategoryID
AND Faculty.Title = 'Professor') < 3;


CREATE VIEW CH14_Subjects_Fewer_3_Professors_WRONG
AS 
SELECT Categories.CategoryDescription, Count(Faculty_Categories.StaffID) AS ProfCount
FROM (Categories
INNER JOIN Faculty_Categories
ON Categories.CategoryID = Faculty_Categories.CategoryID)
INNER JOIN Faculty
ON Faculty.StaffID = Faculty_Categories.StaffID
WHERE Faculty.Title='Professor'
GROUP BY Categories.CategoryDescription
HAVING Count(Faculty_Categories.StaffID) < 3;


CREATE VIEW CH18_Classes_No_Students_Enrolled_NOT_IN
AS 
SELECT Subjects.SubjectName, Classes.ClassRoomID, Classes.StartTime, Classes.Duration
FROM Subjects
INNER JOIN Classes
ON Subjects.SubjectID=Classes.SubjectID
WHERE Classes.ClassID NOT IN (SELECT Student_Schedules.ClassID  FROM Student_Schedules
INNER JOIN Student_Class_Status
ON Student_Schedules.ClassStatus = Student_Class_Status.ClassStatus WHERE Student_Class_Status.ClassStatusDescription = 'Enrolled');


CREATE VIEW CH18_Good_Art_CS_Students_EXISTS
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName
FROM Students
WHERE EXISTS 
(SELECT Student_Schedules.StudentID
FROM ((Student_Schedules
INNER JOIN Classes
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Subjects
ON Subjects.SubjectID = Classes.SubjectID)
INNER JOIN Categories
ON Categories.CategoryID = Subjects.CategoryID
WHERE Categories.CategoryDescription = 'Art'
AND Student_Schedules.Grade >= 85
AND Student_Schedules.StudentID = Students.StudentID)
AND EXISTS 
(SELECT Student_Schedules.StudentID
FROM ((Student_Schedules
INNER JOIN Classes
ON Classes.ClassID = Student_Schedules.ClassID)
INNER JOIN Subjects
ON Subjects.SubjectID = Classes.SubjectID)
INNER JOIN Categories
ON Categories.CategoryID = Subjects.CategoryID
WHERE Categories.CategoryDescription LIKE  '*Computer*'
AND Student_Schedules.Grade >= 85
AND Student_Schedules.StudentID = Students.StudentID);


CREATE VIEW CH18_Good_Art_CS_Students_IN
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName
FROM Students
WHERE Students.StudentID IN
(SELECT Student_Schedules.StudentID 
FROM ((Student_Schedules
INNER JOIN Classes 
ON Classes.ClassID = Student_Schedules.ClassID) 
INNER JOIN Subjects 
ON Subjects.SubjectID = Classes.SubjectID) 
INNER JOIN Categories 
ON Categories.CategoryID = Subjects.CategoryID 
WHERE Categories.CategoryDescription = 'Art' 
AND Student_Schedules.Grade >= 85) 
AND Students.StudentID IN 
(SELECT Student_Schedules.StudentID 
FROM ((Student_Schedules
INNER JOIN Classes 
ON Classes.ClassID = Student_Schedules.ClassID) 
INNER JOIN Subjects 
ON Subjects.SubjectID = Classes.SubjectID) 
INNER JOIN Categories 
ON Categories.CategoryID = Subjects.CategoryID 
WHERE Categories.CategoryDescription LIKE '*Computer*' 
AND Student_Schedules.Grade >= 85);


CREATE VIEW CH18_Staff_Not_Teaching_EXISTS
AS 
SELECT Staff.StfFirstName, Staff.StfLastname
FROM Staff
WHERE NOT EXISTS
(SELECT * FROM Faculty_Classes 
WHERE Faculty_Classes.StaffID = Staff.StaffID);


CREATE VIEW CH18_Staff_Teaching_NonAccredited_Classes
AS 
SELECT Staff.StaffID, Staff.StfFirstName, Staff.StfLastname, Classes.ClassID, Classes.ClassRoomID, Classes.StartDate, Classes.SubjectID, Subjects.SubjectCode, Subjects.SubjectName
FROM ((Classes
INNER JOIN Faculty_Classes
ON Classes.ClassID=Faculty_Classes.ClassID)
INNER JOIN Subjects
ON Classes.SubjectID=Subjects.SubjectID)
INNER JOIN Staff
ON Staff.StaffID=Faculty_Classes.StaffID
WHERE Classes.SubjectID Not In (SELECT SubjectID FROM Faculty_Subjects WHERE StaffID = Staff.StaffID);


CREATE VIEW CH18_Students_Missing_Prerequisites
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName, Classes.StartDate, Subjects.SubjectCode, Subjects.SubjectName, Subjects.SubjectPreReq
FROM ((Students
INNER JOIN Student_Schedules
ON Students.StudentID=Student_Schedules.StudentID)
INNER JOIN Classes
ON Classes.ClassID=Student_Schedules.ClassID)
INNER JOIN Subjects
ON Subjects.SubjectID=Classes.SubjectID
WHERE Subjects.SubjectPreReq Is Not Null  
AND Subjects.SubjectPreReq NOT IN  
(SELECT Subjects.SubjectCode  FROM 
((Subjects
INNER JOIN Classes As C2 
ON Subjects.SubjectID = C2.SubjectID)  
INNER JOIN Student_Schedules  
ON C2.ClassID = Student_Schedules.ClassID)  
INNER JOIN Student_Class_Status  
ON Student_Schedules.ClassStatus = Student_Class_Status.ClassStatus  
WHERE Student_Class_Status.ClassStatusDescription <> 'Withdrew'  
AND Student_Schedules.StudentID = Students.StudentID  
AND C2.StartDate <=  Classes.StartDate);


CREATE VIEW CH18_Students_Never_Withdrawn_EXISTS
AS 
SELECT Students.StudLastName || ', ' || Students.StudFirstName AS StudFullName
FROM Students
WHERE NOT EXISTS  (SELECT * FROM Student_Class_Status 
INNER JOIN Student_Schedules 
ON Student_Class_Status.ClassStatus = Student_Schedules.ClassStatus  WHERE Student_Class_Status.ClassStatusDescription = 'withdrew'
AND Student_Schedules.StudentID = Students.StudentID);


CREATE VIEW CH18_Students_Not_Currently_Enrolled_NOT_IN
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName
FROM Students
WHERE Students.StudentID NOT IN 
(SELECT Student_Schedules.StudentID 
FROM Student_Schedules
INNER JOIN Student_Class_Status
ON Student_Schedules.ClassStatus = Student_Class_Status.ClassStatus
WHERE Student_Class_Status.ClassStatusDescription = 'Enrolled');


CREATE VIEW CH18_Students_Passed_All_Grade_GTE_80
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName
FROM Students
INNER JOIN Student_Schedules
ON Students.StudentID=Student_Schedules.StudentID
WHERE (Student_Schedules.Grade>80) And (Student_Schedules.ClassStatus=2)
GROUP BY Students.StudentID, Students.StudFirstName, Students.StudLastName
HAVING Count(Students.StudentID) =  
(SELECT COUNT(*)  
FROM Student_Schedules  
WHERE Student_Schedules.ClassStatus = 2  
AND Student_Schedules.StudentID = Students.StudentID);


CREATE VIEW CH18_Subjects_No_Faculty_NOT_IN
AS 
SELECT Subjects.SubjectID, Subjects.SubjectCode, Subjects.SubjectName
FROM Subjects
WHERE Subjects.SubjectID NOT IN
(SELECT Faculty_Subjects.SubjectID
FROM Faculty_Subjects);


CREATE VIEW CH19_FullTime_Instructor_Raises
AS 
SELECT Staff.StaffID, Staff.StfFirstName, Staff.StfLastname, Faculty.Title, Faculty.Status, Staff.Salary, (IIf(Title = 'Instructor', ROUND(Salary * 1.05, 0), 
                  IIf(Title = 'Associate Professor', ROUND(Salary * 1.04, 0), 
                  IIf(Title = 'Professor', ROUND(Salary * 1.035, 0), Salary)))) AS NewSalary
FROM Staff
INNER JOIN Faculty
ON Staff.StaffID = Faculty.StaffID
WHERE (Faculty.Status = 'Full Time');


CREATE VIEW CH19_Length_Of_Service
AS 
SELECT StaffID, StfFirstName, StfLastname, DateHired, YEAR('10/1/2017')-YEAR(DateHired)-IIf(Month(DateHired)<10,0,IIf(Month(DateHired)>10,1,IIf(Day(DateHired)>1,1,0))) AS LenghtOfService
FROM Staff
ORDER BY StfLastName, StfFirstName;


CREATE VIEW CH19_Male_Students
AS 
SELECT StudentID, StudFirstName, StudLastName, 'Male' AS Gender
FROM Students
WHERE ('Male'=(IIf(StudGender='M','Male','Nomatch')));


CREATE VIEW CH19_Student_Age_Nov15_2017
AS 
SELECT StudentID, StudFirstName, StudLastName, StudBirthDate, DATEDIFF('yyyy',StudBirthDate,'11/15/2017')-IIf(Month(StudBirthDate)<11,0,IIf(Month(StudBirthDate)>11,1,IIf(Day(StudBirthDate)>15,1,0))) AS StudAge
FROM Students;


CREATE VIEW CH19_Student_Gender
AS 
SELECT StudentID, StudFirstName, StudLastName, (IIf(StudGender='M','Male',IIf(StudGender='F','Female','Not Specified'))) AS Gender
FROM Students;


CREATE VIEW CH19_Student_GPA_Avoid_0_Passed
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName, COUNT(SClasses.StudentID) AS NumberCompleted, SUM(SClasses.Credits) AS TotalCredits, (IIf(COUNT(SClasses.StudentID)=0,0,ROUND(SUM(SClasses.Credits*SClasses.Grade)/SUM(SClasses.Credits),3))) AS GPA
FROM Students LEFT JOIN (SELECT Student_Schedules.StudentID, Student_Schedules.Grade, Classes.Credits FROM (Student_Schedules
INNER JOIN Student_Class_Status
ON Student_Schedules.ClassStatus=Student_Class_Status.ClassStatus)
INNER JOIN Classes
ON Student_Schedules.ClassID=Classes.ClassID WHERE (Student_Class_Status.ClassStatusDescription='Completed') And (Student_Schedules.Grade>=67))  AS SClasses
ON Students.StudentID=SClasses.StudentID
GROUP BY Students.StudentID, Students.StudFirstName, Students.StudLastName;


CREATE VIEW CH19_Student_Mailing_List
AS 
SELECT (IIf(StudGender = 'M', 'Mr. ', 
                                IIf(StudMaritalStatus = 'S', 'Ms. ', 'Mrs. '))) || StudFirstName || ' ' || StudLastName AS NameLine, StudStreetAddress AS StreetLine, StudCity || ', ' || StudState || '  ' || StudZipCode AS CityLine
FROM Students;


CREATE VIEW CH19_Student_Marital_Status
AS 
SELECT StudentID, StudFirstName, StudLastName, (IIf(StudMaritalStatus='M','Married',IIf(StudMaritalStatus='S','Single',IIf(StudMaritalStatus='W','Widowed',IIf(StudMaritalStatus='D','Divorced','Not Specified'))))) AS Gender
FROM Students;


CREATE VIEW CH19_Students_Classes_Letter_Grades
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName, Classes.ClassID, Classes.StartDate, Subjects.SubjectCode, Subjects.SubjectName, Student_Schedules.Grade, (IIf(Grade Between 97 And 100,'A+',IIf(Grade Between 93 And 96.99,'A',IIf(Grade Between 90 And 92.99,'A-',IIf(Grade Between 87 And 89.99,'B+',IIf(Grade Between 83 And 86.99,'B',IIf(Grade Between 80 And 82.99,'B-',IIf(Grade Between 77 And 79.99,'C+',IIf(Grade Between 73 And 76.99,'C',IIf(Grade Between 70 And 72.99,'C-',IIf(Grade Between 67 And 69.99,'D+',IIf(Grade Between 63 And 66.99,'D',IIf(Grade Between 60 And 62.99,'D-','F'))))))))))))) AS LetterGrade
FROM (((Students
INNER JOIN Student_Schedules
ON Students.StudentID=Student_Schedules.StudentID)
INNER JOIN Classes
ON Student_Schedules.ClassID=Classes.ClassID)
INNER JOIN Subjects
ON Classes.SubjectID=Subjects.SubjectID)
INNER JOIN Student_Class_Status
ON Student_Schedules.ClassStatus=Student_Class_Status.ClassStatus
WHERE (Student_Class_Status.ClassStatusDescription='Completed');


CREATE VIEW CH20_Class_Schedule_Calendar
AS 
SELECT ztblSemesterDays.SemesterNo, ztblSemesterDays.SemDate, Classes.StartTime, ztblSemesterDays.SemDayName, Subjects.SubjectCode, Subjects.SubjectName, Class_Rooms.BuildingCode, Class_Rooms.ClassRoomID
FROM ztblSemesterDays, (Subjects
INNER JOIN Classes
ON Subjects.SubjectID=Classes.SubjectID)
INNER JOIN Class_Rooms
ON Class_Rooms.ClassRoomID=Classes.ClassRoomID
WHERE Classes.SemesterNumber=ztblSemesterDays.SemesterNo And Classes.StartDate<=ztblSemesterDays.SemDate And (IIf(ztblSemesterDays.SemDayName='Monday' And Classes.MondaySchedule<>0,True,False)
OR IIf(ztblSemesterDays.SemDayName='Tuesday' And Classes.TuesdaySchedule<>0,True,False)
OR IIf(ztblSemesterDays.SemDayName='Wednesday' And Classes.WednesdaySchedule<>0,True,False)
OR IIf(ztblSemesterDays.SemDayName='Thursday' And Classes.ThursdaySchedule<>0,True,False)
OR IIf(ztblSemesterDays.SemDayName='Friday' And Classes.FridaySchedule<>0,True,False)
OR IIf(ztblSemesterDays.SemDayName='Saturday' And Classes.SaturdaySchedule<>0,True,False))
ORDER BY ztblSemesterDays.SemesterNo, ztblSemesterDays.SemDate, Subjects.SubjectCode, Class_Rooms.BuildingCode, Class_Rooms.ClassRoomID, Classes.StartTime;


CREATE VIEW CH20_English_Student_Quintiles
AS 
SELECT S1.SubjectID, S1.StudFirstName, S1.StudLastName, S1.ClassStatus, S1.Grade, S1.CategoryID, S1.SubjectName, S1.RankInCategory, StudCount.NumStudents, IIf(RankInCategory<=0.2*NumStudents,'First',IIf(RankInCategory<=0.4*NumStudents,'Second',IIf(RankInCategory<=0.6*NumStudents,'Third',IIf(RankInCategory<=0.8*NumStudents,'Fourth','Fifth')))) AS Quintile
FROM (SELECT Subjects.SubjectID, Students.StudFirstName, Students.StudLastName, Student_Schedules.ClassStatus, Student_Schedules.Grade, Subjects.CategoryID, Subjects.SubjectName, (SELECT Count(*)   FROM (Classes
INNER JOIN Student_Schedules AS SS2    
ON Classes.ClassID = SS2.ClassID)  
INNER JOIN Subjects As S3  
ON S3.SubjectID = Classes.SubjectID   WHERE S3.CategoryID = 'ENG'
AND SS2.Grade >= Student_Schedules.Grade) AS RankInCategory FROM Subjects
INNER JOIN (Classes
INNER JOIN (Students
INNER JOIN Student_Schedules
ON Students.StudentID=Student_Schedules.StudentID)
ON Classes.ClassID=Student_Schedules.ClassID)
ON Subjects.SubjectID=Classes.SubjectID WHERE Student_Schedules.ClassStatus=2 And Subjects.CategoryID='ENG')  AS S1, (SELECT Count(*) AS NumStudents FROM (Classes AS C2
INNER JOIN Student_Schedules AS SS3
ON C2.ClassID=SS3.ClassID)
INNER JOIN Subjects AS S2
ON S2.SubjectID=C2.SubjectID WHERE SS3.ClassStatus=2 And S2.CategoryID='ENG')  AS StudCount
ORDER BY S1.Grade DESC;


CREATE VIEW CH20_Staff_Proficiency_Ratings
AS 
SELECT StfRatings.StaffID, StfRatings.StfFirstName, StfRatings.StfLastName, StfRatings.Title, StfRatings.AvgRating, ztblProfRatings.ProfRatingDesc
FROM ztblProfRatings, (SELECT Staff.StaffID, Staff.StfFirstName, Staff.StfLastname, Faculty.Title, Avg(Faculty_Subjects.ProficiencyRating) AS AvgRating FROM (Staff
INNER JOIN Faculty
ON Staff.StaffID=Faculty.StaffID)
INNER JOIN Faculty_Subjects
ON Faculty.StaffID=Faculty_Subjects.StaffID GROUP BY Staff.StaffID, Staff.StfFirstName, Staff.StfLastname, Faculty.Title)  AS StfRatings
WHERE StfRatings.AvgRating BETWEEN ztblProfRatings.ProfRatingLow
AND ztblProfRatings.ProfRatingHigh;


CREATE VIEW CH20_Student_Crosstab_Gender_MaritalStatus
AS 
SELECT Students.StudState, Sum(Male*Married) AS MarriedMale, Sum(Male*Single) AS SingleMale, Sum(Male*Widowed) AS WidowedMale, Sum(Male*Divorced) AS DivorcedMale, Sum(Female*Married) AS MarriedFemale, Sum(Female*Single) AS SingleFemale, Sum(Female*Widowed) AS WidowedFemale, Sum(Female*Divorced) AS DivorcedFemale, Sum((Male*Married)+(Male*Single)+(Male*Widowed)+(Male*Divorced)) AS StateMaleTotal, Sum((Female*Married)+(Female*Single)+(Female*Widowed)+(Female*Divorced)) AS StateFemaleTotal, Sum(((Male*Married)+(Male*Single)+(Male*Widowed)+(Male*Divorced))+((Female*Married)+(Female*Single)+(Female*Widowed)+(Female*Divorced))) AS StateTotal
FROM (Students
INNER JOIN ztblMaritalStatusMatrix
ON Students.StudMaritalStatus=ztblMaritalStatusMatrix.MaritalStatus)
INNER JOIN ztblGenderMatrix
ON Students.StudGender=ztblGenderMatrix.Gender
GROUP BY Students.StudState;


CREATE VIEW CH20_Student_Mailing_Skip_2
AS 
SELECT ' ' AS StudFirstName, ' ' AS StudLastName, ' ' AS StudStreetAddress, ' ' AS StudCity, ' ' AS StudState, ' ' AS StudZipCode
FROM ztblSeqNumbers 
WHERE ztblSeqNumbers.Sequence <= 2
UNION ALL SELECT Students.StudFirstName, Students.StudLastName, Students.StudStreetAddress, Students.StudCity, Students.StudState, Students.StudZipCode
FROM Students
ORDER BY StudZipCode, StudLastName;


CREATE VIEW CH20_Students_Additional_Courses
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName, Subjects.SubjectID, Subjects.CategoryID, Subjects.SubjectCode, Subjects.SubjectName, Subjects.SubjectPreReq
FROM Students, Subjects
INNER JOIN Classes
ON Subjects.SubjectID=Classes.SubjectID
WHERE Subjects.SubjectID Not In  (SELECT Su2.SubjectID  FROM (Subjects AS Su2
INNER JOIN Classes 
ON Su2.SubjectID = Classes.SubjectID) 
INNER JOIN Student_Schedules 
ON Classes.ClassID = Student_Schedules.ClassID WHERE Student_Schedules.StudentID = Students.StudentID
AND Student_Schedules.ClassStatus IN (1,2))
ORDER BY Students.StudentID, Subjects.SubjectID;


CREATE VIEW CH20_Students_Classes_Letter_Grades
AS 
SELECT Students.StudentID, Students.StudFirstName, Students.StudLastName, Classes.ClassID, Classes.StartDate, Subjects.SubjectCode, Subjects.SubjectName, Student_Schedules.Grade, ztblLetterGrades.LetterGrade
FROM ztblLetterGrades, (((Students
INNER JOIN Student_Schedules
ON Students.StudentID=Student_Schedules.StudentID)
INNER JOIN Classes
ON Student_Schedules.ClassID=Classes.ClassID)
INNER JOIN Subjects
ON Classes.SubjectID=Subjects.SubjectID)
INNER JOIN Student_Class_Status
ON Student_Schedules.ClassStatus=Student_Class_Status.ClassStatus
WHERE (Student_Class_Status.ClassStatusDescription='Completed') And (Student_Schedules.Grade Between ztblLetterGrades.LowGradePoint And ztblLetterGrades.HighGradePoint);


 
