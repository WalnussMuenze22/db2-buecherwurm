DROP VIEW BuchInformationen;

CREATE VIEW BuchInformationen AS
SELECT Artikel.ArtikelID AS ArtikelID,
       Titel,
       Preis,
       Steuersatz,
       Beschreibung,
       ISBN,
       Erscheinungsdatum,
       Sprache,
       AnzahlVerfuegbar,
       MindestBestand,
       AnzahlVerkauft,
       AnzahlSeiten,
       Verlag.Name AS Verlag,
       LISTAGG(Autor.Name, '||') WITHIN GROUP (ORDER BY Autor.Name) AS AutorenListe
FROM Artikel
JOIN Buch ON (Artikel.ArtikelID = Buch.ArtikelID)
JOIN Verlag ON (Artikel.VerlagID = Verlag.VerlagID)
JOIN AutorArtikelAssoziation ON Artikel.ArtikelID = AutorArtikelAssoziation.ArtikelID
JOIN Autor ON AutorArtikelAssoziation.AutorID = Autor.AutorID
GROUP BY Artikel.ArtikelID,
         Titel,
         Preis,
         Steuersatz,
         Beschreibung,
         ISBN,
         Erscheinungsdatum,
         Sprache,
         AnzahlVerfuegbar,
         MindestBestand,
         AnzahlVerkauft,
         AnzahlSeiten,
         Verlag.Name
ORDER BY (Artikel.ArtikelID) ASC
;