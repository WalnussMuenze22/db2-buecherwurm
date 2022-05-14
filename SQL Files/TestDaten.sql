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


INSERT INTO Account (
    EMail,
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
    EMail,
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

INSERT INTO Kunde (
    AccountID
) VALUES (
    1
);

INSERT INTO Kunde (
    AccountID
) VALUES (
    2
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


INSERT INTO Bestellung (
    Datum,
    Status,
    RechnungsadresseID,
    LieferadresseID,
    KundenID,
    Gesamtpreis
) VALUES (
    DATE '2022-01-01',
    'offen',
    1,
    1,
    1,
    0
);


INSERT INTO Bestellung (
    Datum,
    Status,
    RechnungsadresseID,
    LieferadresseID,
    KundenID,
    Gesamtpreis
) VALUES (
    DATE '2021-01-01',
    'offen',
    2,
    2,
    2,
    0
);