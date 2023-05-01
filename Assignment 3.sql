
# 1

-- Write a stored procedure that accepts the month and year as inputs and prints the ordernumber, orderdate and status of the orders placed in that month. 

-- Example:  call order_status(2005, 11);

/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `order_status`(in y int ,in m int)
BEGIN


select 
ordernumber,
orderdate,
status
from orders
where 
month(orderdate) = m and
year(orderdate) = y 
;


END
*/

call order_status(2003,2);


# 2

--  Write a stored procedure to insert a record into the cancellations table for all cancelled orders.

-- STEPS: 

-- a.	Create a table called cancellations with the following fields

-- id (primary key), 
-- customernumber (foreign key - Table customers), 
-- ordernumber (foreign key - Table Orders), 
-- comments

-- All values except id should be taken from the order table.

create table cancellations
(
id int primary key auto_increment ,
customernumber int ,
ordernumber int ,
comments varchar(100)
);

alter table cancellations
add foreign key (customernumber) references customers(customernumber);

alter table cancellations
add foreign key (ordernumber) references orders(ordernumber);


-- b. Read through the orders table . If an order is cancelled, then put an entry in the cancellations table.

/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `order_cancelled`()
BEGIN
declare cnum, ordnum, finished integer default 0;
    
	declare ord_cur cursor for
    select customernumber, ordernumber 
    from orders
    where status='cancelled';
    declare exit handler for NOT FOUND set finished = 1;
    open ord_cur;    
    
    ordloop:REPEAT
		fetch ord_cur into cnum, ordnum;
        insert into cancellations (customernumber, ordernumber) values(cnum, ordnum);
        
	until finished = 1
	end repeat ordloop;

END
*/


call order_cancelled() ;   


# 3

--  a. Write function that takes the customernumber as input and returns the purchase_status based on the following criteria . [table:Payments]

-- if the total purchase amount for the customer is < 25000 status = Silver, amount between 25000 and 50000, status = Gold
-- if amount > 50000 Platinum


/*
CREATE DEFINER=`root`@`localhost` FUNCTION `StatusCN`(CN int) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN

RETURN (select 
case
when sum(amount) < 25000 then 'Silver'
when sum(amount) between 25000 and 50000 then 'Gold'
when sum(amount) > 50000 then 'Platinum'
end
from
assignment.payments
where customernumber = CN );

END
*/


select StatusCN(103);



-- b. Write a query that displays customerNumber, customername and purchase_status from customers table.


select
customernumber,
customername,
statuscn(customernumber)
from
assignment.customers;


# 4 

--  Replicate the functionality of 'on delete cascade' and 'on update cascade' using triggers on movies and rentals tables. Note: Both tables 
--  movies and rentals - don't have primary or foreign keys. Use only triggers to implement the above.

# Update Cascate

/*
CREATE DEFINER=`root`@`localhost` TRIGGER `movies_AFTER_UPDATE` AFTER UPDATE ON `movies` FOR EACH ROW BEGIN
update rentals set movieid = new.id
    where movieid = old.id;
END
*/

# Delete Cascate

/*
CREATE DEFINER=`root`@`localhost` TRIGGER `movies_AFTER_DELETE` AFTER DELETE ON `movies` FOR EACH ROW BEGIN
delete from rentals 
   where movieid = old.id;
END
*/


set sql_safe_updates = 0;

update movies set category = 20 where id = 2;

update movies set id = 51 where title = "safe";

delete from movies where id = 1;



select * from movies;

select * from rentals;


#5

-- Select the first name of the employee who gets the third highest salary. [table: employee]

with table1 as(
select 
fname ,
salary,
row_number() over ( order by salary desc ) as number
from
employee)

select 
fname
from table1
where 
number = 3;


# 6

-- Assign a rank to each employee  based on their salary. The person having the highest salary has rank 1. [table: employee]

select
employee.*,
rank() over ( order by salary desc) as emp_rank
from employee;
