 CREATE SCHEMA rozliczenia;

 CREATE TABLE rozliczenia.pracownicy (
     id_pracownika INT PRIMARY KEY,
     imie VARCHAR(50) NOT NULL,
     nazwisko VARCHAR(50) NOT NULL,
     adres VARCHAR(100) NOT NULL,
     telefon VARCHAR(15)
 );
 CREATE TABLE rozliczenia.godziny (
     id_godziny INT PRIMARY KEY,
	data DATE NOT NULL,
     liczba_godzin DECIMAL(5, 2),
     id_pracownika INT NOT NULL
 );

 CREATE TABLE rozliczenia.pensje (
     id_pensji INT PRIMARY KEY,
     stanowisko VARCHAR(50) NOT NULL,
     kwota DECIMAL(10, 2) NOT NULL,
     id_pracownika INT NOT NULL,
	id_premii INT NOT NULL
	 
 );

 CREATE TABLE rozliczenia.premie (
     id_premii INT PRIMARY KEY,
     rodzaj TEXT NOT NULL,
    kwota DECIMAL(10, 2)
);

ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii)
REFERENCES rozliczenia.premie(id_premii);

ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika)
REFERENCES rozliczenia.pracownicy(id_pracownika);

INSERT INTO rozliczenia.pracownicy(id_pracownika, imie, nazwisko,
adres, telefon) 
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

								  
INSERT INTO rozliczenia.godziny (id_godziny, data, liczba_godzin, id_pracownika) VALUES
(123, '2023-11-02', 5, 1),
(234, '2023-11-02', 7, 2),
(345, '2023-11-02', 7, 3),
(456, '2023-11-02', 5, 4),
(567, '2023-11-03', 2, 5),
(678, '2023-11-03', 8, 6),
(789, '2023-11-03', 8, 7),
(891, '2023-11-04', 8, 8),
(912, '2023-11-05', 8, 9),
(101, '2023-11-05', 6, 10);				

INSERT INTO rozliczenia.premie (id_premii, rodzaj, kwota)
VALUES
(111, 'Premia za nic', 400),
(222, 'Premia za nic', 700),
(333, 'Premia za nic', 1000),
(444, 'Premia za nic', 800),
(555, 'Premia za nic', 900),
(666, 'Premia za nic', 600),
(777, 'Premia za nic', 8800),
(888, 'Premia za nic', 3000),
(999, 'Premia za nic', 3400),
(100, 'Premia za nic', 950);
								  
								  
INSERT INTO rozliczenia.pensje (id_pensji, stanowisko, kwota, id_premii)
VALUES
(1, 'Stanowisko Aa', 14500, 111),
(2, 'Stanowisko Bb', 8800, 222),
(3, 'Stanowisko Cc', 6000, 333),
(4, 'Stanowisko Dd', 11000, 444),
(5, 'Stanowisko Ee', 8700, 555),
(6, 'Stanowisko Ff', 9100, 666),
(7, 'Stanowisko Gg', 7600, 777),
(8, 'Stanowisko Hh', 10900, 888),
(9, 'Stanowisko Ii', 9300, 999),
(10, 'Stanowisko Jj', 8700, 100);								  
								  
SELECT nazwisko, adres FROM rozliczenia.pracownicy;								  					  
								  
SELECT 
    DATE_PART('Day', data) AS Nazwa_Dnia_Tygodnia,
    DATE_PART('Month',data) AS Nazwa_Miesiaca
FROM rozliczenia.godziny;						  
	
ALTER TABLE rozliczenia.pensje RENAME COLUMN kwota TO kwota_brutto;
ALTER TABLE rozliczenia.pensje ADD COLUMN kwota_netto DECIMAL(10, 2);	
UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto * 1.23;		

SELECT kwota_brutto, kwota_netto FROM rozliczenia.pensje;		


								  
								  
								  
								  
								  
								  
								  
								  
								  
