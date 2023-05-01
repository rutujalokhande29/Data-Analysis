#1. select all employees in department 10 whose salary is greater than 3000. [table: employee]
select
concat(fname, ' ', lname) as fullname
,deptno
,salary
from assignment.employee
where salary > 3000 and deptno = 10;


#2. The grading of students based on the marks they have obtained is done as follows:

#40 to 50 -> Second Class
#50 to 60 -> First Class
#60 to 80 -> First Class
#80 to 100 -> Distinctions

#a. How many students have graduated with first class?
select 
name
,marks
from assignment.students
where marks between 50 and 80 ; 


#b. How many students have obtained distinction? [table: students]
select
name
,marks
from assignment.students
where marks between 80 and 100
group by name;

#3. Get a list of city names from station with even ID numbers only. Exclude duplicates from your answer.[table: station]
select 
distinct city
,Id
from assignment.station
 where ID%2=0;


#4. Find the difference between the total number of city entries in the table and the number of distinct city entries in the table. In other words, if N is the number of city entries in station, and N1 is the number of distinct city names in station, write a query to find the value of N-N1 from station.
#[table: station]
select
count(city)-count(distinct city)
from assignment.station;

#5. Answer the following
#a. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates. [Hint: Use RIGHT() / LEFT() methods ]
select
distinct city
from assignment.station
where substr(city,1,1) in ("A","E","I","O","U");
            #OR
select
distinct city
from assignment.station
where lower(substr(city,1,1)) in ("a","e","i","o","u");

#b. Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
select
distinct city
from assignment.station
where city regexp '^[aeiou]' and city regexp '[aeiou]$';

#c. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
select
distinct city
from assignment.station
where city regexp '^[^aeiou]';
#OR
select
distinct city
from assignment.station
where lower(substr(city,0,1)) not in ('a','e','i','o','u');

#d. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates. [table: station]
 select
 distinct city
 from assignment.station 
 where regexp_like(city,'^[^AEIOUaeiou]|[^AEIOUaeiou]$');
 
 #6. Write a query that prints a list of employee names having a salary greater than $2000 per month who have been employed for less than 36 months. Sort your result by descending order of salary. [table: emp]
select
concat(first_name, " ", last_name) as Full_name
,salary
,Hire_date
from assignment.emp
where salary >2000 and hire_date>= date_sub(current_date(),interval 36 month)
order by salary desc;


#7. How much money does the company spend every month on salaries for each department? [table: employee]


#Expected Result
#----------------------
#+--------+--------------+
#| deptno | total_salary |
#+--------+--------------+
#|     10 |     20700.00 |
#|     20 |     12300.00 |
#|     30 |      1675.00 |
#+--------+--------------+
#3 rows in set (0.002 sec)

select
deptno
,sum(salary) as "Total_Money" 
from assignment.employee
group by deptno;


#8. How many cities in the CITY table have a Population larger than 100000. [table: city]
select*
from assignment.city
where population > 100000;

#9. What is the total population of California? [table: city]
select
sum(population)
from assignment.city
where district='california';



#10. What is the average population of the districts in each country? [table: city]
select
avg(population)
from assignment.city;

#11. Find the ordernumber, status, customernumber, customername and comments for all orders that are ‘Disputed=  [table: orders, customers]

select 
ordernumber, status, 
t1.customernumber, customername 
,comments
from 
assignment.orders as t1 
inner join 
assignment.customers as t2
on t1.customerNumber = t2.customerNumber
where status = 'Disputed';