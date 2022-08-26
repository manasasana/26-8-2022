create or alter  function Employeesalaryincrement(@des varchar(50))
returns @EmpInfo table  
(EmpId int,Salary float) as
begin  
    insert into @EmpInfo
	select e.EmpId,s.Salary from EmpInfo e inner join EmpSalary s
	on s.EmpId=e.EmpId where e.Designation=@des;
	
update @EmpInfo set Salary=(case WHEN Designation='Manager' THEN Salary+(10*Salary)/100 
                WHEN  Designation='Backend Developer'  THEN Salary+(5*Salary)/100
                else Salary
				end);

	return;
	end;

select * from Employeesalaryincrement('Backend Developer')

select ord_date,purch_amt,
case when purch_amt>=500 then 'high'
when purch_amt<500 then 'low'
else 'normal'
end as value
from orders

create or alter procedure example1 as
declare @acc int
select @acc=max(AccNo) from AccInfo where Amt>300000;
select student.dbo.show1(@acc)


exec example1 

create or alter  procedure example2 @at varchar(19) as
declare @maxamt float
select @maxamt=max(Amt) from AccInfo where AccType=@at;
exec example1 @maxamt

exec example2 'current'

create or alter function show1(@acc int)
returns date as
begin
declare @open date
 declare @trans date
select @open=OpenedDate from BankDetails where AccNo=@acc
select @trans=(select student.dbo.show2(@open) as lasttransactiondate)
return @trans
end

select student.dbo.show1(563) as opendate

select * from BankDetails

create or alter function show2(@open date)
returns date as
begin
declare @trans date
select @trans=LastTransactionDate from BankDetails where OpenedDate=@open;
return @trans
end

select student.dbo.show2('2020-12-13') as lastdate

sp_helpextendedproc




