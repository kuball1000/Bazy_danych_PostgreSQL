-- Zad. 1
select p.nazwisko, p.etat, p.id_zesp, z.nazwa
from pracownicy p inner join zespoly z
    on p.id_zesp = z.id_zesp
order by p.nazwisk;

-- Zad. 2
select p.nazwisko, p.etat, p.id_zesp, z.nazwa
from pracownicy p inner join zespoly z
    on p.id_zesp = z.id_zesp
where z.adres = 'PIOTROWO 3A'
order by p.nazwisko;

-- Zad. 3
select p.nazwisko, p.etat, p.placa_pod, e.placa_min, e.placa_max
from pracownicy p inner join etaty e
    on p.etat = e.nazwa
order by p.etat, p.nazwisko;

-- Zad. 4
select p.nazwisko, p.etat, p.placa_pod, e.placa_min, e.placa_max,
case when p.placa_pod between e.placa_min and e.placa_max then 'OK'
else 'NIE' end as CZY_PENSJA_OK
from pracownicy p inner join etaty e
    on p.etat = e.nazwa
order by p.etat, p.nazwisko

-- Zad. 5
select p.nazwisko, p.etat, p.placa_pod, e.placa_min, e.placa_max,
case when p.placa_pod between e.placa_min and e.placa_max then 'OK'
else 'NIE' end as CZY_PENSJA_OK
from pracownicy p inner join etaty e
    on p.etat = e.nazwa
where p.placa_pod not between e.placa_min and e.placa_max
order by p.etat, p.nazwisko;

-- Zad. 6
select p.nazwisko, p.placa_pod, p.etat, e.nazwa as KAT_PLAC, e.placa_min, e.placa_max
from pracownicy p inner join etaty e
    on p.placa_pod between e.placa_min and e.placa_max
order by p.nazwisko, e.nazwa;

-- Zad. 7
select p.nazwisko, p.placa_pod, p.etat, e.nazwa as KAT_PLAC, e.placa_min, e.placa_max
from pracownicy p inner join etaty e
    on p.placa_pod between e.placa_min and e.placa_max
where e.nazwa = 'SEKRETARKA'
order by p.nazwisko;

-- Zad. 8
select p1.nazwisko as PRACOWNIK, p1.id_prac, p2.nazwisko as SZEF, p2.id_prac
from pracownicy p1 inner join pracownicy p2
    on p1.id_szefa = p2.id_prac
order by p1.nazwisko;

-- Zad. 9
select p1.nazwisko as PRACOWNIK, p1.zatrudniony as PRAC_ZATRUDNIONY,
p2.nazwisko as SZEF, p2.zatrudniony as SZEF_ZATRUDNIONY,
extract(year from age(p1.zatrudniony, p2.zatrudniony)) as LATA
from pracownicy p1 inner join pracownicy p2
on p1.id_szefa = p2.id_prac
where extract(year from age(p1.zatrudniony, p2.zatrudniony)) < 10
order by p1.zatrudniony, p2.zatrudniony, p1.nazwisko, p2.nazwisko;

-- Zad. 10
select z.nazwa, count(*) as LICZBA, avg(p.placa_pod) as SREDNIA_PLACA
from pracownicy p inner join zespoly z
    on p.id_zesp = z.id_zesp
group by z.nazwa
order by z.nazwa

-- Zad. 11
select z.nazwa,
case
    when count(*) between 0 and 2 then 'mały'
    when count(*) between 3 and 6 then 'średnia'
    else 'duży'
end as ETYKIETA
from pracownicy p inner join zespoly z
    on p.id_zesp = z.id_zesp
group by z.nazwa
order by z.nazwa;
