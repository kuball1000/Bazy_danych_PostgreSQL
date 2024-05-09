-- Zadanie 1
select * from zespoly order by id_zesp;

-- Zadanie 2
select * from pracownicy order by id_prac;

-- Zadanie 3
select nazwisko, placa_pod*12 as ROCZNA_PLACA from pracownicy order by nazwisko;

-- Zadanie 4
select nazwisko, etat, placa_pod+ coalesce(placa_dod, 0) as MIESIECZNE_ZAROBKI 
from pracownicy order by miesieczne_zarobki desc;

-- Zadanie 5
select * from zespoly order by nazwa;

-- Zadanie 6
select distinct etat from pracownicy order by etat;

-- Zadanie 7
select * from pracownicy where etat='ASYSTENT' order by nazwisko;

-- Zadanie 8
select id_prac, nazwisko, etat, placa_pod, id_zesp 
from pracownicy where id_zesp=30 or id_zesp=40 order by placa_pod desc;

-- Zadanie 9
select nazwisko, id_zesp, placa_pod 
from pracownicy where placa_pod between 300 and 800 order by nazwisko;

-- Zadanie 10
select nazwisko, etat, id_zesp 
from pracownicy where nazwisko like '%SKI' order by nazwisko;

-- Zadanie 11
select id_prac, id_szefa, nazwisko, placa_pod 
from pracownicy where placa_pod > 1000 and id_szefa is not null;

-- Zadanie 12
select nazwisko, id_zesp from pracownicy 
where id_zesp=20 and (nazwisko like 'M%' or nazwisko like '%SKI') order by nazwisko;

-- Zadanie 13
select nazwisko, etat, placa_pod/(20*8) as STAWKA from pracownicy 
where etat not in ('ADIUTANT', 'ASYSTENT', 'STAZYSTA') and placa_pod not between 400 and 800 order by STAWKA;

-- Zadanie 14
select nazwisko, etat, placa_pod, placa_dod from pracownicy 
where placa_pod+coalesce(placa_dod, 0) > 1000 order by etat, nazwisko;

15. select nazwisko || ' PRACUJE OD ' || zatrudniony || ' I ZARABIA ' || placa_pod as PROFESOROWIE from pracownicy where etat='PROFESOR' order by placa_pod desc;
