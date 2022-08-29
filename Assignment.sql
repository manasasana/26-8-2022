1.Write a simple stored procedure to get the total of a particular student and call another stored 
procedure to list all the students with marks below than that student.

create or alter procedure totalofstudent1 @t int as
declare @total1 int
select @total1=sum(Maths+Economics+Commerce+English+ComputerScience) from results where @total1<@t group by id;

exec totalofstudent1 437

create or alter procedure totalofstudent @id int as
declare @total int
select @total=sum(Maths+Economics+Commerce+English+ComputerScience) from results  where id=@id;
exec totalofstudent1 @total

exec totalofstudent 1 

2.Write a Stored Procedure to fetch the rate of interest for a specific account type. Pass this ROI to a function, 
calculate the interest inside the function and display the interest on screen.

create function showinterest(@at varchar(10)) 
returns @AccInfo table  
(Cid int,Amt float) as
begin  
    insert into @AccInfo
	select Cid,Amt from AccInfo where AccType=@at;
	
update @AccInfo set Amt=(case WHEN @at='Savings' THEN Amt+(10*Amt)/100 
                WHEN  @at='current'  THEN Amt+(5*Amt)/100
                else Amt
				end);

	return;
	end; 

create or alter procedure interest @at varchar(10) as
select * from showinterest(@at)

exec interest 'savings'

3.Write a UDF to get the sales values of a particular region. Call another function within to calculate the average sales of that region.
Input: for example, Delhi

create type salesval as table(
salesval int
)

select * from @salesval

create or alter function avgsales(@salesval salesval READONLY)
returns int as
begin
declare @avg int
select @avg=(select avg(salesval) from @salesval) 
return @avg
end;


create  or alter function salesvalue(@region varchar(10))
returns int as
begin
declare @avg int
declare @salesval as salesval
insert into @salesval
select Amt from Sales where Region=@region;
select @avg=(select dbo.avgsales(@salesval))
return @avg
end;

select dbo.salesvalue('delhi') as average
