DROP DATABASE IF EXISTS Testing_System_Assignment_2;
CREATE DATABASE Testing_System_Assignment_2;
USE Testing_System_Assignment_2;

				           -- TAO BANG DEPARTMENT -- PHONG BAN

CREATE TABLE Department (
	DepartmentID		INT AUTO_INCREMENT PRIMARY KEY, 
	DepartmentName		VARCHAR(50) NOT NULL
);

								-- TAO BANG POSTISON -- CHUC VU
CREATE TABLE POSITION1 (
	PositionID			INT AUTO_INCREMENT PRIMARY KEY,
	PositionName		ENUM ('DEV','Test','Scrum Master','PM') NOT NULL
);

								-- TAO BANG ACCOUNT -- THANH VIEN
CREATE TABLE Account1 (
	AccountID			INT AUTO_INCREMENT PRIMARY KEY,
	Email				VARCHAR(50) UNIQUE,
	UserName 			VARCHAR(50) UNIQUE NOT NULL,
	FullName 			VARCHAR(50) NOT NULL,
	DepartmentID		INT,
	PositionID			INT NOT NULL,
	 CreateDate			DATE,
CONSTRAINT lien_ket_1 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
CONSTRAINT lien_ket_2 FOREIGN KEY (PositionID) REFERENCES Position1(PositionID)
);
            
								-- TAO BANG GROUP1 -- NHOM
CREATE TABLE Group1	(
	GroupID				INT AUTO_INCREMENT PRIMARY KEY,
	GroupName			VARCHAR(50) NOT NULL,
	CreatorID			INT NOT NULL,
	CreateDate			DATETIME DEFAULT NOW(),
    CONSTRAINT lien_ket_10 FOREIGN KEY (CreatorID) REFERENCES Account1(AccountID)
);

 								-- TAO BANG GROUP_ACCOUNT -- KIEU CAU HOI
CREATE TABLE GroupAccount(
	GroupID				INT  NOT NULL,	
	AccountID			INT  NOT NULL,
	JoinDate			DATETIME DEFAULT NOW(),
CONSTRAINT lien_ket_3 FOREIGN KEY (GroupID) REFERENCES  Group1(GroupID),
CONSTRAINT lien_ket_4 FOREIGN KEY (AccountID) REFERENCES  Account1(AccountID)
);

								-- TAO BANG TYPEQUESTION -- KIEU CAU HOI
CREATE TABLE TypeQuestion(
	TypeID				INT AUTO_INCREMENT PRIMARY KEY,
	TypeName			ENUM ('Essay','Multiple-Choice' )
);

								-- TAO BANG CATEGORYQUESTION -- CHU DE CAU HOI
CREATE TABLE CategoryQuestion(
	CategoryID			INT AUTO_INCREMENT PRIMARY KEY,
	CategoryName		VARCHAR(50) NOT NULL
);

									-- TAO BANG QUESTION -- CAU HOI
CREATE TABLE Question(
	QuestionID			INT AUTO_INCREMENT PRIMARY KEY,
	Content				VARCHAR(100),
	CategoryID			INT,
	TypeID				INT,
	CreatorID			INT,
	CreateDate			DATETIME DEFAULT NOW(),
CONSTRAINT lien_ket_5 FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
CONSTRAINT lien_ket_6 FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID)
);

								-- TAO BANG ANSWER -- CAU TRA LOI
CREATE TABLE Answer(
	AnswerID			INT AUTO_INCREMENT PRIMARY KEY,
	Content				VARCHAR(100) DEFAULT ('a'),
	QuestionID			INT,
	IsCorrect			ENUM('Dung','Sai'),
CONSTRAINT lien_ket_7 FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

									-- TAO BANG EXAM -- DE THI
CREATE TABLE Exam(
	ExamID				INT AUTO_INCREMENT PRIMARY KEY,	
	Code1				ENUM('code c','code java','code c++'),
	Title				VARCHAR(50),
	CategoryID			INT NOT NULL,
	Duration			INT,
	CreatorID			INT NOT NULL,
	CreateDate			DATE DEFAULT ('2021-10-28'),
CONSTRAINT lien_ket_11 FOREIGN KEY (CreatorID) REFERENCES Account1(AccountID)
);

							    -- TAO BANG EXAMQUESTION -- CAU HOI DE THI
CREATE TABLE ExamQuestion(
	ExamID				INT NOT NULL,
	QuestionID			INT NOT NULL,
CONSTRAINT lien_ket_8 FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
CONSTRAINT lien_ket_9 FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

-- ALTER TABLE Account1 ADD CONSTRAINT lien_ket_1 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);
-- ALTER TABLE Account1 ADD CONSTRAINT lien_ket_2 FOREIGN KEY (PositionID) REFERENCES Position1(PositionID);
-- ALTER TABLE GroupAccount ADD CONSTRAINT lien_ket_3 FOREIGN KEY (GroupID) REFERENCES  Group1(GroupID);
-- ALTER TABLE GroupAccount ADD CONSTRAINT lien_ket_4 FOREIGN KEY (AccountID) REFERENCES  Account1(AccountID);
-- ALTER TABLE Question ADD CONSTRAINT lien_ket_5 FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID);
-- ALTER TABLE Question ADD CONSTRAINT lien_ket_6 FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID);
-- ALTER TABLE Answer ADD CONSTRAINT lien_ket_7 FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID);
-- ALTER TABLE ExamQuestion ADD CONSTRAINT lien_ket_8 FOREIGN KEY (ExamID) REFERENCES Exam(ExamID);
-- ALTER TABLE ExamQuestion ADD CONSTRAINT lien_ket_9 FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID);


-- -----------------------------------------------------------------------------------------------------------------
--    CHEN DU LIEU
INSERT INTO Department(DepartmentName)  VALUES 	        ('Phong A'),
														('Phong B'),
														('Phong C'), 
														('Phong D'), 
														('Phong E' );
                                                        
                                                            -- SELECT * FROM Department --	
                                                            
INSERT INTO Position1 (PositionName)
		VALUES               (1),(3),(4),(2);
    -- SELECT * FROM Position1;

INSERT INTO Account1  
				(	Email,						UserName,				FullName,			DepartmentID,			PositionID,                 CreateDate)
          VALUES 
				('jindo1@gmail.com',			 'jindo1',			    'Bui Nhu Lac', 			    1, 						2,                   '2021-2-12'),
                ('jindo2@gmail.com',		     'jindo2',              'Le Nhu Thanh', 			2, 						1,                   '2021-7-27'),
                ('jindo3@gmail.com',			 'jindo3',		        'Tran Nhu Nhong', 			5, 						2,                   '2021-4-28'),
                ('jindo4@gmail.com',             'jindo4',			    'Mai Roi Tinh', 			1, 						1,                   '2021-11-19'),
                ('jindo5@gmail.com',			 'jindo5',		        'Huan Rose', 				5, 						3,                   '2019-6-9');
-- SELECT * FROM Account1;

INSERT INTO Group1(GroupName,CreatorID)          VALUES 	    ('Viet Nam',2),
																('Nhat Ban',1),
																('Trung Quoc',2),
																('Han Quoc',3),
																('Thai Lan',4),															('Ha Lan',4);

-- SELECT * FROM GROUP1;

INSERT INTO GroupAccount(GroupID,		AccountID)
					VALUES 		
						 (	1,				1  ),			
                         (	2,				2  ),			
                         (	3,				1  ),			
                         (	4,				2  ),			
                         (	1,				4  );			
  -- SELECT * FROM  GroupAccount;                
  
  INSERT INTO TypeQuestion(TypeName)  VALUES 	(1),(2),(1),(2),(1),
											(1),(2),(1),(2),(1);
-- SELECT * FROM TypeQuestion;

INSERT INTO CategoryQuestion(CategoryName)
						VALUES 				
							 ('Java'),('.NET'),('SQL'),('Postman'),('Ruby');
-- SELECT * FROM CategoryQuestion;

INSERT INTO Question(		Content,	CategoryID,		TypeID,		CreatorID)
VALUES 				
					(       'a',			1,				1,			1),
                    (       'b',			2,			    2,			2),
                    (       'c',		    3,				4,			3),
                    (       'd',			4,				3,          4),
                    (       'e',			1,				1,          5);
 -- select * from Question;                  
 INSERT INTO Exam(Code1,		Title,		CategoryID,				Duration,			CreatorID		)
VALUES 			
				( 1,	     'a', 		    3, 					    3, 				   1 			),
				( 2,	     'b', 			1, 					    2, 				   2 			),
                ( 3,         'c', 		    5,                      1, 				   4			);
                
	--  SELECT * FROM Exam;
    
    INSERT INTO ExamQuestion(ExamID,QuestionID)    VALUES      (1,3),(1,2),(2,3),(2,1);
 -- SELECT * FROM ExamQuestion;

