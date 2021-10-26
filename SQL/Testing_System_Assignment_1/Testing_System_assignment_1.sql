drop database if exists testing_system;
create database testing_system;
use testing_system;

-- tao bang Department
create table Department (
DepartmentID int primary key auto_increment,
DepartmentName varchar (50)
);

-- tao bang Position
create table Position (
PositionID int primary key auto_increment,
PositionName varchar (50)
);

-- tao bang Account
create table Account (
AccountID int primary key auto_increment,
Email varchar (50),
Username varchar (50),
Fullname varchar (50),
DepartmentID int,
PositionID int,
CreateDate date
);

-- tao bang Group
create table ‘group’ (
GroupID int,
GroupName varchar (50),
CreatorID int,
CreateDate date
);

-- tao bang GroupAccount
create table GroupAccount (
GroupID int primary key auto_increment,
AccountID int,
JoinDate date
);

-- tao bang TypeQuestion
create table TypeQuestion (
TypeID int primary key auto_increment,
TypeName varchar (50)
);

-- tao bang CategoryQuestion
create table CategoryQuestion (
CategoryID int primary key auto_increment,
CategoryName varchar (50)
);

-- tao bang Question
create table Question (
QuestionID int primary key auto_increment,
Content varchar (50),
CategoryID int,
TypeID int,
CreatorID int,
CreateDate date
);

-- tao bang Answer
create table Answer (
AnswerID int primary key auto_increment,
Content varchar (50),
QuestionID int,
isCorrect varchar(10)
);

-- tao bang Exam
create table Exam (
ExamID int primary key auto_increment,
code int,
Title varchar(50),
CategoryID int,
Duration timestamp,
CreatorID int,
CreatorDate date
);

-- tao bang ExamQuestion
create table ExamQuestion (
ExamID int,
QuestionID int
);

