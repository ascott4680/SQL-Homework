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

-- 'CREATE TABLE `address` (
--   `address_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
--   `address` varchar(50) NOT NULL,
--   `address2` varchar(50) DEFAULT NULL,
--   `district` varchar(20) NOT NULL,
--   `city_id` smallint(5) unsigned NOT NULL,
--   `postal_code` varchar(10) DEFAULT NULL,
--   `phone` varchar(20) NOT NULL,
--   `location` geometry NOT NULL,
--   `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--   PRIMARY KEY (`address_id`),
--   KEY `idx_fk_city_id` (`city_id`),
--   SPATIAL KEY `idx_location` (`location`),
--   CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON UPDATE CASCADE
-- ) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8'

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
select film.title, sum(film_actor.actor_id) as total_actors
from film
inner join film_actor on film_actor.film_id = film.film_id
group by film.title;

-- 6d
select film.title, sum(inventory.film_id) as total_copies
from film
inner join inventory on film.film_id = inventory.film_id
where title='Hunchback Impossible'
group by film.title;

-- 6d There are 2,634 copies of Hunchback Impossible --

-- 6e
select customer.first_name, customer.last_name, sum(payment.amount) as 'Total Amount Paid'
from customer
inner join payment on customer.customer_id=payment.customer_id
group by customer.last_name, customer.first_name
order by customer.last_name asc;

-- 7a
select title
from film
where title like 'K%' or title like 'Q%'
and language_id IN
	(
		select language_id from language
		where name = 'English'
        );

-- 7b
select actor.first_name, actor.last_name
from actor
where actor_id in
(
	select actor_id
	from film_actor
	where film_id =
	(
		select film_id
		from film
		where title = 'Alone Trip'
    ));

-- 7c
select customer.last_name, customer.first_name, customer.email, country.country
from customer
inner join address on customer.address_id = address.address_id
inner join city on city.city_id = address.city_id
inner join country on city.country_id = country.country_id
where country = 'Canada';

-- 7d 
select film.title , category.name as 'Film Category'
from film
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
where category.name= 'Family';

-- 7e
select film.title, count(rental.inventory_id) as total_rentals
from film
inner join inventory on inventory.film_id = film.film_id
inner join rental on rental.inventory_id = inventory.inventory_id
group by film.title
order by total_rentals desc;

-- 7f
select store.store_id as 'Store Number', sum(payment.amount) as 'Total Sales'
from store
inner join staff on store.store_id = staff.store_id
inner join payment on payment.staff_id = staff.staff_id
group by store.store_id;

-- 7g
select store.store_id as 'Store ID', city.city, country.country
from store
join address on address.address_id = store.address_id
join city on city.city_id = address.city_id
join country on city.country_id = country.country_id;

-- 7h
select  category.name as 'Film Category', sum(payment.amount) as 'Gross Revenue'
from category
join film_category on film_category.category_id = category.category_id
join inventory on inventory.film_id = film_category.film_id
join rental on rental.inventory_id = inventory.inventory_id
join payment on  payment.rental_id = rental.rental_id
group by category.name
order  by sum(payment.amount) desc;

-- 8a
create view top_five_genre as
select  category.name as 'Film Category', sum(payment.amount) as 'Gross Revenue'
from category
join film_category on film_category.category_id = category.category_id
join inventory on inventory.film_id = film_category.film_id
join rental on rental.inventory_id = inventory.inventory_id
join payment on  payment.rental_id = rental.rental_id
group by category.name
order  by sum(payment.amount) desc
limit 5;

-- 8b
select * 
from top_five_genre;

-- 8c
drop view top_five_genre;