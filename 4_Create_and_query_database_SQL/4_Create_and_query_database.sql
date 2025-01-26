CREATE TABLE ksiegowosc.pracownicy 
(
     id_pracownika INT PRIMARY KEY, 
     imie VARCHAR(50) NOT NULL,
     nazwisko VARCHAR(50) NOT NULL,
     adres VARCHAR(100) NOT NULL,
     telefon VARCHAR(15)
 );
COMMENT ON TABLE ksiegowosc.pracownicy IS 'Tabela przechowująca informacje o pracownikach firmy';
 
 
CREATE TABLE ksiegowosc.godziny (
     id_godziny INT PRIMARY KEY,
	 data DATE NOT NULL,
     liczba_godzin DECIMAL(5, 2) NOT NULL,
     id_pracownika INT NOT NULL
 );
COMMENT ON TABLE ksiegowosc.godziny IS 'Tabela przechowująca informacje o godzinach pracy pracowników firmy'; 


CREATE TABLE ksiegowosc.pensja (
     id_pensji INT PRIMARY KEY,
     stanowisko VARCHAR(50) NOT NULL,
     kwota DECIMAL(10, 2) NOT NULL
 );
COMMENT ON TABLE ksiegowosc.pensja IS 'Tabela przechowująca informacje o pensji pracowników firmy';


 CREATE TABLE ksiegowosc.premie (
     id_premii INT PRIMARY KEY,
     rodzaj TEXT NOT NULL,
     kwota DECIMAL(10, 2)
);
COMMENT ON TABLE ksiegowosc.premie IS 'Tabela przechowująca informacje o premiach pracowników firmy';


CREATE TABLE ksiegowosc.wynagrodzenie (
	id_wynagrodzenia INT PRIMARY KEY,
	data DATE NOT NULL,
	id_pracownika INT NOT NULL,
	id_godziny INT,
	id_pensji INT,
	id_premii INT
);
COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'Tabela przechowująca informacje o wynagrodzeniach pracowników firmy';

ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_premii)
REFERENCES ksiegowosc.premie(id_premii);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_pensji)
REFERENCES ksiegowosc.pensja(id_pensji);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD FOREIGN KEY (id_pracownika)
REFERENCES ksiegowosc.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.godziny
ADD FOREIGN KEY (id_pracownika)
REFERENCES ksiegowosc.pracownicy(id_pracownika);

-- Wypełnij każdą tabelę 10. rekordami:

INSERT INTO ksiegowosc.pracownicy(id_pracownika, imie, nazwisko, adres, telefon) 
VALUES
(1, 'Jan', 'Paweł', 'ul. Papieska 2, 20-456 Wadowice', '568-896-745'),
(2, 'Bogumił', 'Łopata', 'ul. Ziemna 101, 25-956 Łódź', '533-234-009'),
(3, 'Remigiusz', 'Smith', 'ul. Zagraniczna 99, 12-543 Sosnowiec', '567-546-455'),
(4, 'Benedykt', 'Krześlak', 'ul. Drzewna 76, 30-438 Katowice', '538-876-345'),
(5, 'Adam', 'Iglasty', 'ul. Wiejska 1, 20-456 Warszawa', '468-766-555'),
(6, 'Michalina', 'Dzika', 'ul. Zagroda 45, 12-843 Szczecin', '655-096-700'),
(7, 'Nikola', 'Wójtowicz', 'ul. Zamkowa 19, 22-411 Białogród', '568-541-455'),
(8, 'Maria', 'Madej', 'ul. Dziwna 5, 41-111 Poznań', '718-906-115'),
(9, 'Magdalena', 'Sosnówka', 'ul. Skromna 55, 13-777 Łódź', '668-856-098'),
(10, 'Monika', 'Kozioł', 'ul. Kursowa 68, 23-176 Kraków', '812-996-495');


INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika) VALUES
(100, '2023-11-02', 10, 1),
(101, '2023-11-02', 18, 2),
(102, '2023-11-02', 20, 3),
(103, '2023-11-02', 14, 4),
(104, '2023-11-03', 9, 5),
(105, '2023-11-03', 11, 6),
(106, '2023-11-03', 12, 7),
(107, '2023-11-04', 12, 8),
(108, '2023-11-05', 15, 9),
(109, '2023-11-05', 17, 10),
(110, '2023-11-06', 10, 1),
(111, '2023-11-07', 15, 1),
(112, '2023-11-08', 20, 1),
(113, '2023-11-09', 14, 1),
(114, '2023-11-10', 17, 2),
(115, '2023-11-11', 15, 2),
(116, '2023-11-12', 13, 1),
(117, '2023-11-13', 12, 1),
(118, '2023-11-14', 11, 1),
(119, '2023-11-15', 13, 1),
(120, '2023-11-16', 7, 1),
(121, '2023-11-17', 15, 2),
(122, '2023-11-18', 20, 2),
(123, '2023-11-19', 10, 1),
(124, '2023-11-20', 12, 1),
(125, '2023-11-21', 11, 1),
(126, '2023-11-22', 12, 1),
(127, '2023-11-23', 12, 1),
(128, '2023-11-24', 17, 2),
(129, '2023-11-25', 16, 2),
(130, '2023-11-26', 10, 1),
(131, '2023-11-27', 15, 1),
(132, '2023-11-28', 20, 2),
(133, '2023-11-29', 14, 2),
(134, '2023-11-30', 11, 2),
(135, '2023-11-04', 7, 7),
(136, '2023-11-05', 15, 7),
(137, '2023-11-06', 20, 7),
(138, '2023-11-07', 10, 7),
(139, '2023-11-08', 12, 7),
(140, '2023-11-09', 11, 7),
(141, '2023-11-10', 12, 7),
(142, '2023-11-11', 12, 7),
(143, '2023-11-12', 17, 7),
(144, '2023-11-13', 16, 7),
(145, '2023-11-14', 12, 7),
(146, '2023-11-15', 12, 7),
(147, '2023-11-16', 17, 7),
(148, '2023-11-17', 16, 7);

INSERT INTO ksiegowosc.pensja(id_pensji, stanowisko, kwota)
VALUES
(100000, 'Dyrektor', 20500),
(200000, 'Menager projektu', 8800),
(300000, 'Menager projektu', 2000),
(400000, 'Menager projektu', 800),
(500000, 'Dyrektor marketingu', 1000),
(600000, 'Kierownik', 7000),
(700000, 'Dyrektor działu IT', 3000),
(800000, 'Kierownik', 6800),
(900000, 'Kierownik', 9300),
(1000000, 'Dyrektor ds. obsługi klienta', 8700);	


INSERT INTO ksiegowosc.premie (id_premii, rodzaj, kwota)
VALUES
(1000, 'Premia za nadgodziny', 4000),
(1001, 'Premia za stanowisko', 700),
(1002, 'Premia za stanowisko', 1000),
(1003, 'Premia za stanowisko', 800),
(1004, 'Premia za stanowisko', 900),
(1005, 'Premia za stanowisko', 600),
(1006, 'Premia za stanowisko', 800),
(1007, 'Premia za stanowisko', 300),
(1008, 'Premia za stanowisko', 3400),
(1009, 'Premia za stanowisko', 950);


INSERT INTO ksiegowosc.wynagrodzenie(id_wynagrodzenia, data, id_pracownika, id_pensji, id_premii)
VALUES
(10000, '2023-12-01', 1, 100000, 1000),
(10001, '2023-12-01', 2, 200000, 1001),
(10002, '2023-12-01', 3, 300000, 1002),
(10003, '2023-12-01', 4, 400000, 1003),
(10004, '2023-12-01', 5, 500000, 1004),
(10005, '2023-12-01', 6, 600000, 1005),
(10006, '2023-12-01', 7, 700000, NULL),
(10007, '2023-12-01', 8, 700000, 1006),
(10008, '2023-12-01', 9, 800000, 1007),
(10009, '2023-12-01', 10, 900000, 1008);

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////--


-- a. Wyświetl tylko id pracownika oraz jego nazwisko. 
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;	

-- b. Wyświetl id pracowników, których płaca jest większa niż 1000. 
SELECT ksiegowosc.pracownicy.id_pracownika
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
WHERE ksiegowosc.pensja.kwota > 1000;

-- c. Wyświetl id pracowników nieposiadających premii, których płaca jest większa niż 2000.
SELECT ksiegowosc.pracownicy.id_pracownika
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
LEFT JOIN ksiegowosc.premie ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premie.id_premii
WHERE ksiegowosc.pensja.kwota > 2000 AND ksiegowosc.premie.id_premii IS NULL;

-- d. Wyświetl pracowników, których pierwsza litera imienia zaczyna się na literę ‘J’
SELECT ksiegowosc.pracownicy.id_pracownika,
	   ksiegowosc.pracownicy.imie,
	   ksiegowosc.pracownicy.nazwisko
FROM ksiegowosc.pracownicy
WHERE ksiegowosc.pracownicy.imie LIKE 'J%';

-- e. Wyświetl pracowników, których nazwisko zawiera literę ‘n’ oraz imię kończy się na literę ‘a’.
SELECT ksiegowosc.pracownicy.id_pracownika,
	   ksiegowosc.pracownicy.imie,
	   ksiegowosc.pracownicy.nazwisko
FROM ksiegowosc.pracownicy
WHERE ksiegowosc.pracownicy.imie LIKE '%a' AND ksiegowosc.pracownicy.nazwisko LIKE '%n%';

-- f. Wyświetl imię i nazwisko pracowników oraz liczbę ich nadgodzin, przyjmując,standardowy czas pracy to 160 h miesięcznie. 
SELECT
    ksiegowosc.pracownicy.imie,
    ksiegowosc.pracownicy.nazwisko,
    GREATEST(SUM(ksiegowosc.godziny.liczba_godzin) - 160, 0) AS nadgodziny
FROM ksiegowosc.pracownicy
LEFT JOIN ksiegowosc.godziny ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.godziny.id_pracownika
GROUP BY ksiegowosc.pracownicy.id_pracownika, ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko;
	