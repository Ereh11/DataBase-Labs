-- ITI Lab5 Answers
-- 1-  Create a scalar function that takes a date and returns the Month name of that date. test (�1/12/2022�)CREATE FUNCTION NameMonth(@dat DATE)RETURNS VARCHAR(10)AS	BEGIN		RETURN DATENAME(MONTH, @dat)	END;GO;SELECT dbo.NameMonth('1/12/2022');GO;-- 2-  Create a multi-statements table-valued function that takes 2 integers and returns the values between them.CREATE FUNCTION ReturnNumbers(@start INT, @end INT)RETURNS @numbers TABLE (par INT)AS	BEGIN		WHILE (@start + 1 < @end)			BEGIN				INSERT INTO @numbers VALUES(@start + 1)				SET @start = @start + 1			END;		RETURN;	ENDGO;SELECT * FROM dbo.ReturnNumbers(5, 8);GO;-- 3-  Create a tabled valued function that takes Student No and returns Department Name with Student full name.CREATE FUNCTION StudentData(@Id INT)RETURNS TABLEASRETURN	SELECT CONCAT(St_Fname, ' ', St_Lname) AS FullName,		   Dept_Name	FROM ITI.dbo.Student AS s	INNER JOIN ITI.dbo.Department AS d	ON d.Dept_Id = s.Dept_Id	WHERE St_Id = @Id;GO;SELECT * FROM dbo.StudentData(5);GO;/* 4- Create a scalar function that takes Student ID and returns a message to the user (use Case statement)
	a. If the first name and Last name are null then display 'First name 
	& last name are null'
	b. If the First name is null then display 'first name is null'
	c. If the Last name is null then display 'last name is null'
	d. Else display 'First name & last name are not null'*/CREATE OR ALTER FUNCTION PrintMessage(@Id INT)RETURNS VARCHAR(50)AS	BEGIN		DECLARE @msg VARCHAR(50)			SELECT @msg = CASE 						WHEN(St_Fname IS NULL AND St_Lname IS NULL) THEN 'First name & last name are null'						WHEN(St_Fname IS NULL) THEN 'first name is null'						WHEN(St_Lname IS NULL) THEN 'last name is null'						ELSE 'First name & last name are not null' END			FROM ITI.dbo.Student			WHERE St_Id = @Id;		RETURN @msg;	END;GO;SELECT dbo.PrintMessage(12);GO;/*5- Create a function that takes an integer that represents the format of the Manager hiring date and displays department name, Manager Name, and 
   hiring date with this format. */CREATE FUNCTION DisplayBasedFormat(@Format INT)RETURNS TABLE AS RETURN 	SELECT i.Ins_Name AS ManagerName,		   d.Dept_Name AS DepartmentName,		   CONVERT(DATE, d.Manager_hiredate, @Format) AS HiringDateFROM	FROM ITI.dbo.Department AS d	INNER JOIN ITI.dbo.Instructor AS i	ON d.Dept_Manager = i.Ins_Id;GO;SELECT *FROM DisplayBasedFormat(20);GO;/*6- Create multi-statements table-valued function that takes a string
	If string='first name' returns student first name
	If string='last name' returns student last name 
	If string='full name' returns Full Name from student table 
	Note: Use the �ISNULL� function */CREATE FUNCTION ReturnName(@Name VARCHAR(20))RETURNS @Data TABLE(Name VARCHAR(50))AS 	BEGIN		INSERT INTO @Data			SELECT CASE						WHEN @Name = 'first name' THEN ISNULL(St_Fname, 'NO DATA')						WHEN @Name = 'last name' THEN ISNULL(St_Lname, 'NO DATA')						WHEN @Name = 'full name' THEN ISNULL(CONCAT(St_Fname,' ', St_Lname), 'NO DATA')				   END			FROM ITI.dbo.Student;		RETURN;	ENDGO;SELECT * FROM ReturnName('first name')GO;-- 7- Write a query that returns the Student No and Student first name without the last charCREATE FUNCTION ReqDate()RETURNS TABLEASRETURN	SELECT St_Id,		   LEFT(St_Fname, LEN(St_Fname) - 1) AS St_Fname	FROM ITI.dbo.Student;GO;SELECT * FROM ReqDate();GO;-- 8- Write a query that takes the columns list and table name into variables and then return the result of this query �Use exec command�DECLARE @columns_list VARCHAR(MAX) = 'St_Id, St_Fname, St_Lname',	    @table_name VARCHAR(10) = 'Student';EXEC('SELECT ' + @columns_list + ' FROM ' + @table_name);GO;-- ***************************************** -Part 2- Based on Company DataBase *******************************************-- 9- Create a function that takes project number and display all employees in this projectCREATE FUNCTION DiaplayAll(@ProjectID INT)RETURNS TABLEASRETURN	SELECT CONCAT(Fname, ' ', Lname) AS FullName	FROM Company_SD.dbo.Employee AS e	INNER JOIN Company_SD.dbo.Departments AS d	ON e.Dno = d.Dnum	INNER JOIN Company_SD.dbo.Project AS p	ON d.Dnum = p.Dnum	WHERE Pnumber = @ProjectID;GO;SELECT * FROM DiaplayAll(100);GO;-- 10- Write a Query that computes the increment in salary that arises if the salary of employees increased by any value.CREATE OR ALTER FUNCTION ComupteTheRaise(@RaisedValue Decimal)RETURNS @Data TABLE(Id INT, SalaryBefore INT, SalaryAfter INT, IncreasingPercentage Decimal)AS	BEGIN		INSERT INTO @Data			SELECT SSN,				   Salary AS SalaryBeforeIncreasing,				   (Salary + @RaisedValue) AS SalaryAfterIncreasing,				   (@RaisedValue / Salary) * 100 As IncreasingPercentage			FROM Company_SD.dbo.Employee;		RETURN;	ENDGO;SELECT * FROM ComupteTheRaise(1000);GO;