-- Zadanie_1

EXPLAIN ANALYZE
SELECT
c.customerid,
c.personid,
c.storeid,
c.territoryid,
soh.salesorderid,
soh.orderdate,
soh.duedate,
soh.shipdate
FROM sales.customer c
INNER JOIN sales.salesorderheader soh ON c.customerid = soh.customerid
WHERE c.territoryid = 5

CREATE INDEX idx_customerid2 ON sales.customer (customerid);
CREATE INDEX idx_territoryid2 ON sales.customer (territoryid);
CREATE INDEX idx_orderdate ON sales.salesorderheader (orderdate);

EXPLAIN ANALYZE
SELECT
c.customerid,
c.personid,
c.storeid,
c.territoryid,
soh.salesorderid,
soh.orderdate,
soh.duedate,
soh.shipdate
FROM sales.customer c
INNER JOIN sales.salesorderheader soh ON c.customerid = soh.customerid
WHERE c.territoryid = 5

-- //PRZED:

-- "Hash Join  (cost=183.14..1348.41 rows=279 width=44) (actual time=3.451..17.599 rows=486 loops=1)"
-- "  Hash Cond: (soh.customerid = c.customerid)"
-- "  ->  Seq Scan on salesorderheader soh  (cost=0.00..1082.65 rows=31465 width=32) (actual time=0.492..12.011 rows=31465 loops=1)"
-- "  ->  Hash  (cost=180.94..180.94 rows=176 width=16) (actual time=2.945..2.946 rows=176 loops=1)"
-- "        Buckets: 1024  Batches: 1  Memory Usage: 16kB"
-- "        ->  Bitmap Heap Scan on customer c  (cost=5.65..180.94 rows=176 width=16) (actual time=0.409..2.900 rows=176 loops=1)"
-- "              Recheck Cond: (territoryid = 5)"
-- "              Heap Blocks: exact=24"
-- "              ->  Bitmap Index Scan on idx_territoryid1  (cost=0.00..5.61 rows=176 width=0) (actual time=0.041..0.041 rows=176 loops=1)"
-- "                    Index Cond: (territoryid = 5)"
-- "Planning Time: 18.852 ms"
-- "Execution Time: 18.282 ms"


-- PO:

-- "Hash Join  (cost=183.14..1348.41 rows=279 width=44) (actual time=0.090..3.921 rows=486 loops=1)"
-- "  Hash Cond: (soh.customerid = c.customerid)"
-- "  ->  Seq Scan on salesorderheader soh  (cost=0.00..1082.65 rows=31465 width=32) (actual time=0.004..1.317 rows=31465 loops=1)"
-- "  ->  Hash  (cost=180.94..180.94 rows=176 width=16) (actual time=0.078..0.079 rows=176 loops=1)"
-- "        Buckets: 1024  Batches: 1  Memory Usage: 16kB"
-- "        ->  Bitmap Heap Scan on customer c  (cost=5.65..180.94 rows=176 width=16) (actual time=0.029..0.064 rows=176 loops=1)"
-- "              Recheck Cond: (territoryid = 5)"
-- "              Heap Blocks: exact=24"
-- "              ->  Bitmap Index Scan on idx_territoryid2  (cost=0.00..5.61 rows=176 width=0) (actual time=0.023..0.023 rows=176 loops=1)"
-- "                    Index Cond: (territoryid = 5)"
-- "Planning Time: 1.935 ms"
-- "Execution Time: 3.963 ms"


-- ANALIZA: ------------------------------------------------------------------------------------------------------------------------------------------
-- Czas planowania (Planning Time):
-- Przed utworzeniem indeksów: 18.852 ms
-- Po utworzeniu indeksów: 1.935 ms
-- Różnica w czasie planowania wynika z tego, że indeksy pomagają optymalizatorowi lepiej ocenić, jakie operacje będą potrzebne do wykonania zapytania.

-- Czas wykonania (Execution Time):
-- Przed utworzeniem indeksów: 18.282 ms
-- Po utworzeniu indeksów: 3.963 ms
-- Największa różnica występuje w czasie wykonania zapytania. Po utworzeniu indeksów czas wykonania znacznie się skrócił. Indeksy pomagają w szybszym dostępie do danych, co z kolei przyspiesza operacje łączenia i wyszukiwania.

-- Struktura planu zapytania:
-- Po utworzeniu indeksów, w planie zapytania pojawiają się operacje Bitmap Heap Scan i Bitmap Index Scan, co świadczy o skorzystaniu z indeksów (idx_territoryid2). W przypadku braku indeksów operacje te nie byłyby widoczne.

-- Utworzenie indeksów na odpowiednich kolumnach pozwoliło na znaczącą poprawę wydajności zapytania poprzez skrócenie zarówno czasu planowania, jak i czasu wykonania. Indeksy pozwalają optymalizatorowi bazy danych na szybszy dostęp do potrzebnych danych.

-- Sequential Scan vs. Bitmap Heap Scan:
-- Przed utworzeniem indeksów: Widzimy operację Seq Scan (Sequential Scan) na tabeli salesorderheader i Bitmap Heap Scan na tabeli customer. Oznacza to, że baza danych musi przeczytać całą tabelę w poszukiwaniu pasujących wierszy.
-- Po utworzeniu indeksów: Dzięki indeksom na kolumnie territoryid, operacja Bitmap Heap Scan jest używana do efektywnego odfiltrowania pasujących wierszy na podstawie warunku territoryid = 5.

-- Bitmap Index Scan:
-- Przed utworzeniem indeksów: Brak operacji Bitmap Index Scan, co oznacza, że baza danych nie korzysta z indeksów.
-- Po utworzeniu indeksów: Pojawia się operacja Bitmap Index Scan on idx_territoryid2, co wskazuje, że baza danych używa indeksu na kolumnie territoryid do szybkiego zlokalizowania pasujących wierszy.



-- Zadanie_2
-- a) 
-- Napisz zapytanie, które wykorzystuje transakcję (zaczyna ją), a następnie aktualizuje
-- cenę produktu o ProductID równym 680 w tabeli Produc`on.Product o 10% i
-- następnie zatwierdza transakcję.

BEGIN TRANSACTION;

UPDATE production.product
SET listprice = listprice + 0.1*listprice  
WHERE productid = 680;

COMMIT TRANSACTION;

-- sprawdzenie wykonania:
SELECT *
FROM production.product
WHERE productid = 680;

-- b) 
-- Napisz zapytanie, które zaczyna transakcję, usuwa produkt o ProductID równym 707
-- z tabeli Production. Product, ale następnie wycofuje transakcję.

BEGIN WORK;

DELETE FROM production.product
WHERE productid = 707; -- usuniecie id 707

ROLLBACK; --wycofanie transakcji


-- c) 
-- Napisz zapytanie, które zaczyna transakcję, dodaje nowy produkt do tabeli

BEGIN TRANSACTION;

INSERT INTO Production.Product (
    ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, 
    StandardCost, ListPrice, Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight, 
    DaysToManufacture, ProductLine, Class, Style, ProductSubcategoryID, ProductModelID, 
    SellStartDate, SellEndDate, DiscontinuedDate, RowGuid, ModifiedDate
)
VALUES (
    10, 'HL Road Frame - Blue, 60', 'FR-R69B-60', true, true, 'Blue', 700, 485, 
    1367.21, 1432.145, '60', 'CM', 'LB', 3.27, 2, 'R', 'H', 'U', 17, 7, 
    '2022-12-26'::date, null, null, '43dd68d6-14a4-461f-9069-55309d90ea7e', '2022-12-26 21:37:39.127'
);

COMMIT;

-- sprawdzenie wykonania:
SELECT *
FROM production.product
WHERE productid = 10;

