-- ---------------------------
-- Andrew Scott 
-- MYSQL Homework April 2019
-- ---------------------------
use sakila;

-- 1a
select first_name, last_name
from actor;

-- 1b
select UPPER(concat(first_name, ' ', last_name)) as 'Actor Name'
from actor;

-- 2a
select actor_id, first_name, last_name
from actor
where first_name='Joe';

-- 2b
select actor_id, first_name, last_name
from actor
where last_name like '%GEN%';

-- 2c
select actor_id, last_name, first_name
from actor
where last_name like '%LI%'
order by last_name, first_name desc;

-- 2d 
select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a
ALTER TABLE actor 
ADD description blob;

-- 3b
ALTER TABLE actor
DROP COLUMN description;

-- 4a
select last_name, COUNT(last_name) as count_last_name
from actor
group by last_name
order by count_last_name desc;

-- 4b
select last_name, COUNT(last_name) as count_last_name
from actor
group by last_name
having count_last_name  >=2
order by count_last_name desc;

-- 4c
UPDATE actor
SET first_name = 'HARPO', last_name= 'WILLIAMS'
WHERE first_name = 'GROUCHO' AND last_name='WILLIAMS';

-- 4d
UPDATE actor
SET first_name = replace(first_name,"HARPO", "GROUCHO");

-- 5a
show create table address;

-- 6a 
select staff.last_name, staff.first_name, address.address
from staff
left join address on staff.address_id=address.address_id;

-- 6b 
select staff.last_name, staff.first_name, sum(payment.amount) as total
from staff
inner join payment on staff.staff_id=payment.staff_id
group by staff.last_name, staff.first_name;

-- 6c



select * 
from staff;

select * from payment;