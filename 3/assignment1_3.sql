create database Music_DB_ass1
use Music_DB_ass1
create table Musician
(
id int primary key identity (1,1),
Name varchar(20) not null,
Ph_Number int,
city varchar(30),
Street varchar(50),

)
create table Instrument
(
Name varchar(20) primary key ,
ins_Key int
)


create table Album
(
Id int primary key,
Title varchar(50),
A_Date date,
Mus_id int references Musician(id)
)
create table Song
(
Title varchar(50) primary key,
author varchar(50) not null
)
create table Album_Song
(
Album_id int references Album(id),
Song_title varchar(50) primary key references Song(Title)
)
create table Mus_Song
(
Mus_id int references Musician(id), 
Song_title varchar(50) references Song(Title),
primary key(Mus_id,Song_title)
)
create table Mus_nstrument
(
Mus_id int references Musician(id), 
ins_Name varchar(20) references Instrument(Name)
primary key(Mus_id,ins_Name)
)