-- Zad. 1
select nazwisko, placa_pod
from pracownicy p
order by placa_pod desc
fetch first 3 rows with ties;

-- Zad. 2
select nazwisko, placa_pod
from pracownicy p
order by placa_pod desc
offset 5 rows
fetch next 5 rows with ties;

-- Zad. 3
with sred_zesp as
(select p.id_zesp, avg(p.placa_pod) as sred_z
from pracownicy p join zespoly z on p.id_zesp = z.id_zesp
group by p.id_zesp)
select p2.nazwisko, p2.placa_pod, p2.placa_pod - s.sred_z as roznica
from pracownicy p2 join sred_zesp s on p2.id_zesp = s.id_zesp
where p2.placa_pod - s.sred_z > 0
order by p2.nazwisko;

-- Zad. 4
with lata as
(select extract(year from zatrudniony) as rok, count(*) as liczba from pracownicy p
group by extract(year from zatrudniony))
select * from lata
order by liczba desc, rok;

-- Zad. 5
with lata as
(select extract(year from zatrudniony) as rok, count(*) as liczba from pracownicy p
group by extract(year from zatrudniony))
select * from lata
where liczba = (select max(liczba) from lata)
order by liczba desc, rok;

-- Zad. 6
with Asystenci as
(select nazwisko, etat, id_zesp from pracownicy where etat = 'ASYSTENT'),
Piotrowo as
(select nazwa, adres, id_zesp from zespoly where adres like '%PIOTROWO%')
select a.nazwisko, a.etat, p.nazwa, p.adres
from Asystenci a join Piotrowo p on a.id_zesp = p.id_zesp;

--Zad. 7
with placa as
(select sum(placa_pod) as suma, p.id_zesp, nazwa
from pracownicy p join zespoly z on p.id_zesp = z.id_zesp
group by p.id_zesp, nazwa)
select nazwa, suma as MAKS_SUMA_PLAC from placa
where suma = (select max(suma) from placa);

-- Zad. 8
with recursive
podwladni (id_prac, id_szefa, nazwisko, poziom) AS
(SELECT id_prac, id_szefa, nazwisko, 1
FROM pracownicy
WHERE nazwisko = 'BRZEZINSKI'
UNION ALL
SELECT p.id_prac, p.id_szefa, p.nazwisko, poziom+1
FROM podwladni po JOIN pracownicy p ON po.id_prac = p.id_szefa)
SEARCH DEPTH FIRST BY nazwisko SET porzadek_potomkow
SELECT nazwisko, poziom
FROM podwladni
ORDER BY porzadek_potomkow;

-- Zad. 9
with recursive
podwladni (id_prac, id_szefa, nazwisko, poziom) AS
(SELECT id_prac, id_szefa, nazwisko, 1
FROM pracownicy
WHERE nazwisko = 'BRZEZINSKI'
UNION ALL
SELECT p.id_prac, p.id_szefa, p.nazwisko, poziom+1
FROM podwladni po JOIN pracownicy p ON po.id_prac = p.id_szefa)
SEARCH DEPTH FIRST BY nazwisko SET porzadek_potomkow
SELECT LPAD('', (poziom-1), '    ') || nazwisko , poziom
FROM podwladni
ORDER BY porzadek_potomkow;

-- Zad. 10
with nazw_tys as
(select nazwisko, floor((placa_pod + coalesce(placa_dod,0))/1000) as tysiaczki
from pracownicy p),
liczby as
(SELECT digit, word
FROM (VALUES
(0,'zero'),(1,'jeden'),(2,'dwa'),(3,'trzy'),
(4,'cztery'),(5,'pięć'),(6,'sześć'),
(7,'siedem'),(8,'osiem'),(9,'dziewięć'))
DIGITS(digit, word))
select c.nazwisko || ', zarabia w tysiącach: ' || l.word as ZAROBKI
from nazw_tys c join liczby l on c.tysiaczki = l.digit
order by c.nazwisko;
