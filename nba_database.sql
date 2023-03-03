create table tara(
id_tara number(3) primary key,
denumire_tara varchar2(10) not null,
continent varchar2(10) not null);

create table arena(
id_arena number(3) primary key,
denumire_arena varchar(10) not null,
capacitate number(7) not null,
id_tara NUMBER references tara(id_tara));

create table antrenori(
id_antrenor number(3) primary key,
nume_antrenor varchar(10) not null,
prenume_antrenor varchar(10) not null);

create table sponsori(
id_sponsor number(3) primary key,
denumire_sponsor varchar(10) not null);


create table echipa(
id_echipa number(3) primary key,
denumire_echipa varchar(10) not null);

create table jucatori(
id_jucator number(3) primary key,
nume_jucator varchar(10) not null,
prenume_jucator varchar(10) not null,
id_echipa NUMBER references echipa(id_echipa));

create table meciuri(
id_meci number(3) primary key,
data date not null,
scor number(5) not null,
id_arena NUMBER references arena(id_arena),
id_echipa1 NUMBER references echipa(id_echipa),
id_echipa2 NUMBER references echipa(id_echipa));

alter table echipa
add id_sponsor NUMBER references sponsori(id_sponsor);
alter table echipa
add id_antrenori NUMBER references antrenori(id_antrenor);

alter table meciuri(
drop column scor
add scor_echipa1 number(3) not null
add scor_echipa2 number(3)not null);

--Inserting the data

insert into meciuri(id_meci,data,id_arena,id_echipa1,id_echipa2,scor_echipa1,scor_echipa2)
values (1,'1-NOV-2022',1,1,2,88,90);

insert into meciuri(id_meci,data,id_arena,id_echipa1,id_echipa2,scor_echipa1,scor_echipa2)
values (2,'3-NOV-2022',2,1,5,95,89);

insert into meciuri(id_meci,data,id_arena,id_echipa1,id_echipa2,scor_echipa1,scor_echipa2)
values (3,'8-NOV-2022',2,3,6,100,90);

insert into meciuri(id_meci,data,id_arena,id_echipa1,id_echipa2,scor_echipa1,scor_echipa2)
values (5,'3-NOV-2022',5,4,2,110,107);

insert into meciuri(id_meci,data,id_arena,id_echipa1,id_echipa2,scor_echipa1,scor_echipa2)
values (4,'7-NOV-2022',9,7,6,88,90);

insert into meciuri(id_meci,data,id_arena,id_echipa1,id_echipa2,scor_echipa1,scor_echipa2)
values (6,'20-DEC-2022',7,3,4,131,111);

insert into meciuri(id_meci,data,id_arena,id_echipa1,id_echipa2,scor_echipa1,scor_echipa2)
values (7,'1-DEC-2022',5,5,6,105,98);


insert into meciuri(id_meci,data,id_arena,id_echipa1,id_echipa2,scor_echipa1,scor_echipa2)
values (8,'4-DEC-2022',8,7,8,94,110);


insert into meciuri(id_meci,data,id_arena,id_echipa1,id_echipa2,scor_echipa1,scor_echipa2)
values (14,'17-DEC-2022',1,1,8,90,91);

insert into meciuri(id_meci,data,id_arena,id_echipa1,id_echipa2,scor_echipa1,scor_echipa2)
values (9,'14-NOV-2022',3,5,8,108,80);

--Practicing SQL commands

--Actualization commands

--Delete the column 'continent' from the 'tara' table.
alter table tara
drop column continent;


--Updating the capacity of the arena with ID 3. 
update arena
set capacitate=21300
where id_arena=3;


--Updating the score of team 1 in the match with ID_match=1 
update meciuriset scor_Echipa1=90
where id_meci=1;


--Updating the name of the first sponsor from RedBULL to Redbull
update sponsori
set denumire_sponsor='Redbull'
where id_sponsor=1;

--Update the match ID from ID_match=14 to ID_match=10
update meciuri
set id_meci=10
where id_meci=14;

--Joints

--Display the teams that are sponsored by Adidas
select e.denumire_echipa
from echipa e,sponsori s
where e.id_sponsor=s.id_sponsor and s.denumire_sponsor='Adidas';

--Display the players of the Lakers team
select j.nume_jucator||' '||j.prenume_jucator as jucator
from jucatori j,echipa e
where j.id_echipa=e.id_echipa and e.denumire_echipa='Lakers';

--Group functios

--Display the number of teams coached by Brown Larry
select count(e.id_echipa)
from echipa e,antrenori a
where e.id_antrenori=a.id_antrenor and a.nume_antrenor='Brown'
group by e.id_antrenori,a.nume_antrenor;

--Display the number of matches played in the arena with ID 5
select count(m.id_meci)
from meciuri m
where m.id_arena=5
group by m.id_arena;

--Display the number of matches played at Phillips Arena
select count(m.id_meci)
from meciuri m,arena a
where m.id_arena=a.id_arena and a.denumire_arena='Philips Arena'
group by a.denumire_arena,m.id_arena;

--Subqueries

--Display the country where the arena with the highest capacity belongs to
select denumire_tara 
from tara t,arena a
where t.id_tara=a.id_tara and a.capacitate=(select max(a.capacitate)from arena a);

--Display the names of the home teams that have scored more points in a match than the average points scored by the home teams (with ID_team1)
select DISTINCT e.denumire_echipa
from echipa e,meciuri m
where m.id_echipa1=e.id_echipa and m.scor_echipa1>(select avg(scor_echipa1) from meciuri );


--Display the home team that scored the most points in a match
select e.denumire_echipa
from echipa e,meciuri m
where e.id_echipa=m.id_echipa1 and m.scor_echipa1=(select max(scor_echipa1) from meciuri m);

--Display the date of the match where the most points were scored
select data
from meciuri
where scor_echipa1+scor_echipa2=(select max(scor_echipa1+scor_echipa2)from meciuri);

--Virtual tables

--Create a virtual table that contains the teams sponsored by Nike
create view sponsorizate_de_Nike as
select e.denumire_echipa
from echipa e,sponsori s
where e.id_sponsor=s.id_sponsor and s.denumire_sponsor='Nike';
select * from sponsorizate_de_nike;

--Create a virtual table that contains the players coached by the coach with ID 1
create view jucatori_antrenor_1 as
select j.nume_jucator 
from antrenori a,echipa e,jucatori j
where e.id_antrenori=a.id_antrenor and j.id_echipa=e.id_echipa and a.id_antrenor=1;
select* from jucatori_antrenor_1;

--Create a virtual table that contains the matches of the Chicago Bulls team
create view meciuri_bulls as
select m.id_meci
from meciuri m,echipa e
where m.id_echipa1=e.id_echipa or m.id_echipa2=e.id_echipa and e.denumire_echipa='Chicago Bulls';
select * from meciuri_bulls;


