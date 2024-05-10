-- Zadanie 1
INSERT INTO pracownicy (id_prac, nazwisko, etat, id_szefa, zatrudniony, placa_pod, placa_dod, id_zesp)
values (250, 'KOWALSKI', 'ASYSTENT', null, DATE '2015-01-13', 1500, null, 10);

INSERT INTO pracownicy (id_prac, nazwisko, etat, id_szefa, zatrudniony, placa_pod, placa_dod, id_zesp)
values (260, 'ADAMSKI', 'ASYSTENT', null, DATE '2014-09-10', 1500, null, 10);

INSERT INTO pracownicy (id_prac, nazwisko, etat, id_szefa, zatrudniony, placa_pod, placa_dod, id_zesp)
values (270, 'NOWAK', 'ADIUNKT', null, DATE '1990-05-01', 2050, 540, 20);

select * from pracownicy p where id_prac in (250, 260, 270);


-- Zadanie 2
update pracownicy p
set (placa_pod, placa_dod) =
(select placa_pod*1.1, coalesce(1.2 * placa_dod, 100)
from pracownicy where p.id_prac = id_prac)
where id_prac in (250, 260, 270);

select * from pracownicy p where id_prac in (250, 260, 270);


-- Zadanie 3
insert into zespoly(id_zesp, nazwa, adres) values(60, 'BAZY DANYCH', 'PIOTROWO 2');

select * from zespoly where id_zesp = 60;


-- Zadanie 4
update pracownicy p
set id_zesp = (select id_zesp from zespoly where nazwa = 'BAZY DANYCH')
where id_prac in (250, 260, 270);

select * from pracownicy p where id_prac in (250, 260, 270);


-- Zadanie 5
update pracownicy p
set id_szefa = (select id_prac from pracownicy where nazwisko = 'MORZY')
where id_zesp = (select id_zesp from zespoly where nazwa = 'BAZY DANYCH');

select * from pracownicy p where id_szefa = (select id_prac from pracownicy p2 where nazwisko = 'MORZY');


-- Zadanie 6
delete from zespoly
where nazwa = 'BAZY DANYCH';

-- usunięcie z tabeli zespoly narusza klucz obcy z tabeli pracownicy


-- Zadanie 7
delete from pracownicy
where id_zesp = (select id_zesp from zespoly where nazwa = 'BAZY DANYCH');

select * from pracownicy where id_zesp = (select id_zesp from zespoly where nazwa = 'BAZY DANYCH');

delete from zespoly
where nazwa = 'BAZY DANYCH';

select * from zespoly where nazwa = 'BAZY DANYCH';


-- Zadanie 8
select nazwisko, placa_pod, średnia_w_zespole*0.1 as PODWYŻKA
from (select id_zesp, avg(placa_pod) as średnia_w_zespole
from pracownicy group by id_zesp) z
join pracownicy p on z.id_zesp = p.id_zesp
order by nazwisko;


-- Zadanie 9
update pracownicy p
set placa_pod = (select p.placa_pod + 0.1 * avg(placa_pod)
from pracownicy
group by id_zesp
having id_zesp = p.id_zesp );

select nazwisko, placa_pod from pracownicy p order by nazwisko;


-- Zadanie 10
select * from pracownicy p
order by placa_pod
fetch first 1 rows with ties;


-- Zadanie 11
update pracownicy p
set placa_pod = round((select avg(placa_pod) from pracownicy), 2)
where p.id_prac = (select id_prac
from pracownicy
order by placa_pod
fetch first 1 rows with ties);

select * from pracownicy p where id_prac = 200;


-- Zadanie 12
select nazwisko, placa_dod from pracownicy where id_zesp = 20;

update pracownicy p
set placa_dod = (select avg(placa_pod) from pracownicy p
where id_szefa = (select id_prac from pracownicy where nazwisko = 'MORZY'))
where id_zesp = 20;

select nazwisko, placa_dod from pracownicy where id_zesp = 20;


-- Zadanie 13
select nazwisko, placa_pod
from pracownicy p
where id_zesp = (select id_zesp from zespoly where nazwa = 'SYSTEMY ROZPROSZONE')
order by nazwisko;

update pracownicy p
set placa_pod = placa_pod*1.25
from (select id_zesp from zespoly
where nazwa = 'SYSTEMY ROZPROSZONE') z
where p.id_zesp = z.id_zesp;


-- Zadanie 14
select p.nazwisko as PRACOWNIK, p2.nazwisko as SZEF
from pracownicy p join pracownicy p2 on p2.id_prac = p.id_szefa
where p2.nazwisko = 'MORZY';

delete from pracownicy p
using (select id_prac
from pracownicy
where nazwisko = 'MORZY') s
where p.id_szefa = s.id_prac;


-- Zadnie 15
select * from pracownicy p
order by nazwisko;


-- Zadanie 16
CREATE SEQUENCE PRAC_SEQ
START 300
INCREMENT 10;


-- Zadanie 17
insert into pracownicy (id_prac, nazwisko, etat, placa_pod)
values (nextval('PRAC_SEQ'), 'Trąbczyński', 'STAZYSTA', 1000);

select * from pracownicy p where nazwisko = 'Trąbczyński';


-- Zadanie 18
update pracownicy
set placa_dod = currval('PRAC_SEQ')
where nazwisko = 'Trąbczyński';

select * from pracownicy p where nazwisko = 'Trąbczyński';


-- Zadanie 19
delete from pracownicy
where nazwisko = 'Trąbczyński';


-- Zadanie 20
create sequence MALA_SEQ
maxvalue 10;

select nextval('MALA_SEQ');
-- SQL ERROR : osiągnięto maksymalną wartość sekwencji


-- Zadanie 21
drop sequence MALA_SEQ;
