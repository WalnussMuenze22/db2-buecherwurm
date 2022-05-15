-- Testfälle Funktion create_surrogate_key

--Testfall 1
--BestellungID = 4
--Erwartetes BestellungID = 'sysdate - 1'
INSERT INTO Bestellung (
        Datum,
        Status,
        RechnungsadresseID,
        LieferadresseID,
        KundenID
) VALUES (
        Sysdate,
        'editierbar',
        3,
        3,
        3
);

--Testfall 2
--BestellungID = 5
--Erwartetes BestellungID = 'sysdate - 2'
INSERT INTO Bestellung (
        Datum,
        Status,
        RechnungsadresseID,
        LieferadresseID,
        KundenID
) VALUES (
        Sysdate,
        'editierbar',
        2,
        2,
        2
);




-- Testfälle Trigger add_to_stock_order

--Testfall 1
--Die Känguru-Chroniken 
--Midestanzahl ist 8
--Vefügbar von 10 auf 5 setzen 
--Es sollten 4 (4,6) Känguru-Chroniken nachbestellt werden 
UPDATE Artikel SET AnzahlVerfuegbar = 5 WHERE ArtikelID = 1;

--Testfall 2
--Die Känguru-Comics 1
--Midestanzahl ist 20
--Vefügbar von 24 auf 20 setzen 
--Es sind 2 bereits auf der Nachbestellungen Liste
--Die Nachbestellen Liste sollte auf 4 erhöt werden 
UPDATE Artikel SET AnzahlVerfuegbar = 20 WHERE ArtikelID = 2;

