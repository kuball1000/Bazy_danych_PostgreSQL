
-- Zad. 1
select min(placa_pod) as MINIMUM, max(placa_pod) as MAKSIMUM,
max(placa_pod)-min(placa_pod) as ROZNICA from pracownicy;

-- Zad. 2
select etat, avg(placa_pod) as SREDNIA from pracownicy
group by etat order by SREDNIA desc;

-- Zad. 3
select count(*) as PROFESOROWIE from pracownicy
where etat = 'PROFESOR';

-- Zad. 4
select id_zesp, sum(placa_pod) + sum(placa_dod) as SUMARYCZNE_PLACE
from pracownicy group by id_zesp order by id_zesp;

-- Zad. 5
select max(suma) as MAX_SUM_PLACA
from (select sum(placa_pod) + sum(placa_dod) as suma
from pracownicy group by id_zesp);

-- Zad. 6
select id_szefa,
min(placa_pod) as MINIMALNA
from pracownicy where id_szefa is not null
group by id_szefa
order by MINIMALNA DESC;

-- Zad. 7
select id_zesp, count(*) as ILU_PRACUJE from pracownicy
group by id_zesp order by ILU_PRACUJE DESC; 

-- Zad. 8
select id_zesp, count(*) as ILU_PRACUJE from pracownicy
group by id_zesp having count(*) > 3 order by ILU_PRACUJE DESC; 

-- Zad. 9
select id_prac, count(*) from pracownicy
group by id_prac having count(*) > 1;

-- Zad. 10
select etat, avg(placa_pod) as SREDNIA,
count(*) as LICZBA from pracownicy
where zatrudniony < DATE '1990-01-01'
group by etat order by etat;

-- Zad. 11
select id_zesp, etat,
round(avg(placa_pod + coalesce(placa_dod, 0)), 0) as SREDNIA,
round(max(placa_pod + coalesce(placa_dod, 0)), 0) as MAKSYMALNA
from pracownicy where etat in ('ASYSTENT', 'PROFESOR') 
group by id_zesp, etat
order by id_zesp, etat;

-- Zad. 12
select extract(year from zatrudniony) as ROK, count(*)
from pracownicy group by extract(year from zatrudniony)
order by ROK;

-- Zad. 13
select length(nazwisko) as ILE_LITER, count(*) as W_ILU_NAZWISKACH
from pracownicy group by length(nazwisko) order by ILE_LITER;

-- Zad. 14
select count(*) as Ile_nazwisk_z_A from pracownicy
where nazwisko like '%A%' or nazwisko like '%a%';

-- Zad. 15
select
sum(case
    when nazwisko like '%A%' or nazwisko like '%a%' then 1
    else 0
end) as ILE_NAZWISK_Z_A,
sum(case
    when nazwisko like '%E%' or nazwisko like '%e%' then 1
    else 0
end) as ILE_NAZWISK_Z_E
from pracownicy;

-- Zad. 16
select id_zesp, sum(placa_pod) as SUMA_PLAC,
string_agg(nazwisko || ':' || placa_pod, ';' order by nazwisko) as PRACOWNICY
from pracownicy group by id_zesp order by id_zesp;
