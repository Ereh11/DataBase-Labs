-- Task 4

USE Company_SD;
--
SELECT * FROM Employee;
--
SELECT Fname, 
	   Lname, 
	   Salary, 
	   Dno AS Department_Num
FROM Employee;
--
SELECT Pname,
	   Plocation,
	   Dnum AS Department_Num
FROM Project;
--
SELECT Fname + ' ' + Lname AS Fullname, 
	   (Salary * 120) / 100 As Annual_Comm
FROM Employee;
--
SELECT	SSN,
		Fname + ' ' + Lname AS Fullname
FROM Employee
WHERE Salary > 1000;
--
SELECT	SSN,
		Fname + ' ' + Lname AS Fullname
FROM Employee
WHERE Salary * 12 > 10000;
--
SELECT	Fname + ' ' + Lname AS Fullname,
		Salary
FROM Employee
WHERE Sex = 'F';
--
SELECT Dnum,
	   Dname
FROM Departments, Employee
WHERE Superssn = 968574 AND Dno = Dnum;
--
SELECT Pnumber,
	   Pname,
	   Plocation
FROM Project
WHERE Dnum = 10;
--
SELECT Dname,
	   MAX(Salary) AS MaxSalary,
	   MIN(Salary) AS MinSalary,
	   AVG(Salary) AS AvgSalary
FROM Departments
INNER JOIN Employee
ON Dno = Dnum
GROUP BY Dname;

--- DML Task

INSERT INTO Employee
VALUES ('Mariam', 'Abd El-Atty', 102672, '1999-10-05', 'Sohag', 'F', 3000, 112233, 30);
--
INSERT INTO Employee(Fname, Lname, SSN, Bdate, Address, Sex, Dno)
VALUES ('Mariam', 'Hassan', 102660, '1999-01-01', 'Assuit', 'F', 30);
--
UPDATE Employee
SET Salary = Salary + ((Salary * 20) / 100)
WHERE SSN = 102672;
