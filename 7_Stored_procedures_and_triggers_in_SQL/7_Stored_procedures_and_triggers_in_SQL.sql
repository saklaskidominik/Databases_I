-- Zadanie_1

-- Napisz procedurę wypisującą do konsoli ciąg Fibonacciego. Procedura musi przyjmować jako
-- argument wejściowy liczbę n. Generowanie ciągu Fibonacciego musi zostać
-- zaimplementowane jako osobna funkcja, wywoływana przez procedurę. 

CREATE OR REPLACE FUNCTION generate_fibonacci(n INT)
RETURNS TABLE (fib_value BIGINT)
AS $$
DECLARE
    a BIGINT := 0;
    b BIGINT := 1;
    i INT := 1;
BEGIN
    WHILE i <= n LOOP
        fib_value := a;
        RETURN NEXT;

        a := a + b;
        b := a - b;
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

--wywołanie procedury 
SELECT * FROM generate_fibonacci(10);


-- Zadanie_2
-- Napisz trigger DML, który po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko
-- tak, aby było napisane dużymi literami. 


CREATE OR REPLACE FUNCTION uppercase_lastname_function0()
RETURNS TRIGGER AS $$
BEGIN
    NEW.lastname := UPPER(NEW.lastname);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER uppercase_lastname_trigger0
BEFORE INSERT OR UPDATE ON person.person
FOR EACH ROW
EXECUTE FUNCTION uppercase_lastname_function0();


-- Zadanie_3
-- Przygotuj trigger ‘taxRateMonitoring’, który wyświetli komunikat o błędzie, jeżeli nastąpi
-- zmiana wartości w polu ‘TaxRate’ o więcej niż 30%. 

CREATE OR REPLACE FUNCTION taxRateMonitoring()		-- tworzy funkcje, a jesli istnieje to zostanie zastapiona
RETURNS TRIGGER AS $$								--
DECLARE												-- rozpoczyna sekcje deklaracji, gdzie zadeklarowane sa zmienne uzywane wewnątrz funkcji
    old_tax_rate numeric;							--old_tax_rate i new_tax_rate przechowują wartości starej i nowej stawki podatku 
    new_tax_rate numeric;							
    max_change_percent numeric := 30; 				-- max_change_percent to maksymalna dopuszczalna zmiana (30%)
BEGIN												-- blok kodu, w ktorym znajdują się instrukcje
    old_tax_rate := COALESCE(OLD.TaxRate, 0);		-- przypisuje wartosci stawki podatku (TaxRate) do zmiennych
    new_tax_rate := COALESCE(NEW.TaxRate, 0);		-- uzywamy COALESCE do uzupelnienia zerem (0) jesli podatek to NULL

    IF abs(new_tax_rate - old_tax_rate) / old_tax_rate * 100 > max_change_percent THEN 			--Sprawdza, czy zmiana stawki podatku przekracza 30%
        RAISE EXCEPTION 'Zmiana wartości w polu TaxRate o więcej niż 30% !!!', NEW.TaxRate;		-- jezeli if jest spelniony to zwraca blad z komunikatem
    END IF;

    RETURN NEW;
END;

$$ LANGUAGE plpgsql;

CREATE TRIGGER taxRateMonitoring			-- tworzy trigger
BEFORE UPDATE ON sales.salestaxrate			-- trigger będzie aktywowany przed aktualizacją (BEFORE UPDATE) w tabeli sales.salestaxrate
FOR EACH ROW								--  trigger ma działać dla każdego wiersza, który jest aktualizowany
EXECUTE FUNCTION taxRateMonitoring();		-- określa funkcję, którą trigger ma wywołać dla każdej aktualizacji
