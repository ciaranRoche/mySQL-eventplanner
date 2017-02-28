create database eventplanner;
use eventplanner;

create table client(
ClientID int,
ClientName varchar(100) not null,
ClientAddress varchar(50),
ClientDOB date,
ClientGender char(1) check (ClientGender in ('f','m','o')),
/*ClientPhone char(10),*/
ClientEmail varchar(50),
ClientSMS char(1) check (ClientSMS in ('y','n')),
constraint client_pk primary key (ClientID)
)engine innodb;

create table catEvent(
CatEventID int,
CatName varchar(50) default 'Birthday',
CatDescription varchar(100),
constraint catevent_pk primary key (CatEventID) 
)engine innodb;

create table event(
EventID int,
EventDate date check (EventDate > '2017-4-10'),
EventName varchar(50),
EventTheme varchar(50) default 'Celebration',
EventDescription varchar(100),
LocationBooked char(1) check(LocationBooked in ('y','n')),
Id_client int,
Id_catevent int,
constraint event_pk primary key (EventID),
constraint client_fk foreign key (Id_client) references client (ClientID),
constraint catevent_fk foreign key (Id_catevent) references catEvent (CatEventID)
)engine innodb;


/*Please note i forgot to add this to my client table, dropping the table and
re doing it was sending me an error and to save time i altered the table and just changed
your script to populate the table by moving the client number to the last position*/
alter table client add ClientPhone char(10);

/*question 3 insert*/
insert into client values (11222, 'Fergal Hanlon', 'Cavan',  '1960-09-30', 'm', 
'f.hanlon@gmail.com', 'n', '0854562189');

/*question 3 insert*/
insert into catevent values (6, 'Retirement', 'Work Retirement Lunch');

/*question 3 insert*/
insert into event values (15, '2017-5-12', 'WIT Retirement', 'Next Horizons', 'Group Retirement Lunch', 'y', 11222, 6);

/*question 4 alter event table*/
alter table event add duration int default 4;

/*question 5 alter client table*/
alter table client modify ClientAddress varchar(100);

/*question 6 return DOB youngest*/
select * from client where ClientDOB = (select min(ClientDOB) from client);

/*question 7 return all events from sarah*/
select ClientID from client where ClientName = "Sarah Minchin";
select count(eventName) from event where Id_client = 12445;

/*question 8 count events by theme*/
select count(eventName) from event where EventTheme != "Celebration";

/*question 9*/
select clientID from client where clientName = "Peter Mahony";
select eventDescription from event where Id_client = 18845;

/*question 10*/
select clientName, ClientID, EventID from client, event;

/*question 11*/
update event set LocationBooked = 'n' where LocationBooked = null;

/*question 12*/
delete from event where LocationBooked = 'n';
/*question 13*/
rollback;

/*question 14*/
select clientName as name, clientAddress as Address, clientEmail as email, clientPhone as "phone number" from client;

/*question 15*/
select * from event where eventDescription like '%dinner%';

/*question 16*/
select * from catevent where CatDescription = null;

/*question 17*/
select distinct eventTheme from event;