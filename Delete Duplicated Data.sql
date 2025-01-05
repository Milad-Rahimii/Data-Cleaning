---  Delete duplicated data. there are two types
--  we create table and insert some data at first and then delete duplicated data

----  %%%%%%%%%   Type  1

Create Table Employee (
EmpId      Int  Identity(1,1),
FirstName  Varchar(15),
LastName   Varchar(15)  
)

GO

Insert Into Employee
Values ('John','Mohit'), ('John','Mohit'), ('Alice','White') , ('Bob', 'Jones'),('Dave','Bill') 

GO

Select * From Employee

GO

-------- Deleting data

Delete From Employee
Where EmpId not in (
Select Min(EmpId) From Employee
Group By [FirstName], [LastName]
)
 
Select * from Employee


--------------  End of type  1 %%%%%%%%%%

GO

-------- **** Type  2

Create Table Employee1 (
EmpId   Int, 
[Name]  Varchar(15),
Salary   int  
)

GO 

Insert Into Employee1
Values (1,'John',50000), (1,'John',50000), (2,'Alice',60000) , (3,'Bob', 55000)

GO

Select * From dbo.Employee1

GO

With CTE AS (
Select EmpId , [Name] , Salary 
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY EmpId , [Name] , Salary
              ORDER BY (SELECT NULL)
			  )
 
From Employee1 
) 
Delete From CTE Where DupRank>1

GO

Select * From dbo.Employee1

-----  End of Type  2 ************