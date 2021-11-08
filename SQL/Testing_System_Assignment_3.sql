 use testing_system_assignment_2;

-- QUESTION 2 LAY RA TAT CA CAC PHONG BAN

SELECT DepartmentName
FROM department;

-- QUESTION 3 LAY RA ID CUA PHONG BAN A

SELECT DepartmentID
FROM department
WHERE DepartmentName = 'Phong A';

-- QUESTION 4 LAY RA THONG TIN ACCOUNT CO FULLNAME DAI NHAT

SELECT *
FROM account1
WHERE length(FullName) = (SELECT max(length(FullName))FROM account1);

-- QUESTION 5 LAY RA THONG TIN PHONG BAN CO FULLNAME DAI NHAT VA THUOC PHONG BAN ID=3

SELECT *
FROM account1
WHERE length(FullName) = (SELECT max(length(FullName))FROM account1)
AND DepartmentID = 3;

-- QUESTION 6 LAY RA TEN GROUP DA THAM GIA TRUOC NGAY 2019/12/10

SELECT GroupName
FROM group1
WHERE CreatDate < '2019-11-10';
 
 -- QUESTION 7 LAY RA ID CUA QUESTION CO >= 4 CAU TRA LOI
 
 SELECT QuestionID, Count(QuestionID) As Soluong, AnswerID
 FROM Answer
 GROUP BY QuestionID
 HAVING count(QuestionID) >= 4;
 
 -- QUESTION 8 LAY RA MA DE THI CO THOI GIAN >= 60 VA TAO TRUOC 2019/12/20
 
 SELECT code1
 FROM exam
 WHERE Duration >= 60 AND CreatDate < '2019-12-20';
 
 -- QUESTION 9 LAY 5 GOURP DUOC TAO GAN NHAT VA ID
 
SELECT GroupID, CreatDate
FROM group1
ORDER BY CreateDate DESC
LIMIT 5;
 
 -- QUESTION 10 DEM SO NHAN VIEN THUOC DEPARTMENT CO ID=2 VA DO LA NHUNG ACCOUNT NAO
 
 SELECT DepartmentID, count(AccountID) As soluong, Group_concat(AccountID) as Account_id
 FROM account1
 WHERE DepartmentID = 2;
 
 -- QUESTION 11 LAY RA NHAN VIEN BAT DAU BANG CHU T KET THUC LA CHU G
 
 SELECT FullName
 FROM account1
 WHERE FullName LIKE 'T%g';
 
 -- QUESTION 12 XOA TAT CA EXAM DUOC TSO TRUOC NGAY 2019/12/20
 
 DELETE
 FROM exam
 WHERE CreateDate < '2019-12-20';
 
 -- QUESTION 13 XOA TAT CA CAC QUESTION BAT DAU LA CAU HOI
 
DELETE
FROM question
WHERE Content LIKE 'cau hoi%';
 
 -- QUESTION 14 UPDATE THONG TIN CUA ACCOUNT CO ID = 5 THANH TEN "Nguyen Ba Loc" VA EMAIL  THÀNH LOC.NGUYENBA@VTI.COM.
 
 UPDATE account1
 SET FullName = 'Nguyen Ba Loc' , email = 'loc.nguyenba@vti.com.vn'
 WHERE AccountID = 5;
 
 -- QUESTION 15 UPDATE ACCOUNT CO ID = 5 THUOC GROUPID = 4

UPDATE groupaccount
SET AccountID = 5
WHERE GroupID = 4;