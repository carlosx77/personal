CREATE DATABASE SchoolSchedulingModify
GO

USE SchoolSchedulingModify
GO

CREATE TABLE Buildings (
	BuildingCode nvarchar (3) NOT NULL ,
	BuildingName nvarchar (25) NULL ,
	NumberOfFloors smallint NULL ,
	ElevatorAccess bit NOT NULL ,
	SiteParkingAvailable bit NOT NULL 
)
GO

CREATE TABLE Categories (
	CategoryID nvarchar (10) NOT NULL ,
	CategoryDescription nvarchar (75) NULL ,
	DepartmentID int NULL 
)
GO

CREATE TABLE Class_Rooms (
	ClassRoomID int IDENTITY (1, 1) NOT NULL ,
	BuildingCode nvarchar (3) NULL ,
	PhoneAvailable bit NOT NULL 
)
GO

CREATE TABLE Classes (
	ClassID int IDENTITY (1, 1) NOT NULL ,
	SubjectID int NULL ,
	ClassRoomID int NULL ,
	Credits tinyint NULL ,
        StartDate date NULL ,
	StartTime time NULL ,
	Duration smallint NULL ,
	MondaySchedule bit NOT NULL ,
	TuesdaySchedule bit NOT NULL ,
	WednesdaySchedule bit NOT NULL ,
	ThursdaySchedule bit NOT NULL ,
	FridaySchedule bit NOT NULL ,
	SaturdaySchedule bit NOT NULL 
)
GO

CREATE TABLE Departments (
	DepartmentID int IDENTITY (1, 1) NOT NULL ,
	DeptName nvarchar (50) NULL ,
	DeptChair int NULL 
)
GO

CREATE TABLE Faculty (
	StaffID int NOT NULL ,
	Title nvarchar (50) NULL ,
	Status nvarchar (12) NULL ,
	Tenured bit NOT NULL 
)
GO

CREATE TABLE Faculty_Categories (
	StaffID int NOT NULL ,
	CategoryID nvarchar (10) NOT NULL 
)
GO

CREATE TABLE Faculty_Classes (
	ClassID int NOT NULL ,
	StaffID int NOT NULL 
)
GO

CREATE TABLE Faculty_Subjects (
	StaffID int NOT NULL ,
	SubjectID int NOT NULL ,
	ProficiencyRating real NULL 
)
GO

CREATE TABLE Majors (
        MajorID int NOT NULL ,
        Major nvarchar (20) NULL 
        )
GO

CREATE TABLE Staff (
	StaffID int IDENTITY (1, 1) NOT NULL ,
	StfFirstName nvarchar (25) NULL ,
	StfLastname nvarchar (25) NULL ,
	StfStreetAddress nvarchar (50) NULL ,
	StfCity nvarchar (30) NULL ,
	StfState nvarchar (2) NULL ,
	StfZipCode nvarchar (5) NULL ,
	StfAreaCode nvarchar (5) NULL ,
	StfPhoneNumber nvarchar (8) NULL ,
	Salary money NULL ,
	DateHired date NULL ,
	Position nvarchar (50) NULL 
)
GO

CREATE TABLE Student_Class_Status (
	ClassStatus int IDENTITY (1, 1) NOT NULL ,
	ClassStatusDescription nvarchar (50) NULL 
)
GO

CREATE TABLE Student_Schedules (
	StudentID int NOT NULL ,
	ClassID int NOT NULL ,
	ClassStatus int NULL ,
	Grade real NULL 
)
GO

CREATE TABLE Students (
	StudentID int IDENTITY (1, 1) NOT NULL ,
	StudFirstName nvarchar (25) NULL ,
	StudLastName nvarchar (25) NULL ,
	StudStreetAddress nvarchar (50) NULL ,
	StudCity nvarchar (30) NULL ,
	StudState nvarchar (2) NULL ,
	StudZipCode nvarchar (5) NULL ,
	StudAreaCode nvarchar (5) NULL ,
	StudPhoneNumber nvarchar (8) NULL ,
	StudGPA float NULL ,
        StudMajor int NULL 
)
GO

CREATE TABLE Subjects (
	SubjectID int IDENTITY (1, 1) NOT NULL ,
	CategoryID nvarchar (10) NULL ,
	SubjectCode nvarchar (8) NULL ,
	SubjectName nvarchar (50) NULL ,
    SubjectPreReq nvarchar (8) NULL ,
	SubjectDescription ntext NULL 
) 
GO

ALTER TABLE Buildings ADD 
	CONSTRAINT Elevator_Access_Default DEFAULT (0) FOR ElevatorAccess,
	CONSTRAINT Site_Parking_Available_Default DEFAULT (0) FOR SiteParkingAvailable,
	CONSTRAINT Buildings_PK PRIMARY KEY   
	(
		BuildingCode
	)  
GO

 CREATE  INDEX NumberOfFloors ON Buildings(NumberOfFloors)
GO

ALTER TABLE Categories ADD 
	CONSTRAINT Cat_Department_ID_Default DEFAULT (0) FOR DepartmentID,
	CONSTRAINT Categories_PK PRIMARY KEY   
	(
		CategoryID
	)  
GO

 CREATE  INDEX DepartmentID ON Categories(DepartmentID)
GO

ALTER TABLE Class_Rooms ADD 
	CONSTRAINT Phone_Available_Default DEFAULT (0) FOR PhoneAvailable,
	CONSTRAINT Class_Rooms_PK PRIMARY KEY   
	(
		ClassRoomID
	)  
GO

 CREATE  INDEX BuildingNumber ON Class_Rooms(BuildingCode)
GO

ALTER TABLE Classes ADD 
	CONSTRAINT C_Subject_ID_Default DEFAULT (0) FOR SubjectID,
	CONSTRAINT C_Class_Room_ID_Default DEFAULT (0) FOR ClassRoomID,
	CONSTRAINT Creidts_Default DEFAULT (0) FOR Credits,
	CONSTRAINT Duration_Default DEFAULT (0) FOR Duration,
	CONSTRAINT Monday_Schedule_Default DEFAULT (0) FOR MondaySchedule,
	CONSTRAINT Tuesday_Schedule_Default DEFAULT (0) FOR TuesdaySchedule,
	CONSTRAINT Wednesday_Schedule_Default DEFAULT (0) FOR WednesdaySchedule,
	CONSTRAINT Thursday_Schedule_Default DEFAULT (0) FOR ThursdaySchedule,
	CONSTRAINT Friday_Schedule_Default DEFAULT (0) FOR FridaySchedule,
	CONSTRAINT Saturday_Schedule_Default DEFAULT (0) FOR SaturdaySchedule,
	CONSTRAINT Classes_PK PRIMARY KEY   
	(
		ClassID
	)  
GO

 CREATE  INDEX SubjectID ON Classes(SubjectID)
GO

 CREATE  INDEX ClassRoomID ON Classes(ClassRoomID)
GO

ALTER TABLE Departments ADD 
	CONSTRAINT Dept_Chair_Default DEFAULT (0) FOR DeptChair,
	CONSTRAINT Departments_PK PRIMARY KEY  
	(
		DepartmentID
	)  
GO

 CREATE  INDEX StaffDepartments ON Departments(DeptChair)
GO

ALTER TABLE Faculty ADD 
	CONSTRAINT Tenured_Default DEFAULT (0) FOR Tenured,
	CONSTRAINT Faculty_PK PRIMARY KEY   
	(
		StaffID
	)  
GO

ALTER TABLE Faculty_Categories ADD 
	CONSTRAINT FC_Category_ID_Default DEFAULT ('ACC') FOR CategoryID,
	CONSTRAINT Faculty_Categories_PK PRIMARY KEY   
	(
		StaffID,
		CategoryID
	)  
GO

 CREATE  INDEX CategoryIDFaculty_Categories ON Faculty_Categories(CategoryID)
GO

 CREATE  INDEX StaffIDFaculty_Categories ON Faculty_Categories(StaffID)
GO

ALTER TABLE Faculty_Classes ADD 
	CONSTRAINT Faculty_Classes_PK PRIMARY KEY  
	(
		ClassID,
		StaffID
	)  
GO

 CREATE  INDEX ClassesFaculty_Classes ON Faculty_Classes(ClassID)
GO

 CREATE  INDEX StaffFaculty_Classes ON Faculty_Classes(StaffID)
GO

ALTER TABLE Faculty_Subjects ADD 
	CONSTRAINT FS_Staff_ID_Default DEFAULT (0) FOR StaffID,
	CONSTRAINT FS_Subject_ID_Default DEFAULT (0) FOR SubjectID,
	CONSTRAINT Proficiency_Rating_Default DEFAULT (0) FOR ProficiencyRating,
	CONSTRAINT Faculty_Subjects_PK PRIMARY KEY   
	(
		StaffID,
		SubjectID
	)  
GO

 CREATE  INDEX StaffIDFaculty_Subjects ON Faculty_Subjects(StaffID)
GO

 CREATE  INDEX SubjectsFaculty_Subjects ON Faculty_Subjects(SubjectID)
GO

ALTER TABLE Staff ADD 
	CONSTRAINT taff_PK PRIMARY KEY  
	(
		StaffID
	)  
GO

 CREATE  INDEX StaffZipCode ON Staff(StfZipCode)
GO

 CREATE  INDEX StudAreaCode ON Staff(StfAreaCode)
GO

ALTER TABLE Majors ADD
        CONSTRAINT Majors_PK PRIMARY KEY
        (
               MajorID
        )
GO

ALTER TABLE Student_Class_Status ADD 
	CONSTRAINT Student_Class_Status_PK PRIMARY KEY  
	(
		ClassStatus
	)  
GO

ALTER TABLE Student_Schedules ADD 
	CONSTRAINT SS_Class_Status_Default DEFAULT (0) FOR ClassStatus,
	CONSTRAINT Grade_Default DEFAULT (0) FOR Grade,
	CONSTRAINT Student_Schedules_PK PRIMARY KEY   
	(
		StudentID,
		ClassID
	)  
GO

 CREATE  INDEX ClassesStudent_Schedules ON Student_Schedules(ClassID)
GO

 CREATE  INDEX Student_Class_StatusStudent_Schedules ON Student_Schedules(ClassStatus)
GO

 CREATE  INDEX StudentsStudent_Schedules ON Student_Schedules(StudentID)
GO

ALTER TABLE Students ADD 
	CONSTRAINT StudGPA_Default DEFAULT (0) FOR StudGPA,
	CONSTRAINT Students_PK PRIMARY KEY  
	(
		StudentID
	)  
GO

 CREATE  INDEX StudAreaCode ON Students(StudAreaCode)
GO

 CREATE  INDEX StudZipCode ON Students(StudZipCode)
GO

 CREATE  INDEX StudMajor ON Students(StudMajor)
GO

ALTER TABLE Subjects ADD 
	CONSTRAINT Subjects_PK PRIMARY KEY   
	(
		SubjectID
	)  
GO

 CREATE  INDEX CategoryID ON Subjects(CategoryID)
GO

 CREATE  UNIQUE  INDEX SubjectCode ON Subjects(SubjectCode)
GO

 CREATE  INDEX SubjPreReq ON Subjects(SubjectPreReq)
GO

ALTER TABLE Categories ADD 
	CONSTRAINT Categories_FK00 FOREIGN KEY 
	(
		DepartmentID
	) REFERENCES Departments (
		DepartmentID
	)
GO

ALTER TABLE Class_Rooms ADD 
	CONSTRAINT Class_Rooms_FK00 FOREIGN KEY 
	(
		BuildingCode
	) REFERENCES Buildings (
		BuildingCode
	)
GO

ALTER TABLE Classes ADD 
	CONSTRAINT Classes_FK00 FOREIGN KEY 
	(
		ClassRoomID
	) REFERENCES Class_Rooms (
		ClassRoomID
	),
	CONSTRAINT Classes_FK01 FOREIGN KEY 
	(
		SubjectID
	) REFERENCES Subjects (
		SubjectID
	)
GO

ALTER TABLE Departments ADD 
	CONSTRAINT Departments_FK00 FOREIGN KEY 
	(
		DeptChair
	) REFERENCES Staff (
		StaffID
	)
GO

ALTER TABLE Faculty ADD 
	CONSTRAINT Faculty_FK00 FOREIGN KEY 
	(
		StaffID
	) REFERENCES Staff (
		StaffID
	)
GO

ALTER TABLE Faculty_Categories ADD 
	CONSTRAINT Faculty_Categories_FK00 FOREIGN KEY 
	(
		CategoryID
	) REFERENCES Categories (
		CategoryID
	),
	CONSTRAINT Faculty_Categories_FK01 FOREIGN KEY 
	(
		StaffID
	) REFERENCES Faculty (
		StaffID
	)
GO

ALTER TABLE Faculty_Classes ADD 
	CONSTRAINT Faculty_Classes_FK00 FOREIGN KEY 
	(
		ClassID
	) REFERENCES Classes (
		ClassID
	),
	CONSTRAINT Faculty_Classes_FK01 FOREIGN KEY 
	(
		StaffID
	) REFERENCES Staff (
		StaffID
	),
        CONSTRAINT Faculty_CLasses_FK02 FOREIGN KEY
	(
		StaffID
	) REFERENCES Faculty (
		StaffID
	)
GO

ALTER TABLE Faculty_Subjects ADD 
	CONSTRAINT Faculty_Subjects_FK00 FOREIGN KEY 
	(
		StaffID
	) REFERENCES Faculty (
		StaffID
	),
	CONSTRAINT Faculty_Subjects_FK01 FOREIGN KEY 
	(
		SubjectID
	) REFERENCES Subjects (
		SubjectID
	)
GO

ALTER TABLE Students ADD
        CONSTRAINT Students_FK00 FOREIGN KEY
        (
                StudMajor
        ) REFERENCES Majors (
                MajorID
        )
GO

ALTER TABLE Student_Schedules ADD 
	CONSTRAINT Student_Schedules_FK00 FOREIGN KEY 
	(
		ClassID
	) REFERENCES Classes (
		ClassID
	),
	CONSTRAINT Student_Schedules_FK01 FOREIGN KEY 
	(
		ClassStatus
	) REFERENCES Student_Class_Status (
		ClassStatus
	),
	CONSTRAINT Student_Schedules_FK02 FOREIGN KEY 
	(
		StudentID
	) REFERENCES Students (
		StudentID
	)
GO

ALTER TABLE Subjects ADD 
	CONSTRAINT Subjects_FK00 FOREIGN KEY 
	(
		CategoryID
	) REFERENCES Categories (
		CategoryID
	),
        CONSTRAINT Subjects_FK01 FOREIGN KEY
	(
		SubjectPreReq
	) REFERENCES Subjects (
		SubjectCode
	)
GO

