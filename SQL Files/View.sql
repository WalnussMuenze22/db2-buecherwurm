CREATE VIEW BuchInformationen AS
SELECT Titel, Preis, Steuersatz, Beschreibung, ISBN, Erscheinungsdatum, Sprache, AnzahlVerfuegbar, MindestAnzahl, AnzahlVerkauft, AnzahlSeiten, Verlag.Name as Verlag, Autor.Name as Autor
FROM Artikel
JOIN Buch ON (Artikel.ArtikelID = Buch.ArtikelID)
JOIN Verlag ON (Artikel.VerlagID = Verlag.VerlagID)
JOIN AutorArtikelAssoziation ON (AutorArtikelAssoziation.ArtikelID = Artikel.ArtikelID)
JOIN Autor ON (AutorArtikelAssoziation.AutorID = Autor.AutorID)
;