-- Bücher --

INSERT INTO BuchInformationen (
        Titel,
        Preis,
        Steuersatz,
        Beschreibung,
        ISBN,
        ErscheinungsDatum,
        Sprache,
        AnzahlVerfuegbar,
        Mindestbestand,
        AnzahlVerkauft,
        AnzahlSeiten,
        Verlag,
        AutorenListe
) VALUES (
        'Die Känguru-Chroniken',
        10.99,
        7,
        'Frisch Frech und völlig Absurd',
        9783548372570,
        DATE '2009-03-11',
        'DE',
        10,
        8,
        0,
        272,
        'Ullstein',
        'Marc-Uwe Kling'
);


INSERT INTO BuchInformationen (
        Titel,
        Preis,
        Steuersatz,
        Beschreibung,
        ISBN,
        ErscheinungsDatum,
        Sprache,
        AnzahlVerfuegbar,
        Mindestbestand,
        AnzahlVerkauft,
        AnzahlSeiten,
        Verlag,
        AutorenListe
) VALUES (
        'Die Känguru-Comics 1: Also ICH könnte das besser',
        22.00,
        7,
        'Das Känguru und Marc-Uwe kommentieren den alltäglichen Wahnsinn auf ZEIT online – und zwar als Comicfiguren!',
        9783551728289,
        DATE '2022-03-20',
        'DE',
        24,
        20,
        0,
        224,
        'Carlsen',
        'Marc-Uwe Kling#Bernd Kissel'
);


INSERT INTO BuchInformationen (
        Titel,
        Preis,
        Steuersatz,
        Beschreibung,
        ISBN,
        ErscheinungsDatum,
        Sprache,
        AnzahlVerfuegbar,
        Mindestbestand,
        AnzahlVerkauft,
        AnzahlSeiten,
        Verlag,
        AutorenListe
) VALUES (
        'Lustiges Taschenbuch - Donald gibt nicht auf',
        6.00,
        7,
        'Vorgeschichte, Onkel Donald und die Unglücksschule, Donald und der "Fliegende Schotte", Donald und das Filmfestival, Onkel Dagobert un der zauberspiegel',
        null,
        DATE '1969-01-01',
        'DE',
        10,
        3,
        1,
        250,
        'Egmont Ehapa Media GmbH',
        'Gian Giacomo Dalmasso#Guido Martina#Romano Scarpa'
);


INSERT INTO BuchInformationen (
        Titel,
        Preis,
        Steuersatz,
        Beschreibung,
        ISBN,
        ErscheinungsDatum,
        Sprache,
        AnzahlVerfuegbar,
        Mindestbestand,
        AnzahlVerkauft,
        AnzahlSeiten,
        Verlag,
        AutorenListe
) VALUES (
        '1984 : Neu übersetzt von Jan Strümpel',
        6.95,
        7,
        'London, 1984: Winston Smith, Geschichtsfälscher im Staatsdienst, verliebt sich in die schöne und geheimnisvolle Julia.' ||
        'Gemeinsam beginnen sie, die totalitäre Welt infrage zu stellen, als Teil derer sie bisher funktioniert haben.' ||
        'Doch bereits ihre Gedanken sind Verbrechen, und der Große Bruder richtet seinen stets wachsamen Blick auf jeden potenziellen Dissidenten.' ||
        'George Orwells Vision eines totalitären Staats, in dem Cyberüberwachung, Geschichtsrevisionismus und Gedankenpolizei den Alltag gläserner Bürger bestimmen, hat wie keine andere Dystopie bis heute nur an Brisanz gewonnen.',
        3730609769,
        DATE '2021-01-18',
        'DE',
        20,
        10,
        30,
        400,
        'Anaconda Verlag',
        'George Orwell'
);




-- Accounts --

INSERT INTO Account (
        Email,
        PasswortHash,
        AccountTyp,
        LetzterLogin,
        Aktiv
) VALUES (
        'test@example.com',
        '$2a$10$/w/x/y/z/A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z',
        'Kunde',
        DATE '2022-01-01',
        1
);


INSERT INTO Account (
        Email,
        PasswortHash,
        AccountTyp,
        LetzterLogin,
        Aktiv
) VALUES (
        'test2@example.com',
        '$2admz/w/x/y/z/A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z',
        'Kunde',
        DATE '2021-01-01',
        1
);

INSERT INTO Account (
        Email,
        PasswortHash,
        AccountTyp,
        LetzterLogin,
        Aktiv
) VALUES (
        'sven.heiter@smail.th-koeln.de',
        '$2aqrs/w/x/y/z/A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z',
        'Kunde',
        DATE '2020-01-01',
        1
);




-- Kunden --

INSERT INTO Kunde (AccountID) VALUES (1);

INSERT INTO Kunde (AccountID) VALUES (2);

INSERT INTO Kunde (AccountID) VALUES (3);




-- Adressen --

INSERT INTO Adresse (
        Vorname,
        Nachname,
        Strasse,
        Hausnummer,
        Postleitzahl,
        Ort,
        KundenID
) VALUES (
        'Stefanie',
        'Rothschild',
        'Grosse Praesidenten Str. ',
        61,
        67752,
        'Oberweiler-Tiefenbach',
        1
);


INSERT INTO Adresse (
        Vorname,
        Nachname,
        Strasse,
        Hausnummer,
        Postleitzahl,
        Ort,
        KundenID
) VALUES (
        'Sebastian',
        'Adler',
        'Messedamm 42',
        42,
        01194,
        'Dresden',
        2
);


INSERT INTO ADRESSE (
        Vorname,
        Nachname,
        Strasse,
        Hausnummer,
        Postleitzahl,
        Ort,
        KundenID
) VALUES (
        'Sven',
        'Heiter',
        'Entenhausenerstraße',
        '4',
        '51645',
        'Gummersbach',
        3
);




-- Bestellungen mit Bestellposition --

/* Bestellung 1 (Offen)
 * 1 mal Känguru Comics; MwSt7; Stückpreis 22€
 * 2 mal LTB - Donald gibt nicht auf; MwSt7; Stückpreis 6€
 * Gesamtpreis: 34€
 */
INSERT INTO Bestellung (
        Datum,
        Status,
        RechnungsadresseID,
        LieferadresseID,
        KundenID,
        Gesamtpreis
) VALUES (
        DATE '2022-03-01',
        'offen',
        3,
        3,
        3,
        34.00
);

INSERT INTO Bestellposition (
        ArtikelID,
        BestellungID,
        Stueckpreis,
        Steuersatz,
        Menge
) VALUES (
        2,
        (SYSDATE || ' - ' || 1),
        22.00,
        7,
        1
);

INSERT INTO Bestellposition (
        ArtikelID,
        BestellungID,
        Stueckpreis,
        Steuersatz,
        Menge
) VALUES (
        3,
        (SYSDATE || ' - ' || 1),
        6.00,
        7,
        2
);


/* Bestellung 2 (zugestellt)
 * 1 mal Känguru Chroniken; MwSt7; Stückpreis 10.99€
 * 5 mal LTB - Donald gibt nicht auf; MwSt7; Stückpreis 6€
 * 3 mal George Orwell 1984; MwSt7; Stückpreis 6.95€
 * Gesamtpreis: 61.84€
 */

INSERT INTO Bestellung (
        Datum,
        Status,
        RechnungsadresseID,
        LieferadresseID,
        KundenID,
        Gesamtpreis
) VALUES (
        DATE '2022-03-02',
        'zugestellt',
        3,
        3,
        3,
        61.84
);


INSERT INTO Bestellposition (
        ArtikelID,
        BestellungID,
        Stueckpreis,
        Steuersatz,
        Menge
) VALUES (
        1,
        (SYSDATE || ' - ' || 2),
        10.99,
        7,
        1
);


INSERT INTO Bestellposition (
        ArtikelID,
        BestellungID,
        Stueckpreis,
        Steuersatz,
        Menge
) VALUES (
        3,
        (SYSDATE || ' - ' || 2),
        6.00,
        7,
        5
);


INSERT INTO Bestellposition (
        ArtikelID,
        BestellungID,
        Stueckpreis,
        Steuersatz,
        Menge
) VALUES (
        4,
        (SYSDATE || ' - ' || 2),
        6.95,
        7,
        3
);



/* Bestellung 3 (editierbar)
 * 1 mal LTB - Donald gibt nicht auf; MwSt7; Stückpreis 6€
 * Gesamtpreis: ?
 */

INSERT INTO Bestellung (
        Datum,
        Status,
        RechnungsadresseID,
        LieferadresseID,
        KundenID
) VALUES (
        DATE '2022-03-02',
        'editierbar',
        3,
        3,
        3
);


INSERT INTO Bestellposition (
        ArtikelID,
        BestellungID,
        Stueckpreis,
        Steuersatz,
        Menge
) VALUES (
        3,
        (SYSDATE || ' - ' || 3),
        6.00,
        7,
        1
);



/* Bestellung 4 (offen)
 * 4 mal LTB - Donald gibt nicht auf; MwSt7; Stückpreis 6€
 * Gesamtpreis: ?
 */

INSERT INTO Bestellung (
        Datum,
        Status,
        RechnungsadresseID,
        LieferadresseID,
        KundenID
) VALUES (
        add_months(SYSDATE, -1),
        'offen',
        3,
        3,
        3
);


INSERT INTO Bestellposition (
        ArtikelID,
        BestellungID,
        Stueckpreis,
        Steuersatz,
        Menge
) VALUES (
        3,
        (SYSDATE || ' - ' || 4),
        6.00,
        7,
        4
);


COMMIT;