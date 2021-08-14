--CREATE TABLE [dbo].[tblEmp](EmpNo int,Name varchar,LastName varchar(20) ,Degree int,HireDtae smalldatetime,Certificat varchar(10),Address varchar(50))
--CREATE TABLE [dbo].[tblTime](EmpNo int,Start smalldatetime,EndWOrk smalldatetime) 
--CREATE TABLE [dbo].[tblWages](Degree varchar(20),HYear varchar(10),LYear varchar(10),HourWages decimal(18, 2))

--truncate table tblEmp
--truncate table tblTime
--truncate table tblWages
 
 --insert into tblEmp values(1,'NIDHIN','P',2,'06/01/2010','MAL','HANA')
 --insert into tblEmp values(2,'RIJU','K',2,'01/01/2015','ENG','RASHIDIA')
 --insert into tblEmp values(3,'SHYJU','K',4,'04/10/2016','MAL','HANA')
 --insert into tblEmp values(4,'SASI','A',3,'10/08/2003','HIN','KARAMA 12')
 --insert into tblEmp values(5,'VIBIN','L',1,'05/26/2003','MAL','KARAMA')
 --insert into tblEmp values(6,'SACHIN','SHETTY',6,'11/15/2006','ENG','DEIRA 12 ST')
 --insert into tblEmp values(7,'AJAY','PAUL',28,'10/25/2012','ENG','MARINA 36 ST')
 --insert into tblEmp values(8,'JIJESH','B',28,'07/14/2018','HIN','MARINA')
 --insert into tblEmp values(8,'RAJI','P',22,'09/12/2008','HIN','MARINA')
 

 --insert into tblTime values(1,'06/01/2010 07:00:00','06/01/2010 15:00:00')
 --insert into tblTime values(1,'06/07/2010 07:00:00','06/07/2010 15:00:00')
 --insert into tblTime values(1,'06/09/2010 07:00:00','06/09/2010 17:00:00')
 --insert into tblTime values(1,'07/02/2010 15:00:00','07/02/2010 23:00:00')
 --insert into tblTime values(1,'08/03/2011 15:00:00','08/03/2011 23:59:59')
 --insert into tblTime values(3,'04/10/2016 09:00:00','04/10/2016 19:00:00')
 --insert into tblTime values(3,'04/15/2016 08:00:00','04/15/2016 17:00:00')
 --insert into tblTime values(6,'06/06/2007 09:00:00','06/06/2007 17:00:00')
 --insert into tblTime values(6,'08/06/2008 08:00:00','08/06/2008 18:00:00')
 --insert into tblTime values(5,'05/27/2004 09:00:00','05/27/2004 19:00:00')
 --insert into tblTime values(5,'08/10/2005 15:00:00','08/10/2005 23:00:00')

 --insert into tblWages values(2,'','',150)
 --insert into tblWages values(3,'','',160)
 --insert into tblWages values(4,'','',165)
 --insert into tblWages values(6,'','',170)
 --insert into tblWages values(20,'','',180)
 --insert into tblWages values(22,'','',190)
 --insert into tblWages values(28,'','',200)

select * from tblEmp
select * from tblTime  
select * from tblWages  
 
 select EmpNo,Name,LastName from tblEmp where Address='Hana' and DATEDIFF(year,HireDtae,getdate())>=10
 select EmpNo,Name,LastName from tblEmp where (Degree=2 and Certificat='ENG') or (Degree=3 and HireDtae>='05/25/2003')
 select EmpNo,Name,LastName from tblEmp where EmpNo not in(select EmpNo FRoM tblTime)
 select * from tblEmp where DATEDIFF(Year,HireDtae,getdate())>4
 --  update tblEmp set Degree=Degree+1 where DATEDIFF(Year,HireDtae,getdate())>4
 select Degree,Employee_Count=count(degree) from tblEmp where Degree >21 group by Degree
 select EmpNo,Name,LastName,Address,Certificat from tblEmp where Address like '%12%'
 ------------------------------------------------------------------------------------------------------------
 select a.EmpNo,Name,LastName,WorkDate=convert(varchar(20),start,103), WorkHours_PerDay=case when DATEDIFF(HOUR,Start,EndWOrk)>8 then 8 else DATEDIFF(HOUR,Start,EndWOrk) end,
 OverTime=case when DATEDIFF(HOUR,Start,EndWOrk)>8 then DATEDIFF(HOUR,Start,EndWOrk)-8 else 0 end ,
 Total_WorkHours=(case when DATEDIFF(HOUR,Start,EndWOrk)>8 then 8 else DATEDIFF(HOUR,Start,EndWOrk) end)+(case when DATEDIFF(HOUR,Start,EndWOrk)>8 then DATEDIFF(HOUR,Start,EndWOrk)-8 else 0 end) 
 from  tblEmp A,tblTime B where a.EmpNo=b.EmpNo  
 union all
select a.EmpNo,Name,LastName,WorkDate=Null, WorkHours_PerDay=0, OverTime=0 , Total_WorkHours=0 from  tblEmp A where a.EmpNo not in(select EmpNo from tblTime) 
	----------------------------
 select b.EmpNo,Name,LastName, AvgWorkHours=sum(DATEDIFF(HOUR,Start,EndWOrk))/Count(b.EmpNo) , TotalWorkHours=sum(DATEDIFF(HOUR,Start,EndWOrk)),TOtalAttendance=Count(b.EmpNo) from 
 tblEmp A,tblTime B where a.EmpNo=b.EmpNo group by  b.EmpNo,Name,LastName 
	-------------------------------
  select x.EmpNo,Name,LastName,WorkingMonth,WorkingYear, TotalWorkHours=sum(TotalWorkHours),TOtalAttendance=sum(TOtalAttendance) from (
 select b.EmpNo,Name,LastName,WorkingMonth=Month(Start),WorkingYear=Year(Start), 
 TotalWorkHours=sum(DATEDIFF(HOUR,Start,EndWOrk)),TOtalAttendance=Count(b.EmpNo) from  tblEmp A,tblTime B where a.EmpNo=b.EmpNo group by  b.EmpNo,Name,LastName ,Start
 union all
  select a.EmpNo,Name,LastName,WorkingMonth=0, WorkingYear=0, TotalWorkHours=0 , TOtalAttendance=0 from  tblEmp A where a.EmpNo not in(select EmpNo from tblTime) 
 ) X group by EmpNo,Name,LastName,WorkingMonth,WorkingYear
	---------------------------------------
 select x.EmpNo,Name,LastName,WorkingMonth,WorkingYear, TotalWorkHours=sum(TotalWorkHours),TOtalAttendance=sum(TOtalAttendance),Salary=sum(TotalWorkHours)*150 from (
 select b.EmpNo,Name,LastName,WorkingMonth=Month(Start),WorkingYear=Year(Start), 
 TotalWorkHours=sum(DATEDIFF(HOUR,Start,EndWOrk)),TOtalAttendance=Count(b.EmpNo) from  tblEmp A,tblTime B where a.EmpNo=b.EmpNo group by  b.EmpNo,Name,LastName ,Start
 union all
  select a.EmpNo,Name,LastName,WorkingMonth=0, WorkingYear=0, TotalWorkHours=0 , TOtalAttendance=0 from  tblEmp A where a.EmpNo not in(select EmpNo from tblTime)
 ) X group by EmpNo,Name,LastName,WorkingMonth,WorkingYear
	--------------------------------
 select x.EmpNo,Name,LastName,Total_Service=Servic,Salary=sum(TotalWorkHours)*HourWages from (
 select b.EmpNo,Name,LastName,TotalWorkHours=sum(DATEDIFF(HOUR,Start,EndWOrk)),TOtalAttendance=Count(b.EmpNo),c.HourWages,Servic=DATEDIFF(Year,HireDtae,getdate()) from  tblEmp A,tblTime B,tblWages C
 where a.EmpNo=b.EmpNo and a.Degree=c.Degree group by  b.EmpNo,Name,LastName ,Start,HourWages,HireDtae
  ) X group by EmpNo,Name,LastName ,HourWages,Servic 
 -----------------------------------------------------------------------------------------------
 
 -------------------------------------------------------------------------------------------------
 select * from Employee_Details -- View Name
 ----------------------------------------------------------------------------------------------
 DROP SEQUENCE [dbo].[SequenceIncrement]  
 CREATE SEQUENCE [dbo].[SequenceIncrement]  
    AS decimal(3,0)   
    START WITH 15  
    INCREMENT BY 15  
    MINVALUE 8  
    MAXVALUE 200  
    CYCLE  
    CACHE 8  
;  

SELECT NEXT VALUE FOR [SequenceIncrement];
------------------------------------------------------------------------------------------------
truncate table tblDepartment
truncate table tblName
--create table tblDepartment (Code varchar(10),Department varchar(20))
--create table tblName (Code varchar(10),Names varchar(40))

--insert into tblName values('2001','Tony Stark')
--insert into tblName values('2002','Natalie Portman')
--insert into tblName values('2003','Angelina Jolie')
--insert into tblName values('2004','Leonardo Dicaprio') 

--insert into tblDepartment values('A1B2','IT')
--insert into tblDepartment values('C3D4','Sales')
--insert into tblDepartment values('E5F6','Accounting')

select * from tblDepartment
select * from tblName
-------------------------------------------------------------------------------------------------

CREATE View [dbo].[Employee_Details]
 AS
 select a.EmpNo,Name,LastName,WorkDate=convert(date,start), WorkHours_PerDay=case when DATEDIFF(HOUR,Start,EndWOrk)>8 then 8 else DATEDIFF(HOUR,Start,EndWOrk) end,
 OverTime=case when DATEDIFF(HOUR,Start,EndWOrk)>8 then DATEDIFF(HOUR,Start,EndWOrk)-8 else 0 end ,
 Total_WorkHours=(case when DATEDIFF(HOUR,Start,EndWOrk)>8 then 8 else DATEDIFF(HOUR,Start,EndWOrk) end)+(case when DATEDIFF(HOUR,Start,EndWOrk)>8 then DATEDIFF(HOUR,Start,EndWOrk)-8 else 0 end) ,
 Salary=(case when DATEDIFF(HOUR,Start,EndWOrk)>8 then 8 else DATEDIFF(HOUR,Start,EndWOrk) end *150)+(case when DATEDIFF(HOUR,Start,EndWOrk)>8 then DATEDIFF(HOUR,Start,EndWOrk)-8 else 0 end *(150*2))
 from  tblEmp A,tblTime B where a.EmpNo=b.EmpNo  
  union  
  select a.EmpNo,Name,LastName,WorkDate=Null, WorkHours_PerDay=0, OverTime=0 , Total_WorkHours=0 , Salary=0
 from  tblEmp A where a.EmpNo not in(select EmpNo from tblTime) 

 -----------------------------------------------------------------------------------