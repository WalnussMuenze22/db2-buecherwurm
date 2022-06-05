# DB2-Bücherwurm

Ein phänomenaler Bücherwurm der Generation X!


# Abnahme 2 vom 18.05.2022

- Sven Prozedur : Mit SUM(*) Funktion umsetzen
- Jesaja Trigger: Trigger bei Update auslösen lassen
- Caner Prozedur: generieren des PKs direkt im Trigger
- Dennis Trigger: Name ändern


# Team Meeting vom 12.05.2022

TOCheck:
-überprüfen, dass Artikel nicht doppelt in der Nachbestelltabelle landen
-überprüfen, ob Serverextensions fehlen (Emailtrigger ->Leo)


nächstes (wenn 3/5 fertig sind) Freitag, 13.05.2022


TODO:

Sven: Dokumentation aktualisieren

        -Caners Trigger -> statt "auf Mindestbestand" -> "über Mindestbestand"
        -purgeAutor ersetzen durch folgenden Trigger:
        ->Event: Table Account INSERT
        ->Action: Gebe Meldung auf die Konsole aus, dass Kunde mit ID ... von DB Account ... erstellt   wurde (   +Uhrzeit ?)

        -Funktionen ersetzen: -> Sven (Dokumentation)

                ->showCustomersOfPendingOrders -> (gibt alternativen Surrogate Key als BestellungsID zurück)
                ->purgeInacteCustomer -> (Email an Kunden, dass er zu lange inaktiv war)
                ->showStatistics -> (Meistverkaufte Buch)
        -Bestellungen haben 4 Modi ("wird erstellt", "offen", "versendet", "zugestellt")


-Bestellposition -> Bestellbezeichnung einfügen; Bezeichnung aus Titel + ISBN zusammensetzen
        WICHTIG : Daten werden kopiert und zusammengefügt; Keine Referenzen!

#Team Meeting vom 24.04.2022

Dokumentation und Präsentation wurden erstellt


Präsentationsanteile wurden verteilt:

| Name   | Folien |
|--------|--------|
| Sven   | 1 -3   |
| Jesaja | 4      |
| Dennis | 5      |
| Leo    | 6      |
| Caner  | 7      |
| Jesaja | 8      |



nächstes Meeting: 25.04.2022 (Generalprobe)
Aufgabe bis dahin für jeden:
Stichpunkte zu seinen eigenen Folien machen

## Team Meeting vom 21.04.2022

Besprechung und Aufteilung der Trigger und Funktionen

Trigger:
- Preis der Bestellposition einer Bestellung hinzufügen (BEI: Erstellung einer Bestellposition) --> Jesaja
- entfernte Accounts archivieren (BEI: Entfernen eines bestehenden Accounts) -->Dennis
- Waren werden der Nachbestelltabelle hinzugefügt(BEI:zu wenig Stückzahlen **Mindestbestand** nach/bei Kauf -->Caner
-Autoren von entfernten Artikeln löschen (Autoren ohne Buch) BEI: Löschung des Artikels aus dem Sortiment -> „hat Autor überhaupt noch Artikel?“ -->Leo
- WENN: es ein meistverkauftes Buch letzten Monat gab DANN: erhöhe **Mindestbestand**
- Bestand bei Bestellung verringern WENN: Bestellstatus : OFFEN  --> Sven 

- NOCH OFFEN : -WENN: es ein meistverkauftes Buch letzten Monat gab DANN: erhöhe **Mindestbestand**

Funktionen
- Karteileichen entfernen (Wann, löschen oder inaktiv schalten?) --> Leo
- Statistiken ausgeben (Scheduler?) --> Dennis
- Den Umsatz in einem bestimmten Zeitraum zurückgeben  --> Sven
- Mindestbestand der Artikel anhand der Verkaufszahlen des letzten Monats erhöhen/vermindern --> Jesaja
- Alle Kunden, die eine offene Bestellung haben ausgeben lassen --> Caner


**View & INSTEAD-OF-Trigger :** Buchdaten (Alle Informationen)

Aufgaben:
Sven : Dokumentation und Präsentation
Jeder:  Planung der Trigger und Funktionen
        Ziele und Umfang (Do's und Don'ts) des Projekts verfassen


nächstes Teamtreffen Samstag 23.04.2022 17 Uhr
## Team Meeting Protokoll vom 20.04.2022




Trigger:  
-Bei anlegen von Bestellposition -> Preis und Steuersatz kopieren 
- 1 x pro Woche aufrufen -> Wochen-Gesamtumsatz/Verlust 
- 1x pro Monat aufrufen -> Monats-Gesamtumsatz/Verlust, - Bei neuer Bestellposition Funktion Verkaufszahlen der Bücher aufrufen 
- 1x Monat -> Wachstumsrate Verkäufe von Artikeln ermitteln (eigene Tabelle) 
- 1x Monat -> Funktion Karteileichen entfernen 

Funktionen: 
- Wochen-Gesamtumsatz/Verlust 
- Monats-Gesamtumsatz/Verlust 
- (wird von View aufgerufen) Gesamtausgaben Kunden - Verkaufszahlen der Bücher 
- Top 10 Artikel 
- Karteileichen entfernen. Wenn Account 2 Jahre nicht genutzt, dann löschen 
- Wachstumsrate Verkäufe von Artikeln ermitteln (eigene Tabelle) 

View:  
- Kunden mit ihrem Umsatz 
- Instead-Of-Trigger: Wichtigste (aktuelle) Inhalte (Key/Value) 

@Caner ner wir haben noch folgende Tabellen angepasst: 
+ Account.letzterLogin 
- Sprecher.Vorname 
+ 4x Statistik Tabellen


## Team Meeting Protokoll vom 17.04.2022

Erarbeitung des EERMs

Folgetermin: 18.04.22 14 Uhr - Backendtreffen und Use Case Diagramm 


## Team Meeting Protokoll vom 12.04.2022

Projektidee: Online Buchhandel über eine interaktive Webseite

Besprochenen Bestandteile des EERM:
1.	Artikel -> Hörbücher, Bücher
2.	Kunden
2.1	Kundenbestellungen
2.2	Lagerbestand
3.	Einkäufe
4.	Statistiken (Wochen/Monats-Gesamtumsatz/Verlust, Gesamtausgaben Kunden, Verkaufszahlen der Bücher, Top 10 meist verkaufte Bücher)

Features oder SchnickSchnack:
-Karteileichen entfernen
-Tabelle für Steuersätze
-Treuepunkte
-Tabelle für Fehlercodes

Don’ts:
-Warenkorb
-Reklamation (zu viel Aufwand)

**Verteilte Aufgaben bis nächsten Sonntag 17.04.22:**
- Lastenheft Recherche  Sven
- Dokumentation         Sven
- Erstellung und Verwaltung des Git Repos   Dennis
- Vorbereitung/Planung der Präsentation     Caner,Sven
- Erstellung des Webservers                 Dennis
- Backend mit PHP			                Jesaja	  
              
**Aufgabe für **jeden**: EERM + Use Case Diagramm erstellen**


