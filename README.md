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
