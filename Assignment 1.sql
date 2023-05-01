#1. create a database called 'assignment' (Note please do the assignment tasks in this database)
Create database Assignment;



# 2. Create the tables from ConsolidatedTables.sql and enter the records as specified in it.
Use assignment;


#3. Create a table called countries with the following columns (name, population, capital) 
   
Create table countries
(
CountryName Varchar(500)
,Population Int
,Capital Varchar(500)
);

#a) Insert the following data into the table

Insert into countries(Countryname,population,capital)
values('China', 1382 , 'Beijing')
,('India',1326,'Delhi')
,('United States',324, 'Washington D.C.')
,('Indonesia'	,260	,'Jakarta')
,('Brazil',209,'Brasilia')
,('Pakistan',193,'Islamabad')
,('Nigeria',187,'Abuja')
,('Bangladesh',163,'Dhaka')
,('Russia',143,'Moscow')
,('Mexico',128,'Mexico City')
,('Japan',126,'Tokyo')
,('Philippines',102,'Manila')
,('Ethiopia',101,'Addis Ababa')
,('Vietnam',94,'Hanoi')
,('Egypt',93,'Cairo')
,('German',81,'Berlin')
,('Iran',80	,'Tehran')
,('Turkey',79,'Ankara')
,('Congo',79,'Kinshasa')
,('France',64,'Paris')
,('United Kingdom',65,'London')
,('Italy',60,'Rome')
,('South Africa',55	,'Pretoria')
,('Myanmar',54,'Naypyidaw');

select * from countries;

#b) Add a couple of countries of your choice

insert into countries
values('Argentina',17,'Buenos Aires')
,('Andorra',164, 'Andorra la Vella');

#c) Change ‘Delhi' to ‘New Delhi'
set sql_safe_updates=0;

update big_countries
set capital
=replace(capital, 'Delhi','New Delhi');

select* from big_countries;
# 4. Rename the table countries to big_countries .

rename table Countries to big_countries;

#5. Create the following tables. Use auto increment wherever applicable

#a. Product
#product_id - primary key
#product_name - cannot be null and only unique values are allowed
#description
#supplier_id - foreign key of supplier table

Create table Product
(
Product_id int primary key auto_increment
,Product_name varchar(500) not null
,description varchar(500)
,supplier_id int
);

alter table product
add constraint uk_product_Product_name
Unique(Product_name) ;

alter table product
add constraint fk_product_supplier_id
foreign key(supplier_id) references suppliers(supplier_id);


#b. Suppliers
#supplier_id - primary key
#supplier_name
#location

create table suppliers
(
supplier_id int primary key auto_increment
,supplier_name varchar(500)
,location varchar(500)
);


#c. Stock
#id - primary key
#product_id - foreign key of product table
#balance_stock

create table stock
(
Stock_id int primary key auto_increment
,Product_id int
,balance_stock int
);

alter table stock
add constraint fk_stock_product_id
foreign key(Product_id) references product(Product_id);

#6. Enter some records into the three tables.

Insert into product(product_id, product_name,description,supplier_id)
values(3,'Cement', 'weather bodycoat', 99)
,(5,'shoes', 'long running', 78)
,(7, 'Lowers', 'Best Material', 87)
,(6, 'Gold Jwellery', 'Best design',9);


#7. Modify the supplier table to make supplier name unique and not null.

alter table suppliers
add constraint uk_suppliers_supplier_name
Unique(supplier_name);




#8. Modify the emp table as follows

#a.	Add a column called deptno

alter table emp
add deptno int;

#b. Set the value of deptno in the following order

#deptno = 20 where emp_no is divisible by 2
#deptno = 30 where emp_no is divisible by 3
#deptno = 40 where emp_no is divisible by 4
#deptno = 50 where emp_no is divisible by 5
#deptno = 10 for the remaining records.

update emp
set deptno=case
when mod(emp_no,2)=0 then deptno=20
when mod(emp_no,3)=0 then deptno=30
when mod(emp_no,4)=0 then deptno=40
when mod(emp_no,5)=0 then deptno=50
else deptno=10
end;

select* from emp;

#9. Create a unique index on the emp_id column.
alter table emp
add column emp_id int;

alter table emp
add constraint uk_emp_emp_id
unique(emp_id);


#10. Create a view called emp_sal on the emp table by selecting the following fields in the order of highest salary to the lowest salary.

#emp_no, first_name, last_name, salary

create view emp_sal as
select 
emp_no , first_name ,last_name ,salary
from assignment.emp 
order by salary desc;      

select * from  emp_sal;