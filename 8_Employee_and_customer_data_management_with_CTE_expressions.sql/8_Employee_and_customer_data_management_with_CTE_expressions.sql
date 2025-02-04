-- Zadanie_1
-- Zbuduj zapytanie wykorzystujące wyrażenie CTE, które znajdzie informacje na temat
-- najwyższej stawki w historii płac pracownika oraz wyświetli jego podstawowe dane (imie,
-- nazwisko, id), a następnie zapisze je do tabeli tymczasowej TempEmployeeInfo. Podpowiedź:
-- dane potrzebne do stworzenia zapytania, znajdują się w dwóch tabelach w schemach: person
-- oraz humanresources.

-- Zapytanie CTE do znalezienia najwyższej stawki w historii płac pracownika
WITH MaxSalaryCTE AS (				--definiuje wspólne wyrażenie tabeli -  MaxSalaryCTE
    SELECT
        person.FirstName,			-- pobiera informacje o imieniu, nazwisku, 
        person.LastName,			-- identyfikatorze pracownika (BusinessEntityID) 
        person.BusinessEntityID,	-- maksymalnej stawce w historii płac pracownika
        MAX(humanresources.EmployeePayHistory.Rate) AS MaxRate	--oblicza maksymalną stawkę płac w historii dla każdego pracownika
    FROM
        humanresources.EmployeePayHistory
    JOIN
        person.Person ON humanresources.EmployeePayHistory.BusinessEntityID = person.Person.BusinessEntityID	-- łączy dwie tabeli: EmployeePayHistory i Person na podstawie identyfikatora pracownika
    GROUP BY
        person.FirstName, person.LastName, person.BusinessEntityID 	-- grupuje wyniki według imienia, nazwiska i identyfikatora pracownika
)

-- Zapisujemy wyniki zapytania CTE do tabeli tymczasowej TempEmployeeInfo
SELECT							-- wybiera konkretne kolumny z CTE MaxSalaryCTE
    MaxSalaryCTE.BusinessEntityID,
    MaxSalaryCTE.FirstName,
    MaxSalaryCTE.LastName,
    MaxSalaryCTE.MaxRate
INTO TempEmployeeInfo		-- tworzy tabelę tymczasową o nazwie TempEmployeeInfo
FROM
    MaxSalaryCTE;
	
-- Wyświetlamy zawartość tabeli tymczasowej TempEmployeeInfo
SELECT *
FROM TempEmployeeInfo;

-- Usuwanie tabeli tymczasowej
DROP TABLE IF EXISTS TempEmployeeInfo;







-- Zadanie_2
-- Zbuduj zapytanie wykorzystujące wyrażenie CTE, które wyświetli ID klienta, ID terytorium na
-- którym prowadzi działalność, a także wyświetli imię i nazwisko salesperson powiązanej z
-- danym Customer.TerritoryID

-- Zapytanie CTE do pobrania danych o klientach, terytoriach i salesperson
WITH CustomerTerritoryCTE AS (		-- definiuje wspólne wyrażenie tabeli - CustomerTerritoryCTE
    SELECT									-- pobiera informacje 
        sales.Customer.CustomerID,			-- identyfikatorze terytorium 
        sales.Customer.TerritoryID,			-- identyfikatorze terytorium 
        person.Person.FirstName,			-- imieniu
        person.Person.LastName 				-- nazwisku pracownika SalesPerson
    FROM
        sales.SalesPerson
    		--Wykorzystuje połączenia (JOIN) między tabelami SalesPerson, SalesTerritory i Customer, a także dołącza informacje o pracowniku 
	JOIN	--(Person) na podstawie identyfikatora biznesowego (BusinessEntityID).
        sales.SalesTerritory ON sales.SalesPerson.TerritoryID = sales.SalesTerritory.TerritoryID
    RIGHT JOIN
        sales.Customer ON sales.SalesTerritory.TerritoryID = sales.Customer.TerritoryID
    LEFT JOIN
        person.Person ON sales.SalesPerson.BusinessEntityID = person.Person.BusinessEntityID
)

-- Wyświetlamy dane klienta, terytorium oraz imię i nazwisko salesperson
SELECT		-- wybiera konkretne kolumny z CustomerTerritoryCTE
    CustomerTerritoryCTE.CustomerID,
    CustomerTerritoryCTE.TerritoryID AS CustomerTerritoryID, 	-- AS nadaje alias
	-- Wykorzystuje konkatenację (||) do połączenia imienia i nazwiska pracownika w jednej kolumnie o nazwie SalesPersonInThisTerritory
	CustomerTerritoryCTE.FirstName || ' ' || CustomerTerritoryCTE.LastName AS SalesPersonInThisTerritory
FROM
    CustomerTerritoryCTE;









