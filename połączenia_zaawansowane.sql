-- Zad. 1
select p.nazwisko, p.id_zesp, z.nazwa
from pracownicy p left join zespoly z
    on p.id_zesp = z.id_zesp
order by p.nazwisk;

-- Zad. 2
select z.nazwa, z.id_zesp,
case
    when p.id_zesp is null then 'brak pracownikow'
    else p.nazwisko
end as nazwisko
from pracownicy p right join zespoly z
    on p.id_zesp = z.id_zesp
order by z.nazwa, p.nazwisko;

-- Zad. 3
select
case
    when z.nazwa is null then 'brak zespolu'
    else z.nazwa
end as nazwa,
case
    when p.id_zesp is null then 'brak pracownikow'
    else p.nazwisko
end as nazwisko
from pracownicy p full join zespoly z
    on p.id_zesp = z.id_zesp
order by z.nazwa, p.nazwisko;

-- Zad. 4
select z.nazwa, count(p.id_zesp) as LICZBA, sum(p.placa_pod) as SUMA_PLAC
from pracownicy p right join zespoly z
    on p.id_zesp = z.id_zesp
group by z.id_zesp
order by z.nazwa

-- Zad. 5
select z.nazwa
from pracownicy p right join zespoly z
    on p.id_zesp = z.id_zesp
group by z.nazwa
having count(p.id_zesp) = 0
order by z.nazwa;

-- Zad. 6
select p1.nazwisko, p1.id_prac, p2.nazwisko as SZEF, p2.id_prac
from pracownicy p1 left join pracownicy p2
    on p2.id_prac = p1.id_szefa
order by p1.nazwisko;

-- Zad. 7
select p2.nazwisko, count(p1.id_prac) as LICZBA_PODWLADNYCH
from pracownicy p1 right join pracownicy p2
    on p2.id_prac = p1.id_szefa
group by p2.id_prac, p2.nazwisko
order by p2.nazwisko;

-- Zad. 8
select p1.nazwisko, p1.etat, p1.placa_pod, z.nazwa, p2.nazwisko as SZEF
from pracownicy p1 left join pracownicy p2
    on p2.id_prac = p1.id_szefa
left join zespoly z
    on p1.id_zesp = z.id_zesp
order by p1.nazwisko;

-- Zad. 9
select p.nazwisko, z.nazwa
from pracownicy p cross join zespoly z
order by p.nazwisko;

-- Zad. 10
select count(*)
from pracownicy p cross join zespoly z
cross join etaty e;

-- Zad. 11
select etat
from pracownicy
where extract(year from zatrudniony) = 1992
INTERSECT
select etat
from pracownicy
where extract(year from zatrudniony) = 1993
order by etat;

-- Zad. 12
select id_zesp
from zespoly z
EXCEPT
select id_zesp
from pracownicy;

-- Zad. 13
select z.id_zesp, z.nazwa
from zespoly z
except
select z2.id_zesp, z2.nazwa
from pracownicy p join zespoly z2
on z2.id_zesp = z2.id_zesp;

-- Zad. 14
select nazwisko, placa_pod, 'powyżej 480 złotych' as PROG
from pracownicy p
where placa_pod > 480
union
select nazwisko, placa_pod, 'Dokładnie 480 złotych'
from pracownicy p
where placa_pod = 480
union
select nazwisko, placa_pod, 'poniżej 480 złotych'
from pracownicy p
where placa_pod < 480
order by placa_pod;
