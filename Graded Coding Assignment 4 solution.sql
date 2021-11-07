create schema travelonthego;
use travelonthego;

/* 
1) You are required to create two tables PASSENGER and PRICE with the following
attributes and properties
PASSENGER
(Passenger_name varchar
Category varchar
Gender varchar
Boarding_City varchar
Destination_City varchar
Distance int
Bus_Type varchar
);
PRICE
(
Bus_Type varchar
Distance int
Price int
)
*/

create table PASSENGER
(Passenger_name varchar(50),
 Category varchar(50),
 Gender varchar(50),
 Boarding_City varchar(50),
 Destination_City varchar(50),
 Distance int,
 Bus_Type varchar(50)
);

create table PRICE
(
Bus_Type varchar(50),
Distance int,
Price int
);

/* 2) Insert the following data in the tables
Passenger_nam Category Gender Boarding_City Destination_City Distance Bus_Type
Sejal AC F Bengaluru Chennai 350 Sleeper
Anmol Non-AC M Mumbai Hyderabad 700 Sitting
Pallavi AC F Panaji Bengaluru 600 Sleeper
Khusboo AC F Chennai Mumbai 1500 Sleeper
Udit Non-AC M Trivandrum panaji 1000 Sleeper
Ankur AC M Nagpur Hyderabad 500 Sitting
Hemant Non-AC M panaji Mumbai 700 Sleeper
Manish Non-AC M Hyderabad Bengaluru 500 Sitting
Piyush AC M Pune Nagpur 700 Sitting
Bus_Type Distance Price
Sleeper 350 770
Sleeper 500 1100
Sleeper 600 1320
Sleeper 700 1540
Sleeper 1000 2200
Sleeper 1200 2640
Sleeper 350 434
Sitting 500 620
Sitting 500 620
Sitting 600 744
Sitting 700 868
Sitting 1000 1240
Sitting 1200 1488
Sitting 1500 1860*/

insert into PASSENGER
values
('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper'),
('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting'),
('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper'),
('Khusboo', 'AC', 'F' ,'Chennai', 'Mumbai', 1500, 'Sleeper'),
('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000, 'Sleeper'),
('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting'),
('Hemant', 'Non-AC', 'M', 'panaji', 'Mumbai', 700, 'Sleeper'),
('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting'),
('Piyush', 'AC','M', 'Pune', 'Nagpur', 700, 'Sitting');


/*
Bus_Type Distance Price
Sleeper 350 770
Sleeper 500 1100
Sleeper 600 1320
Sleeper 700 1540
Sleeper 1000 2200
Sleeper 1200 2640
Sleeper 350 434
Sitting 500 620
Sitting 500 620
Sitting 600 744
Sitting 700 868
Sitting 1000 1240
Sitting 1200 1488
Sitting 1500 1860*/
insert into price
values
('Sleeper', 350, 770),
('Sleeper', 500, 1100),
('Sleeper', 600, 1320),
('Sleeper', 700, 1540),
('Sleeper',1000, 2200),
('Sleeper', 1200, 2640),
('Sleeper', 350, 434),
('Sitting', 500, 620),
('Sitting', 500, 620),
('Sitting', 600, 744),
('Sitting', 700, 868),
('Sitting', 1000, 1240),
('Sitting', 1200, 1488),
('Sitting', 1500, 1860);

/* 3) How many females and how many male passengers travelled for a minimum distance of 600 KM s?*/
select Gender,count(Gender) from passenger where distance >=600 group by Gender;

/*4) Find the minimum ticket price for Sleeper Bus.*/
select Bus_Type,MIN(price) as Minimum_Price from price where Bus_Type='sleeper';

/*5) Select passenger names whose names start with character 'S'*/
Select Passenger_name from  passenger where Passenger_name like 'S%';

/*6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output*/
select Passenger_name,Boarding_City,Destination_City,pr.Bus_Type,pr.price 
from passenger as pa
inner join
price as pr
on pa.Distance = pr.Distance and pa.Bus_Type=pr.Bus_Type;

/*7) What is the passenger name and his/her ticket price who travelled in Sitting bus for a
distance of 1000 KM s*/
select pa.Passenger_name, price from
price as pr
inner join
(select Passenger_name, Distance as pa_Distance,Bus_Type as pa_bus_type from passenger where Bus_Type='Sitting' and Distance=1000) as pa
on pr.Distance=pa_Distance and pr.Bus_Type=pa_bus_type;

/*8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?*/

select Bus_Type,price from price
where 
Distance = (select Distance from Passenger where Passenger_name ='Pallavi' and ((Boarding_City='Bengaluru' and Destination_City='Panaji' ) or ( Boarding_City='Panaji' and Destination_City='Bengaluru')) );
 
/*9) List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order.*/
select Distinct(Distance) from passenger order by  Distance desc;

/*10) Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables*/
select Passenger_name,ROUND(((distance * 100.0)/(select sum(distance) from passenger)),2) as Percentage_of_Distance from passenger group by Passenger_name;

/*11) Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise*/

 select Distance, price, 
 CASE
  WHEN price > 1000 THEN 'Expensive'
  WHEN price > 500 and price < 1000 THEN 'Average Cost'
  ELSE 'Cheap' 
END  as Category
from price
;
