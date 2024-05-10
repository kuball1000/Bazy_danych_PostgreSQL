-- Zad. 1
select nazwisko, etat, id_zesp
from pracownicy
where id_zesp = (
    select id_zesp
    from pracownicy
    where nazwisko = 'BRZEZINSKI')
order by nazwisko;

-- Zad. 2
select p.nazwisko, p.etat, z.nazwa
from pracownicy p join zespoly z using(id_zesp)
where p.id_zesp = (
    select id_zesp
    from pracownicy 
    where nazwisko = 'BRZEZINSKI')
order by p.nazwisko;

-- Zad. 3
select nazwisko, etat, zatrudniony
from pracownicy
where (zatrudniony, etat) = (
    select min(zatrudniony), 'PROFESOR'
    from pracownicy
    where etat = 'PROFESOR');

-- Zad. 4
select nazwisko, zatrudniony, id_zesp
from pracownicy
where (zatrudniony, id_zesp) IN (
    select max(zatrudniony), id_zesp
    from pracownicy
    group by id_zesp)
order by zatrudniony;

-- Zad. 5
select id_zesp, nazwa, adres
from zespoly
where id_zesp not IN (
    select id_zesp
    from pracownicy
    where id_zesp is not null);

-- Zad. 6
select nazwisko
from pracownicy
where etat = 'PROFESOR' and id_prac not in (
    select id_szefa
    from pracownicy
    where etat = 'STAZYSTA');

-- Zad. 7
select id_zesp, sum(placa_pod) as SUMA_PLAC
from pracownicy
group by id_zesp
having sum(placa_pod) >= all (
    select sum(placa_pod)
    from pracownicy
    group by id_zesp);

-- Zad. 8
select z.nazwa, sum(p.placa_pod) as SUMA_PLAC
from pracownicy p join zespoly z using(id_zesp)
group by z.id_zesp, z.nazwa
having sum(p.placa_pod) >= all (
    select sum(placa_pod)
    from pracownicy
    group by id_zesp);

-- Zad. 9
select z.nazwa, count(*) as ILU_PRACOWNIKOW
from zespoly z join pracownicy p using(id_zesp)
group by z.id_zesp, z.nazwa
having count(*) > (
    select count(*)
    from zespoly z2 join pracownicy p2 using(id_zesp)
    where z2.nazwa = 'ADMINISTRACJA')
order by z.nazwa;

-- Zad. 10
select etat
from pracownicy
group by etat
having count(*) >= all (
    select count(*)
    from pracownicy
    group by etat)
order by etat;

-- Zad. 11
select etat, string_agg(nazwisko, ',' order by nazwisko) as PRACOWNICY
from pracownicy
group by etat
having count(*) >= all (
    select count(*)
    from pracownicy
    group by etat);

-- Zad. 12
select p1.nazwisko as PRACOWNIK, p2.nazwisko as SZEF
from pracownicy p1 join pracownicy p2 on p2.id_prac = p1.id_szefa
where (p2.placa_pod - p1.placa_pod) <= all (
    select p2.placa_pod -p1.placa_pod
    from pracownicy p1 join pracownicy p2 on p2.id_prac = p1.id_szefa);

