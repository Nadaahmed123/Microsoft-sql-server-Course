--1.	Create a stored procedure that calculates the sum of a given range of numbers

alter proc  sp_calculate_sum @start_number int,@end_number int,@sum_result int output
as begin
  DECLARE @current_number int = @start_number;
  DECLARE @total_sum int= 0;

  while @current_number <= @end_number
  begin
    set @total_sum = @total_sum + @current_number;
    set @current_number = @current_number + 1;
  end;



DECLARE @start int = 1;
DECLARE @end int = 3;
DECLARE @sum int;

exec sp_calculate_sum @start_number = @start, @end_number = @end, @sum_result = @sum output;

SELECT @sum;

--2.	Create a stored procedure that calculates the area of a circle given its radius
create proc calculate_circle_area @radius float, @area float OUTPUT
as begin
  set @area = PI() * POWER(@radius, 2);
end;
declare @r float = 7.0;
declare @area FLOAT;

exec calculate_circle_area @radius = @r, @area = @area OUTPUT;

select @area;

--3.	Create a stored procedure that calculates the age category based on a person's age 
--( Note: IF Age < 18 then Category is Child and if  Age >= 18 AND Age < 60 then Category 
--is Adult otherwise  Category is Senior)
create proc calculate_age_category
  @age int,
  @category varchar(10) output
as begin
  if @age < 18
    set @category = 'Child';
  else if @age >= 18 AND @age < 60
    set  @category = 'Adult';
  else
    set @category = 'Senior';
end;

DECLARE @age int = 23;
DECLARE @category varchar(10);

EXEC calculate_age_category @age = @age, @category = @category output;

SELECT @category;

--
--4.	Create a stored procedure that determines the maximum, minimum, and average 
--of a given set of numbers ( Note : set of numbers as Numbers = '5, 10, 15, 20, 25')


create proc Calculate @Numbers varchar(max)
as begin
    declare @MaxValue int, @MinValue int, @AvgValue decimal(10,2);

    DECLARE @t TABLE (Number int);
    INSERT INTO @t
    SELECT value FROM STRING_SPLIT(@Numbers, ',');

    SELECT @MaxValue = max(Number),
	@MinValue = min(Number),
	@AvgValue = avg(Number)
    from @t;

    select @MaxValue AS Maximum, @MinValue AS Minimum, @AvgValue AS Average;
end

exec Calculate @Numbers = '5,10,15,20,25';

