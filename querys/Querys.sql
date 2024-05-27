create database music
use music
-----1. Who is the senior most employee based on job title? 
Select top 1 first_name , last_name ,title 
from employee
order by levels desc 
select * from employee
--2. Which countries have the most Invoices? 
select count(*) as total_invoice, (billing_country )as c
from invoice
group by billing_country
order by total_invoice desc

select * from invoice
select * from invoice_line
--3. What are top 3 values of total invoice? 
select top 3 invoice_id, sum(unit_price*quantity) as Price
from invoice_line
group by invoice_id
order by price desc 



--4. Which city has the best customers? We would like to throw a promotional Music 
--Festival in the city we made the most money. Write a query that returns one city that 
--has the highest sum of invoice totals. Return both the city name & sum of all invoice 
---totals 
select billing_country ,billing_city , sum(total) as T
from invoice
group by billing_country,billing_city
order by T desc

--5. Who is the best customer? The customer who has spent the most money will be 
--declared the best customer. Write a query that returns the person who has spent the 
--most money 
select * from customer
select first_name ,last_name,sum(total)as t
from invoice
join customer
on customer.customer_id=invoice.customer_id
group by customer.first_name,customer.last_name
order by t desc

--. Write query to return the email, first name, last name, & Genre of all Rock Music 
--listeners. Return your list ordered alphabetically by email starting with A 

select distinct  email,first_name,last_name,genre.name 
from genre
join track on track.genre_id=genre.genre_id
join invoice_line on invoice_line.track_id=track.track_id
join invoice on invoice.invoice_id=invoice_line.invoice_id
join customer on customer.customer_id=invoice.customer_id
where genre.name like 'Rock'
order by email 

--2. Let's invite the artists who have written the most rock music in our dataset.
--Write a query that returns the Artist name and total track count of the top 10 rock bands
select top 10   artist.name , count (genre.name) as count
from genre
join track
on genre.genre_id=track.genre_id
join album
on track.album_id=album.album_id
join artist
on album.artist_id=artist.artist_id

where genre.name like 'Rock'
group by artist.name
order by count desc



-- 3. Return all the track names that have a song length longer than the average song length.
--Return the Name and Milliseconds for each track. 
--Order by the song length with the longest songs listed first
Select * from track
select name , milliseconds
from track
where milliseconds>(
select avg(milliseconds)
from track)
order by milliseconds desc

--1. Find how much amount spent by each customer on artists? Write a query to return 
--customer name, artist name and total spent 

select distinct customer.first_name,customer.last_name , artist.name, sum(invoice_line.quantity*invoice_line.unit_price) as t 
from artist join album on artist.artist_id=album.artist_id
 join track on album.album_id=track.album_id
 join invoice_line on track.track_id=invoice_line.track_id
join invoice on invoice.invoice_id=invoice_line.invoice_id
join customer on customer.customer_id=invoice.customer_id
group by customer.first_name,customer.last_name , artist.name
order by t desc


--2. We want to find out the most popular music Genre for each country. We determine the 
--most popular genre as the genre with the highest amount of purchases. Write a query 
--that returns each country along with the top Genre. For countries where the maximum 
--number of purchases is shared return all Genres 
select invoice.billing_country as country, genre.name,count(genre.name) as genre 
from genre join track on genre.genre_id=track.genre_id
join invoice_line on invoice_line.track_id=track.track_id
join invoice on invoice.invoice_id=invoice_line.invoice_id
group by invoice.billing_country, genre.name
order by country ,genre desc

select * from track



--3. Write a query that determines the customer that has spent the most on music for each 
--country. Write a query that returns the country along with the top customer and how 
--much they spent. For countries where the top amount spent is shared, provide all 
--customers who spent this amount */




select customer.country,customer.first_name,customer.last_name, sum(invoice.total)  as t
from invoice join customer on invoice.customer_id=customer.customer_id
group by customer.country,customer.first_name,customer.last_name
order by  t desc



