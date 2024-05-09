-- Zad. 1
select nazwisko, substring(etat,1,2) || id_prac as KOD from pracownicy;

-- Zad. 2
select nazwisko, translate(nazwisko, 'KLM', 'XXX') as WOJNA_LITEROM from pracownicy;

-- Zad. 3
select nazwisko from pracownicy
where position('L' in substring(nazwisko, 1, length(nazwisko)/2)) > 0;

-- Zad. 4
select nazwisko, round(placa_pod*1.15, 0) as podwyzka from pracownicy;

-- Zad. 5
select nazwisko, placa_pod, placa_pod*0.2 as inwestycja,
trunc((placa_pod*0.2)*power(1.1, 10), 6) as kapital,
trunc((placa_pod*0.2)*power(1.1, 10), 6) - placa_pod*0.2 as ZYSK
from pracownicy;

-- Zad. 6
select nazwisko, to_char(zatrudniony, 'YY/MM/DD') as ZATRUDNI,
extract(year from (age(DATE '2000-01-01', zatrudniony))) as STAZ_W_2000 from pracownicy;

-- Zad. 7
select nazwisko, to_char(zatrudniony, 'MONTH, DD YYYY') from pracownicy where id_zesp=20;

-- Zad. 8
select to_char(current_DATE, 'DAY') as dzis;

-- Zad. 9
select nazwa, adres,
case
when adres like 'PIOTROWO %' then 'NOWE MIASTO'
when adres like 'STRZELECKA %' or adres like 'MIELZYNSKIEGO %' then 'STARE MIASTO'
when adres like 'WLODKOWICA %' then 'GRUNWALD'
end as DZIELNICA from zespoly;

-- Zad. 10
select nazwisko, placa_pod,
case
when placa_pod > 480 then 'Powyżej 480'
when placa_pod < 480 then 'Poniżej 480'
else 'Dokładnie 480'
end as PROG from pracownicy order by placa_pod DESC;

-- Zad. 11
select nazwisko, placa_pod,
decode(sign(PLACA_POD-480),
    1, 'Powyżej 480',
    -1, 'Poniżej 480',
    0 'Dokładnie 480') as PROG 
from pracownicy order by placa_pod DESC;
