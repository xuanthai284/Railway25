-- use testing_system_assignment_2;

-- QUESTION 1: TẠO VIEW CÓ CHỨA DANH SÁCH NHÂN VIÊN THUỘC PHÒNG A

DROP VIEW IF EXISTS DS_NV_PHONG_A;

CREATE VIEW DS_NV_PHONG_A AS (
	SELECT	 	dep.DepartmentName as Phong, acc.AccountID, acc.FullName as 'Ten Nhan Vien'
		FROM 		department dep
			INNER JOIN		account1 acc
			ON acc.DepartmentID = dep.DepartmentID
				WHERE dep.DepartmentName = 'Phong A'
);
SELECT * FROM DS_NV_PHONG_A;

-- CTE
WITH danhsach AS (
	SELECT	 	dep.DepartmentName as Phong, acc.AccountID, acc.FullName as 'Ten Nhan Vien'
		FROM 		department dep
			INNER JOIN		account1 acc
			ON acc.DepartmentID = dep.DepartmentID
				WHERE dep.DepartmentName = 'Phong A'
	)
SELECT * FROM danhsach;

-- QUESTION 2: TẠO VIEW CÓ CHỨA THÔNG TIN CÁC ACCOUNT THAM GIA VÀO NHIỀU GROUP NHẤT

DROP VIEW IF EXISTS ThongTin;

CREATE VIEW Thongtin AS (
	SELECT	 acc.AccountID, acc.UserName, acc.FullName, count(gro.AccountID) as 'So luong nhom tham gia'
		FROM 	groupaccount as gro
			INNER JOIN		account1 acc
			ON acc.AccountID = gro.AccountID
					GROUP BY gro.AccountID
					HAVING count(gro.AccountID) = (SELECT max(sl) FROM(SELECT count(gr.AccountID) as sl FROM groupaccount as gr GROUP BY gr.AccountID) as txt)
);
SELECT * FROM Thongtin;

-- CTE
WITH txt AS (
SELECT	 acc.AccountID, acc.UserName, acc.FullName, count(gro.AccountID) as 'So luong nhom tham gia'
	FROM 	groupaccount as gro
		INNER JOIN		account1 acc
		ON acc.AccountID = gro.AccountID
			GROUP BY gro.AccountID
			HAVING count(gro.AccountID) = (SELECT max(sl) FROM(SELECT count(gr.AccountID) as sl FROM groupaccount as gr GROUP BY gr.AccountID) as txt)
)
SELECT * FROM txt;

-- QUESTION 3: TẠO VIEW CÓ CHỨA CÂU HỎI CÓ NHỮNG CONTENT QUÁ DÀI (CONTENT QUÁ 300 TỪ ĐƯỢC COI LÀ QUÁ DÀI) VÀ XÓA NÓ ĐI

DROP VIEW IF EXISTS Contentquadai;

CREATE VIEW contentquadai AS
	SELECT *
		FROM Question
			WHERE LENGTH(Content) > 2;
SELECT *FROM contentquadai;
DROP VIEW contentquadai;

-- QUESTION 4: TẠO VIEW CÓ CHỨA DANH SÁCH CÁC PHÒNG BAN CÓ NHIỀU NHÂN VIÊN NHẤT

DROP VIEW IF EXISTS maxnv;

CREATE VIEW maxnv AS (
	SELECT dep.DepartmentName, count(acc.DepartmentID) as sl
		FROM department as dep
			INNER JOIN account1 as acc
			ON acc.DepartmentID = dep.DepartmentID
				GROUP BY acc.DepartmentID
				HAVING count(acc.DepartmentID) = (SELECT max(sl) FROM(SELECT count(acc.DepartmentID) AS sl FROM account1 AS acc GROUP BY acc.DepartmentID) AS txt)
                );
SELECT * FROM maxnv;

-- QUESTION 5: TẠO VIEW CÓ CHỨA TẤT CÁC CÁC CÂU HỎI DO USER HỌ NGUYỄN TẠO    

DROP VIEW IF EXISTS content_Bui;
CREATE VIEW content_Bui AS (
	SELECT 			que.QuestionID,Que.Content,acc.UserName,acc.fullName
		FROM 			question as que
			INNER JOIN 		account1 acc
			ON que.CreatorID = acc.AccountID 
					WHERE acc.fullName LIKE 'Bui%'
);   
SELECT * FROM content_Bui;