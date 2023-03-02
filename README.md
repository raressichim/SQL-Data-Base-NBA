# SQL-Data-Base-for-NBA-games-management
--The project provides an SQL database management system for NBA games, allowing for the efficient organization and analysis of game data.

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
2-Adaugarea datelor
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

--stergerea coloanei continent din tabela tara
alter table tara
drop column continent;


--actualizarea capacitatii arenei cu id ul 3 
update arena
set capacitate=21300
where id_arena=3;


--actualizarea scorului echipei 1 in meciul cu id_meci=1 
update meciuriset scor_Echipa1=90
where id_meci=1;


--actualizarea numelui primul sponsor din RedBULL -> Redbull
update sponsori
set denumire_sponsor='Redbull'
where id_sponsor=1;

--actualizarea id-ului meciului cu id_meci=14 -> id_meci=10
update meciuri
set id_meci=10
where id_meci=14;

--Joints

--sa se afiseze echipele care sunt sponsorizate de Adidas
select e.denumire_echipa
from echipa e,sponsori s
where e.id_sponsor=s.id_sponsor and s.denumire_sponsor='Adidas';

--sa se afiseze jucatorii echipei Lakers
select j.nume_jucator||' '||j.prenume_jucator as jucator
from jucatori j,echipa e
where j.id_echipa=e.id_echipa and e.denumire_echipa='Lakers';

--Group functios

--sa se afiseze numarul echipelor antrenate de Brown Larry
select count(e.id_echipa)
from echipa e,antrenori a
where e.id_antrenori=a.id_antrenor and a.nume_antrenor='Brown'
group by e.id_antrenori,a.nume_antrenor;

--sa se afiseze numarul meciurilor jucate in arena cu id-ul 5
select count(m.id_meci)
from meciuri m
where m.id_arena=5
group by m.id_arena;

--sa se afiseze cate meciuri s-au jucat in arena Phillips
select count(m.id_meci)
from meciuri m,arena a
where m.id_arena=a.id_arena and a.denumire_arena='Philips Arena'
group by a.denumire_arena,m.id_arena;

--Subqueries

--sa se afiseze tara din care face parte arena cu cea mai mare capacitate
select denumire_tara 
from tara t,arena a
where t.id_tara=a.id_tara and a.capacitate=(select max(a.capacitate)from arena a);

--sa se afiseze numele echipelor gazda ce au inscris mai multe puncte intr-un meci decat media punctelor inscrise de echipele gazda(id_echipa1)
select DISTINCT e.denumire_echipa
from echipa e,meciuri m
where m.id_echipa1=e.id_echipa and m.scor_echipa1>(select avg(scor_echipa1) from meciuri );


--sa se afiseze echipa gazda care a inscris cele mai multe puncte intr-un meci
select e.denumire_echipa
from echipa e,meciuri m
where e.id_echipa=m.id_echipa1 and m.scor_echipa1=(select max(scor_echipa1) from meciuri m);

--sa se afiseze data meciului in care s-au inscris cele mai multe puncte
select data
from meciuri
where scor_echipa1+scor_echipa2=(select max(scor_echipa1+scor_echipa2)from meciuri);

--Virtual tables

--sa se creeze o tabela virtuala care sa contina echipele sponsorizate de Nike
create view sponsorizate_de_Nike as
select e.denumire_echipa
from echipa e,sponsori s
where e.id_sponsor=s.id_sponsor and s.denumire_sponsor='Nike';
select * from sponsorizate_de_nike;

--sa se creeze o tabela virtuala care sa contina jucatorii antrenati de antrenorul cu id 1
create view jucatori_antrenor_1 as
select j.nume_jucator 
from antrenori a,echipa e,jucatori j
where e.id_antrenori=a.id_antrenor and j.id_echipa=e.id_echipa and a.id_antrenor=1;
select* from jucatori_antrenor_1;

--sa se creeze o tabela virtuala ce contine meciurile echipei Chicago Bulls
create view meciuri_bulls as
select m.id_meci
from meciuri m,echipa e
where m.id_echipa1=e.id_echipa or m.id_echipa2=e.id_echipa and e.denumire_echipa='Chicago Bulls';
select * from meciuri_bulls;


