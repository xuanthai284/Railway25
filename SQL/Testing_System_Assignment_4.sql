use testing_system_assignment_2;

-- QUESTION 1 VIẾT LỆNH ĐỂ LẤY RA DANH SÁCH NHÂN VIÊN VÀ THÔNG TIN PHÒNG BAN CỦA HỌ

SELECT acc.fullname as tennv, dep.departmentName as phong_ban
	FROM account1 acc
		INNER JOIN department dep
			ON acc.DepartmentID = dep.DepartmentID
			ORDER BY phong_ban ;

-- QUESTION 2: VIẾT LỆNH ĐỂ LẤY RA THÔNG TIN CÁC ACCOUNT ĐƯỢC TẠO SAU NGÀY 20/12/2010

SELECT *
	FROM account1
		WHERE CreateDate > '2010/12/20';

-- QUESTION 3: VIẾT LỆNH ĐỂ LẤY RA TẤT CẢ CÁC DEVELOPER

SELECT acc.FullName as 'Ten nhan vien', pos.PositionName as 'Chuc vu'
	FROM account1 acc
		INNER JOIN position1 pos
			ON acc.PositionID = pos.PositionID
			WHERE pos.PositionName = 'DEV';

-- QUESTION 4: VIẾT LỆNH ĐỂ LẤY RA DANH SÁCH CÁC PHÒNG BAN CÓ >1 NHÂN VIÊN

SELECT dep.DepartmentName, count(acc.DepartmentID) as 'so luong nv'
	FROM account1 acc
		INNER JOIN department dep
			ON acc.DepartmentID = dep.DepartmentID
				GROUP BY acc.DepartmentID
				HAVING count(acc.DepartmentID) > 1;
-- QUESTION 5: VIẾT LỆNH ĐỂ LẤY RA DANH SÁCH CÂU HỎI ĐƯỢC SỬ DỤNG TRONG ĐỀ THI NHIỀU NHẤT

SELECT que.Content,count(exa.QuestionID) as 'so luong cau hoi'
	FROM examquestion exa
		INNER JOIN question que
			ON exa.QuestionID = que.QuestionID
				GROUP BY exa.QuestionID
				HAVING count(exa.QuestionID)  = (SELECT MAX(sl) FROM (SELECT count(ex.QuestionID) as sl FROM examquestion as ex GROUP BY ex.QuestionID) as so_luong);
	 -- -------------------
 WITH sl1 as (
 SELECT count(ex.QuestionID) as sl2
	 FROM examquestion as ex
		GROUP BY ex.QuestionID
 )
SELECT que.Content,count(exa.QuestionID) as 'so luong cau hoi'
	FROM examquestion exa
		INNER JOIN question que
			ON exa.QuestionID = que.QuestionID
				GROUP BY exa.QuestionID
				HAVING count(exa.QuestionID)  = (SELECT MAX(sl2) FROM sl1);
 -- QUESTION 6: THÔNG KÊ MỖI CATEGORY QUESTION ĐƯỢC SỬ DỤNG TRONG BAO NHIÊU QUESTION
 
 SELECT cat.CategoryName, count(que.CategoryID) as 'so luong'
	 FROM categoryquestion as cat
		 LEFT JOIN question as que
			 ON cat.CategoryID = que.CategoryID
			 GROUP BY cat.CategoryID;
 
 -- QUESTION 7: THÔNG KÊ MỖI QUESTION ĐƯỢC SỬ DỤNG TRONG BAO NHIÊU EXAM
 
 SELECT que.Content, count(exa.QuestionID) as 'so luong'
	 FROM question as que
		 LEFT JOIN examquestion as exa
			 ON que.QuestionID = exa.QuestionID
			 GROUP BY que.QuestionID;
	 
 -- QUESTION 8: LẤY RA QUESTION CÓ NHIỀU CÂU TRẢ LỜI NHẤT
 
 SELECT que.Content, count(ans.QuestionID) as 'so luong'
	 FROM answer as ans
		 INNER JOIN question as que
			 ON que.QuestionID = ans.QuestionID
			 GROUP BY ans.QuestionID
			 HAVING count(ans.QuestionID) = (SELECT max(so) FROM(SELECT count(an.QuestionID) as so FROM answer as an GROUP BY an.QuestionID) as txt);
 
 -- QUESTION 9: THỐNG KÊ SỐ LƯỢNG ACCOUNT TRONG MỖI GROUP
 
 SELECT gro.GroupName, count(groa.GroupID) as 'so luong'
	 FROM group1 as gro
		 LEFT JOIN groupaccount as groa
			 ON gro.GroupID = groa.GroupID
			 GROUP BY gro.GroupID;
 
 -- QUESTION 10: TÌM CHỨC VỤ CÓ ÍT NGƯỜI NHẤT
 
 SELECT pos.PositionName, count(acc.PositionID) as 'so nguoi'
	 FROM account1 as acc
		 INNER JOIN position1 as pos
			 ON pos.PositionID = acc.PositionID
			 GROUP BY acc.PositionID
			 HAVING count(acc.PositionID) = (SELECT min(tx) FROM(SELECT count(ac.PositionID) as tx FROM account1 as ac GROUP BY ac.PositionID) as txt);
 
 -- QUESTION 11: THỐNG KÊ MỖI PHÒNG BAN CÓ BAO NHIÊU DEV, TEST, SCRUM MASTER, PM
 
 SELECT dep.DepartmentName, pos.PositionName,count(Acc.PositionID) as 'so luong'
	 FROM account1 as acc
		 INNER JOIN department as dep
			ON acc.DepartmentID = dep.DepartmentID
		 INNER JOIN position1 as pos
			ON acc.PositionID = pos.PositionID
			GROUP BY dep.DepartmentID, pos.PositionID; 

-- QUESTION 12: LẤY THÔNG TIN CHI TIẾT CỦA CÂU HỎI BAO GỒM: THÔNG TIN CƠ BẢN CỦA QUESTION, LOẠI CÂU HỎI, AI LÀ NGƯỜI TẠO RA CÂU HỎI, CÂU TRẢ LỜI LÀ GÌ, ...

SELECT Que.QuestionID, Que.Content, Acc.FullName, TQ.TypeName AS Type_of_Answer, ANS.Content 
FROM Question Que
	INNER JOIN Categoryquestion AS CQ 
			   ON Que.CategoryID = CQ.CategoryID
	INNER JOIN TypeQuestion TQ 
			   ON Que.TypeID = TQ.TypeID
	INNER JOIN account1 Acc 
			   ON Acc.AccountID = Que.CreatorID
	INNER JOIN Answer AS ANS 
				ON Que.QuestionID = ANS.QuestionID
 ORDER BY Que.QuestionID ASC;

-- QUESTION 13: LẤY RA SỐ LƯỢNG CÂU HỎI CỦA MỖI LOẠI TỰ LUẬN HAY TRẮC NGHIỆM

SELECT Typ.TypeID, Typ.TypeName, COUNT(Que.TypeID) AS So_Luong 
	FROM Question AS Que
		RIGHT JOIN Typequestion Typ ON Que.TypeID = Typ.TypeID
		GROUP BY Que.TypeID;

-- QUESTION 14:LẤY RA GROUP KHÔNG CÓ ACCOUNT NÀO

SELECT gro.GroupName
	FROM group1 as gro
		LEFT JOIN groupaccount as groa
			ON gro.GroupID = groa.GroupID
			GROUP BY groa.AccountID,gro.GroupName
			HAVING count(groa.AccountID) = 0;

-- Question 15: Lấy ra group có nhieu account nhat

SELECT gro.GroupName,count(groa.AccountID) as so
	FROM group1 as gro
		LEFT JOIN groupaccount as groa
			ON gro.GroupID = groa.GroupID
			GROUP BY groa.AccountID
			HAVING count(groa.AccountID) = (SELECT MAX(sl) FROM (SELECT count(g.AccountID) as sl FROM groupaccount as g GROUP BY g.AccountID) as so_luong);

-- QUESTION 16: LẤY RA QUESTION KHÔNG CÓ ANSWER NÀO

SELECT que.Content
	FROM question as que
		LEFT JOIN answer as ans
		ON que.QuestionID = ans.QuestionID
			GROUP BY que.Content, ans.QuestionID
			HAVING count(ans.QuestionID) = 0;

													-- EXERCISE 2: UNION
                                                    
-- QUESTION 17:
-- A) LẤY CÁC ACCOUNT THUỘC NHÓM THỨ 1
SELECT Acc.FullName FROM Account1 Acc
	JOIN GroupAccount Gro ON Acc.AccountID = Gro.AccountID
		WHERE Gro.GroupID = 1;

-- B) LẤY CÁC ACCOUNT THUỘC NHÓM THỨ 2
SELECT Acc.FullName FROM Account1 Acc
	JOIN GroupAccount Gro ON Acc.AccountID = Gro.AccountID
		WHERE Gro.GroupID = 2;

-- C) GHÉP 2 KẾT QUẢ TỪ CÂU A) VÀ CÂU B) SAO CHO KHÔNG CÓ RECORD NÀO TRÙNG NHAU

SELECT Acc.FullName FROM Account1 Acc
	JOIN GroupAccount Gro ON Acc.AccountID = Gro.AccountID
		WHERE Gro.GroupID = 1
UNION		
SELECT Acc.FullName FROM Account1 Acc
	JOIN GroupAccount Gro ON Acc.AccountID = Gro.AccountID
		WHERE Gro.GroupID = 2;
        
-- QUESTION 18:
-- A) LẤY CÁC GROUP CÓ LỚN HƠN 1 THÀNH VIÊN
SELECT Gro.GroupName, COUNT(Groa.GroupID) AS So_Luong
	FROM GroupAccount AS Groa
		JOIN Group1 AS Gro ON Groa.GroupID = Gro.GroupID
			GROUP BY Gro.GroupID
			HAVING COUNT(Groa.GroupID) > 1;
            
-- B) LẤY CÁC GROUP CÓ LỚN HƠN 2 THÀNH VIÊN
SELECT Gro.GroupName, COUNT(Groa.GroupID) AS So_Luong
	FROM GroupAccount AS Groa
		JOIN Group1 AS Gro ON Groa.GroupID = Gro.GroupID
			GROUP BY Gro.GroupID
			HAVING COUNT(Groa.GroupID) > 2;

-- C) GHÉP 2 KẾT QUẢ TỪ CÂU A) VÀ CÂU B)

SELECT Gro.GroupName, COUNT(Groa.GroupID) AS So_Luong
	FROM GroupAccount AS Groa
		JOIN Group1 AS Gro ON Groa.GroupID = Gro.GroupID
			GROUP BY Gro.GroupID
			HAVING COUNT(Groa.GroupID) > 1	
UNION ALL
SELECT Gro.GroupName, COUNT(Groa.GroupID) AS So_Luong
	FROM GroupAccount AS Groa
		JOIN Group1 AS Gro ON Groa.GroupID = Gro.GroupID
			GROUP BY Gro.GroupID
			HAVING COUNT(Groa.GroupID) > 2;           