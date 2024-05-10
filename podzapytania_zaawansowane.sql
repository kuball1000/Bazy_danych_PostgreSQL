-- Zad. 1
select z.id_zesp, z.nazwa, z.adres
from zespoly z
where not exists (select * from pracownicy where id_zesp = z.id_zesp);

-- Zad. 2
select nazwisko, placa_pod, etat
from pracownicy p
where placa_pod > (select avg(placa_pod) from pracownicy where etat = p.etat)
order by placa_pod desc;

-- Zad. 3
select nazwisko, placa_pod
from pracownicy p
where placa_pod > (select placa_pod*0.75 from pracownicy where id_prac = p.id_szefa)
order by nazwisko;

-- Zad. 4
select nazwisko
from pracownicy p
where p.etat = 'PROFESOR' and
not exists (select * from pracownicy where etat = 'STAZYSTA' and id_szefa = p.id_prac);

-- Zad. 5
select z.nazwa, a.MAKS from
(select max(suma_plac) as MAKS from
(select id_zesp, sum(placa_pod) as suma_plac from pracownicy p group by id_zesp)) as a
join (select id_zesp, sum(placa_pod) as suma_plac from pracownicy p group by id_zesp) b
on a.MAKS = b.suma_plac
join zespoly z on b.id_zesp = z.id_zesp
group by z.nazwa, a.MAKS;

-- Zad. 6
select nazwisko, placa_pod
from pracownicy p
where 3 > (select count(*) from pracownicy p2 where p.placa_pod < p2.placa_pod)
order by placa_pod desc;

-- Zad. 7
SELECT nazwisko, placa_pod, placa_pod - (SELECT AVG(placa_pod)
FROM pracownicy where id_zesp = z.id_zesp) AS ROZNICA
FROM zespoly z
JOIN pracownicy p ON z.id_zesp = p.id_zesp
ORDER BY nazwisko;

SELECT nazwisko, placa_pod, placa_pod - srednia_w_zespole as ROZNICA
FROM (SELECT id_zesp, AVG(placa_pod) AS srednia_w_zespole
FROM pracownicy
GROUP BY id_zesp) z
JOIN pracownicy p ON z.id_zesp = p.id_zesp
ORDER BY nazwisko;

-- Zad. 8
SELECT nazwisko, placa_pod, placa_pod - (SELECT AVG(placa_pod)
FROM pracownicy where id_zesp = z.id_zesp) AS ROZNICA
FROM zespoly z
JOIN pracownicy p ON z.id_zesp = p.id_zesp
where placa_pod - (SELECT AVG(placa_pod)
FROM pracownicy where id_zesp = z.id_zesp) > 0
ORDER BY nazwisko;

SELECT nazwisko, placa_pod, placa_pod - srednia_w_zespole as ROZNICA
FROM (SELECT id_zesp, AVG(placa_pod) AS srednia_w_zespole
FROM pracownicy
GROUP BY id_zesp) z
JOIN pracownicy p ON z.id_zesp = p.id_zesp
where placa_pod - srednia_w_zespole > 0
ORDER BY nazwisko;

-- Zad. 9
select p.nazwisko, (select count(*) from pracownicy p2 where p.id_prac = p2.id_szefa) as PODWLADNI
from pracownicy p join zespoly z on p.id_zesp = z.id_zesp
where z.adres like '%PIOTROWO%'
and p.etat = 'PROFESOR'
order by PODWLADNI DESC;

-- Zad. 10
select z.nazwa,
(select avg(placa_pod) from pracownicy where id_zesp = z.id_zesp) as SREDNIA_W_ZESPOLE,
round((select avg(placa_pod) from pracownicy), 2) as SREDNIA_OGOLNA,
case
    when (select avg(placa_pod) from pracownicy where id_zesp = z.id_zesp) >= (select avg(placa_pod) from pracownicy) then ':)'
    when (select avg(placa_pod) from pracownicy where id_zesp = z.id_zesp) < (select avg(placa_pod) from pracownicy) then ':('
    when (select avg(placa_pod) from pracownicy where id_zesp = z.id_zesp) is null then '???'
end
from zespoly z
order by z.nazwa;

-- Zad. 11
select e.nazwa, e.placa_min, e.placa_max
from etaty e
order by (select count(*) from pracownicy p where p.etat = e.nazwa) desc, e.nazwa;
