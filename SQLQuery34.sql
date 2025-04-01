create database siri1
-----creating table-------
create  table employee(
empid int,
empfirstname varchar(20),
emplastname varchar(30),
salary int,
address  varchar(100))
-----inserting a value------
insert into employee(empid,empfirstname,emplastname,salary,address)
select 1,'dinesh','kumar',10000,'india' 
insert into employee(empid,empfirstname,emplastname,salary,address)
select 2,'john','cena',2000,'us' 
insert into employee(empid,empfirstname,emplastname,salary,address)
select 3,'ravi','singh',3000,'aus' 
insert into employee(empid,empfirstname,emplastname,salary,address)
select 4 ,'john','wright',4000,'india' 
insert into employee(empid,empfirstname,emplastname,salary,address)
select 5,'santosh','kumar',5000,'us'
insert into employee(empid,empfirstname,emplastname,salary,address)
select 6,'steeve','smith',300,'aus' 
select *from employee
-------constraints---------------------
-----not null----
CREATE TABLE NotNULLTest(
Id int NOT NULL,
Name varchar(100))
INSERT INTO NotNULLTest(ID,Name)
SELECT 1,'Dinesh'

INSERT INTO NotNULLTest(ID,Name)
SELECT NULL,'John'

INSERT INTO NotNULLTest(ID,Name)
SELECT 3,NULL

INSERT INTO NotNULLTest(ID)
SELECT 4
select *from NotNULLTest
------------unique---------------
CREATE TABLE UniqueTest(
	Id int UNIQUE, 
	Name varchar(100))

INSERT INTO UniqueTest(Id,name)
SELECT 1,'Dinesh'

INSERT INTO UniqueTest(Id,name)
SELECT 2,'John'

INSERT INTO UniqueTest(Id,name)
SELECT 2,'Smith'

INSERT INTO UniqueTest(Id,name)
SELECT NULL,'John'

INSERT INTO UniqueTest(Id,name)
SELECT NULL,'Josh'

SELECT * FROM UniqueTest
--------------primary key------------
CREATE TABLE PrimaryKeyTest(
Id int PRIMARY KEY,
Name varchar(100))
INSERT INTO PrimaryKeyTest(Id,Name)
SELECT 1,'Dinesh'

INSERT INTO PrimaryKeyTest(Id,Name)
SELECT 2,'John'


INSERT INTO PrimaryKeyTest(Id,Name)
SELECT 2,'Josh'


INSERT INTO PrimaryKeyTest(Id,Name)
SELECT null,'Josh'

SELECT * FROM PrimaryKeyTest
--------------foreign key---------------
CREATE TABLE ForeignKeyTest
(
	Id int FOREIGN KEY REFERENCES PrimaryKeyTest(ID)
	, DOB date
)
INSERT INTO ForeignKeyTest(Id,DOB)
SELECT 1,'2019-01-10'
INSERT INTO ForeignKeyTest(Id,DOB)
SELECT NULL,'2019-01-10'
select *from ForeignKeyTest
---------check constraint---------------
CREATE TABLE CheckTest(
Id int,
Salary int CHECK(Salary > 0))
INSERT INTO CheckTest(Id,Salary)
SELECT 1,1000

INSERT INTO CheckTest(Id,Salary)
SELECT 2,2000

INSERT INTO CheckTest(Id,Salary)
SELECT 2,0
select * from CheckTest

CREATE TABLE CheckTest2
(
	Name varchar(100)
	, VaccinationFlag varchar(10) CHECK(VaccinationFlag IN ('Yes','No'))
)

INSERT INTO CheckTest2(Name,VaccinationFlag)
SELECT 'Dinesh','Yes'

INSERT INTO CheckTest2(Name,VaccinationFlag)
SELECT 'Leo','NO'

INSERT INTO CheckTest2(Name,VaccinationFlag)
SELECT 'John','Y'

SELECT * FROM CheckTest2
------------------default constraint-----------------
CREATE TABLE DefaultTest(

	Id int,
	Name varchar(100) DEFAULT('NoNameProvided'))
INSERT INTO DefaultTest(Id,Name)
SELECT 1,'Dinesh'
INSERT INTO DefaultTest(Id,Name)
SELECT 2,NULL

INSERT INTO DefaultTest(Id)
SELECT 3
select *from DefaultTest
--------------idenetity test---------------
CREATE TABLE IdentityTest(
ID int IDENTITY(1,1),
Name varchar(100))
INSERT INTO IdentityTest(Name)
SELECT 'Dinesh' UNION
SELECT 'John'
select *from IdentityTest
--------top clause------------
SELECT TOP 3 *
FROM Employee AS emp
WHERE Address = 'India'
-------------like operator------------
SELECT *
FROM Employee
WHERE EmpFirstName LIKE '%s_'
SELECT *
FROM Employee
WHERE EmpFirstName LIKE '__h%'
----------------jions-----------------------
select * from Employee
CREATE TABLE EmployeeDOB
(
	EmployeeID int
	, EmployeeDOB date
)
INSERT INTO EmployeeDOB(EmployeeID, EmployeeDOB)
SELECT 1, GETDATE()-7000 UNION ALL  -- '25-01-2025'
SELECT 2, GETDATE()-7300 UNION ALL
SELECT 5, GETDATE()-7900 UNION ALL
SELECT 6, GETDATE()-8000 UNION ALL
SELECT 7, GETDATE()-7800 UNION ALL
SELECT 8, GETDATE()-7600 UNION ALL
SELECT 9, GETDATE()-6000 UNION ALL
SELECT 10, GETDATE()-12000 UNION ALL
SELECT 11, GETDATE()-15000
SELECT * FROM EmployeeDOB
SELECT * FROM Employee
---------------inner join-------------
SELECT emp.*, edob.EmployeeDOB
FROM Employee AS emp
INNER JOIN EmployeeDOB AS edob
ON edob.EmployeeID = emp.EmpID

SELECT employee.*,EmployeeDOB.EmployeeDOB
FROM Employee 
INNER JOIN EmployeeDOB
ON EmployeeDOB.EmployeeID = Employee.EmpID
--------------------left outer join---------------
SELECT * FROM EmployeeDOB 
SELECT * FROM Employee
SELECT *
FROM Employee  
LEFT JOIN EmployeeDOB 
ON EmployeeDOB.EmployeeID = Employee.EmpId
-------------rightouter join---------------
SELECT *
FROM Employee AS emp 
RIGHT JOIN EmployeeDOB AS edob 
ON edob.EmployeeID = emp.EmpId
------------------full outer join------------
SELECT *
FROM Employee AS emp 
FULL OUTER JOIN EmployeeDOB AS edob
ON edob.EmployeeID = emp.EmpId
-------------------cross join-----------------
SELECT * FROM Employee 
CROSS JOIN EmployeeDOB
CREATE TABLE Months(MonthNm varchar(10)) 

INSERT INTO Months(MonthNm)
SELECT 'Jan' UNION ALL
SELECT 'Feb' UNION ALL
SELECT 'Mar' UNION ALL
SELECT 'Apr' UNION ALL
SELECT 'May' UNION ALL
SELECT 'Jun' UNION ALL
SELECT 'Jul' UNION ALL
SELECT 'Aug' UNION ALL
SELECT 'Sep' UNION ALL
SELECT 'Oct' UNION ALL
SELECT 'Nov' UNION ALL
SELECT 'Dec' 

SELECT empfirstname, EmpLastName, MonthNm 
FROM Employee AS Emp
CROSS JOIN Months AS m

-----------------update and delete-----------------
SELECT *
INTO Employee_Backup
FROM Employee

SELECT * FROM Employee_Backup
------------Backup only a few rows from the table
SELECT *
INTO Employee_BackupOnlyRows
FROM Employee
WHERE EmpID IN (1,4,7)
SELECT * FROM Employee_BackupOnlyRows
--------------update---------------------
UPDATE emp
SET EmpFirstName = 'Dinesh'
--SELECT *
FROM Employee AS emp
WHERE EmpId = 1
-- Revert Back your change using the backup table
UPDATE emp
SET EmpFirstName = bak.EmpFirstName
FROM Employee AS emp
INNER JOIN Employee_Backup AS bak ON bak.EmpID = emp.empid
--------------DELETE-------------------
DELETE emp
--SELECT *
FROM Employee AS emp
WHERE empid = 5
------------Revert Back your change using the backup table
INSERT INTO Employee
(
	EmpId
	, EmpFirstName
	, emplastname
	, Salary
	, Address
)
SELECT EmpID
	, EmpFirstName
	, EmpLastName
	, Salary
	, Address
FROM Employee_Backup
----------alter table--------------------------------
----adding a not null column----
ALTER TABLE DefaultTest
ADD Salary int NOT NULL DEFAULT(0)

SELECT * FROM DefaultTest
-- Add a null column
ALTER TABLE DefaultTest
ADD Address varchar(100) 
SELECT * FROM DefaultTest
----------drop a column--------
ALTER TABLE DefaultTest
DROP COLUMN Address
-----------to view meta data---
sp_help defaulttest

ALTER TABLE DefaultTest
DROP Constraint DF__DefaultTe__Salar__5BE2A6F2
select * from DefaultTest

-------alter a column--
ALTER TABLE UniqueTest
ALTER COLUMN Name varchar(120) NOT NULL

ALTER TABLE NotNullTest
ALTER COLUMN Name varchar(120) NOT NULL

SELECT * FROM UniqueTest
SELECT * FROM NotNullTest

DELETE FROM NotNullTest
WHERE Name IS NULL
-------------temporary tables-------------
--local temp table--
CREATE TABLE #LocalTempTable
(
	Id int
	, Name varchar(100)
)

INSERT INTO #LocalTempTable(Id,Name)
SELECT 1,'Dinesh' UNION ALL
SELECT 2,'John' UNION ALL
SELECT 3,'Steve' 

SELECT * FROM #LocalTempTable AS x
INNER JOIN Employee AS emp ON emp.EmpId = x.Id

DROP TABLE #LocalTempTable
------global temp table---
CREATE TABLE ##GlobalTempTable
(
	Id int
	, Name varchar(100)
)

INSERT INTO ##GlobalTempTable(Id,Name)
SELECT 1,'Dinesh' UNION ALL
SELECT 2,'John' UNION ALL
SELECT 3,'Steve' 

SELECT * FROM ##GlobalTempTable
	
DROP TABLE ##GlobalTempTable
---------- Copying the data from Source to the temp table
SELECT *
INTO #EmployeeData
FROM Employee

SELECT * FROM #EmployeeData AS x

DROP TABLE #EmployeeData
--------table variable----------------------
DECLARE @tableVariable TABLE 
(
	id int
	, Name varchar(100)
)

INSERT INTO @tableVariable(id,name)
SELECT 1,'Dinesh' UNION ALL
SELECT 2,'John' UNION ALL
SELECT 3,'Steve'
select *from @tableVariable

-----------functions---------------
----date functions-----
SELECT GETDATE() 
SELECT GETUTCDATE()
SELECT GETDATE() + 2 
SELECT GETDATE() - 2 
SELECT DATEADD(hour,2,GETDATE()) 
SELECT DATEADD(hour,-2,GETDATE()) 
SELECT DATEADD(year,2,GETDATE())
SELECT DATEADD(year,-2,GETDATE()) 
SELECT DATEADD(month,2,GETDATE()) 
SELECT DATEADD(month,2,DATEADD(hour,3,GETDATE())) 
SELECT YEAR(GETDATE()) 
SELECT MONTH(GETDATE()) 
SELECT DATEPART(day,GETDATE()) 
SELECT DATEPART(hour,GETDATE()) 
SELECT DATEPART(minute,GETDATE())
SELECT DATEPART(year,GETDATE())
SELECT DATEPART(month,GETDATE())
SELECT DATEDIFF(day,'2022-09-01','2022-09-07') 
SELECT DATEDIFF(hour,'2022-09-01','2022-09-07')
SELECT DATEDIFF(minute,'2022-09-01 20:00','2022-09-01 23:00')
SELECT DATENAME(MONTH,GETDATE())
SELECT DATENAME(WEEKDAY, GETDATE())
SELECT *
	, YEAR(dob.EmployeeDOB) AS YearOfBirth
	, DATEDIFF(YEAR,dob.EmployeeDOB,GETDATE()) AS AgeInYears
FROM Employee AS emp
INNER JOIN EmployeeDOB AS dob ON dob.EmployeeID = emp.EmpID
--------Filtering by year 
SELECT *
FROM EmployeeDOB
WHERE YEAR(EmployeeDOB) >= 2000 
-----string functions-----------
SELECT UPPER('dinesh') 
SELECT LOWER('Dinesh') 
SELECT LEN('   dinesh123   ') AS LengthOfString 
SELECT 'Dinesh' + ' ' + 'Kumar'
SELECT LEFT('dinesh',2)
SELECT RIGHT('dinesh',4) 
SELECT TRIM('           dinesh         kumar         ')
SELECT REPLACE('dinesh','nes','X')
SELECT REVERSE('dinesh') 
SELECT SUBSTRING('dinesh',3,10) 
SELECT CHARINDEX('i','dinesh')
SELECT CONCAT('Dinesh','Panda') 
--------------Extract Domain name from the email address--------
DECLARE @Email varchar(100) = 'dineshkumar@gmail.com'
SELECT SUBSTRING(@Email,1,CHARINDEX('@',@Email)-1) AS UserName
SELECT SUBSTRING(@Email,CHARINDEX('@',@Email)+1,LEN(@Email)) AS DomainName
-------Use case of string functions--------
CREATE TABLE EmpTbl(ID int, EmailID varchar(200))
INSERT INTO EmpTbl(ID,EmailID)
SELECT 1,'dinesh@gmail.com' UNION ALL
SELECT 2,'john@gmail.com' UNION ALL
SELECT 3,'smith@microsoft.com' UNION ALL
SELECT 4,'sumit@yahoo.com' UNION ALL
SELECT 5,'peter@gmail.com'
SELECT *
	, SUBSTRING(EmailID,1,CHARINDEX('@',EmailID)-1) AS UserName
	, SUBSTRING(EmailID,CHARINDEX('@',EmailID) + 1,LEN(EmailID)) AS DomainName
FROM EmpTbl
create table emptab3(
id int,instaid varchar(100))
insert into emptab3(id,instaid)
select 1,'cuitesam@123' union all
select 2,'dadslittleprice@245' union all
select 3,'heroe@#323' union all
select 4,'hhgdf%@77656' 
select * 
,substring(instaid,1,charindex('@',instaid)-1) as username
,substring(instaid,charindex('@',instaid)+1,len(instaid)) as domainname
from emptab3

------------------isnull ---------------------
select  id,name from UniqueTest
where isnull(id,0)<1
-----------------aggreagted functions----------------------
select max(salary) as maximumsalary from employee
where address='us'
select  min(salary) as minimumsalary from employee where address='india'
select avg(salary) as average from employee
select sum(salary)  from employee
------------------user defined functions(scalar function)--------------------
----creating a function----
create or alter function fn_getfullname(
@firstname varchar(100),
@lastname varchar(100))
returns varchar(101)
as
begin
return (concat(trim(@firstname),'',trim(@lastname)))
end
-----inserting a values----

select dbo.fn_getfullname ('dinesh','kumar') as fullname
select dbo.fn_getfullname('jhon','smith') as fullname
CREATE OR ALTER FUNCTION fn_AddNumbers
(
	@number1 int
	, @number2 int
)
RETURNS int
AS
BEGIN
	RETURN(ISNULL(@number1,0)+ISNULL(@number2,0))
end
SELECT dbo.fn_AddNumbers(1,2)
SELECT dbo.fn_AddNumbers(10,15)
SELECT dbo.fn_AddNumbers(10,NULL)

SELECT * FROM dbo.Employee
SELECT * FROM Employee
 -------use Scalar Valued Functions in a SELECT query
SELECT EmpID, EmpfirstName, emplastname
	, dbo.fn_GetFullName(empfirstname,emplastname) AS FullName
FROM Employee AS emp
WHERE dbo.fn_GetFullName(empfirstname,emplastname) = 'Santosh Kumar'
--------------------- Inline/Single Line table valued function--------------------------------

CREATE OR ALTER FUNCTION fn_GetEmployeeDetails
(
	@Address varchar(100)
)
RETURNS TABLE
AS
	RETURN (SELECT dbo.fn_GetFullName(EmpFirstName,EmpLastName) AS FullName 
				, Salary
				, Address
				, EmployeeDOB
			FROM Employee AS emp
			LEFT JOIN EmployeeDOB AS edob ON edob.EmployeeID = emp.EmpId
			WHERE emp.Address = @Address
		)

------------- Call table valued function
SELECT * FROM fn_GetEmployeeDetails('US')
SELECT * FROM Employee WHERE EmpID = 7

--------------------Multi Line/Multi Statement table valued function------------------------------
CREATE FUNCTION fn_GetEmployeeDetailsML
(
	@EmployeeID int
)
RETURNS @Emp TABLE
	(
		EmployeeId int
		, EmployeeFullName varchar(101)
		, Salary int
	)
AS
BEGIN
	INSERT INTO @Emp(EmployeeId,EmployeeFullName,Salary)
	SELECT emp.EmpID, dbo.fn_GetFullName(EmpfirstName,EmpLastName),Salary
	FROM Employee As emp
	WHERE emp.EmpID <> @EmployeeID

	UPDATE @Emp
	SET Salary = 5000
	WHERE EmployeeId IN (2,5)

	DELETE FROM @Emp
	WHERE EmployeeId IN (6,3)

	INSERT INTO @Emp
	SELECT 100,'Dinesh Kumar', 2000

	RETURN
END

SELECT * FROM fn_GetEmployeeDetailsML(4)
SELECT * FROM Employee	
-----------------------Using the table valued User defined functions in JOINS
SELECT *
FROM fn_GetEmployeeDetailsML(4) AS fn
INNER JOIN EmployeeDOB AS emp ON fn.EmpID = emp.EmpId
-- -------------------Remove a function from the DB
DROP FUNCTION fn_GetEmployeeDetailsML
---------------------indexes-----------------------------
CREATE TABLE IndexTest (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Insert values into the table
DECLARE @i INT = 1;
WHILE @i <= 10000
BEGIN
    INSERT INTO IndexTest (id, name)
    VALUES (@i, 'vyankat' + CAST(@i AS VARCHAR(5)));
    SET @i = @i + 1;
END;
select * from IndexTest
---------------------------clustered index-----------------------
select *into indextest_ci from IndexTest
select * from indextest_ci
create clustered index idx_indextest_ci_id on indextest_ci(id)
select * from indextest_ci
where id=7748
-----------------------module 4-----------------------------------------
----order by----------------
select * from  employee
order by salary desc

select empfirstname,salary,address,emplastname from employee
order by 3 desc,1 asc

create table insort(
id int)

insert into insort(id)
select 1 union all
select 2 union all
select 3 union all
select 66 union all
select 67 union all
select -32334 union all
select 99 union all
select 445 union all
select -22 union all
select -3 union all
select -13 
select * from insort 
order by id  asc

create table   textsort(
id varchar(20))

insert into textsort(id)
select 'hello' union all
select '!hello' union all
select 'Hhello' union all
select '@hellodf' union all
select '#fgfd' union all
select '121.44' union all
select '2.46' union all
select '-10' 

select * from textsort
order by id  asc
-----------------group by---------------------------
create table populations(
country varchar(10),city varchar(10),town varchar(10),population int)
insert into populations(country,city,town,population)
select 'c1','ct1','t1',100 union all
select 'c1','ct2','t1',50 union all
select 'c1','ct3','t3',300 union all
select 'c2','ct1','t2',60 union all
select 'c2','ct1','t5',100 union all
select 'c2','ct2','t6',10 union all
select 'c3','ct7','t1',700 
select * from  populations
select sum(population) from populations
select max(population) from populations
select country,city,sum(population)  as sum_population from populations group by city,country
select city,sum(population)  as sum_population from populations group by city
select country,sum(population)  as sum_population from populations group by country
select city,sum(population) as sum_population 
from populations 
where city <> 'ct3' and population <100
group by city
--------------------------having------------------
select city ,sum(population) as totalpopulation
from populations 
where city !='ct3'
group by city
having sum(population)<150
order by city
----------------union & union all--------------------
select  empid,empfirstname from employee
union all
select * from PrimaryKeyTest
union all
select * from UniqueTest
------------------except--------------------------------------------
select id,name from DefaultTest
except
select id,name from UniqueTest
---------------intersect----------------------
select id,name from DefaultTest
intersect select * from PrimaryKeyTest
select id,name from PrimaryKeyTest
intersect select id,name from DefaultTest

---------------ranking-----------------------
 create table ranking(
 country char(10),
 city varchar(10),
 population int)
 insert into ranking(country,city,population)
 values('a','z',456423),
 ('a','m',456423),
 ('a','h',34445),
 ('b','o',45453),
('b','p',432443),
 ('b','q',54543),
('b','r',543531),
 ('b','s',145536)
 select * from ranking
 select *,
 row_number() over(order by population desc) as rownumber from ranking
 select *,rank() over(order by population desc) as rank from ranking
  select *,dense_rank() over(order by population desc) as denserank from ranking
  -------------------stored procedures-------------------
create procedure csp_getdata
  as
  begin
  select * from employee
  end
  -------------------execution of store procedure-----------
  exec  csp_getdata
---------alter the store procedure to add/remove columns---------------
alter procedure dbo.csp_getdata
as 
begin
select empid,empfirstname,emplastname,address from employee
end

exec csp_getdata
-----------------adding a parameter----------------------------
alter procedure dbo.csp_getdata
(
@empid int=0
)
as
begin
select emp.empid,dbo.fn_getfullname(empfirstname,emplastname) as fullname
,address,EmployeeDOB from employee as emp
left join EmployeeDOB as edob
on edob.EmployeeID=emp.empid
where emp.empid=@empid or @empid=0
end
exec csp_getdata @empid=4
-------------------adding an optional parameter--------------
alter procedure dbo.csp_getdata
(
@employeeid int=0
@employeeaddress varchar(100))
as begin
select empid,dbo.fn_getfullname(empfirstname,emplastname) as fullname
,address from employee
where(empid=@employeeid or @employeeid=0)
and address=@employeeaddress 
end
-----------------------set a value to the procedure--------------------
create procedure csp_setdata(
@employeeid int,
@employeefirstname varchar(100),
@employeelastname varchar(100),
@salary int,
@address varchar(100))
as
begin
if not exists (select * from employee where @employeeid=empid)
insert into employee(empid,empfirstname,emplastname,salary,address)
select @employeeid,@employeefirstname,@employeelastname,@salary,@address
else
print 'Employeeid already exists!enter new employeeid'
end
exec csp_setdata 9,'john','smith',1000,'aus'
select * from employee
----------------views----------------------
create view vw_getfullname
as
select * from employee
------retriving the data-------------
select * from vw_getfullname
----------------altering-------------
alter view vw_getfullname
as
select empid,empfirstname,emplastname,address from employee
where empid>3
select * from vw_getfullname
-------------------joining data to view tables--------------------
alter view vw_getfullname
as 
select emp.empid,dbo.fn_GetEmployeeDetails(empfirstname,emplastname)as fullname,emp.address,empdob.employeedob
from employee as emp
left join EmployeeDOB as edob
on emp.empid=edob.EmployeeID
where  emp.empid>3
select * from vw_getfullname where empid in(1,2)
--------------orphnew view----------------------------
create view vw_getemployeebkdata
with schemabinding
select empid,empfirstname,address

---------------------transactions-----------------------
begin transaction
update emp
set empfirstname='soren'
from employee as emp
where empid=2
commit transaction
select * from employee
select @@TRANCOUNT
------------isolational levels----------
------1.reads only committed data-------------
set transaction isolation level read committed
go
select * from employee
-----2.reads uncommited data---------
set transaction isolation level read uncommitted
go
select * from employee
--------------error/exception handling---------------------------------------
declare @numerator int =80,@denominator int=0
begin try
select @numerator/@denominator
end try
begin catch
select 'catch block is hit'
declare @errormessage varchar(100)
set @errormessage=error_message()
select @errormessage
end catch