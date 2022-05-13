# DB2-Bücherwurm

Ein phänomenaler Bücherwurm der Generation X!



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

| Name | Folien |
| ------ | ------ |
| Sven | 1 -3  |
| Jesaja | 4 |
|Dennis|5|
|Leo|6|
|Caner |7|
|Jesaja|8|



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




## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://git.st.archi-lab.io/dkliewer/db2-buecherwurm.git
git branch -M master
git push -uf origin master
```

## Integrate with your tools

- [ ] [Set up project integrations](https://git.st.archi-lab.io/dkliewer/db2-buecherwurm/-/settings/integrations)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Automatically merge when pipeline succeeds](https://docs.gitlab.com/ee/user/project/merge_requests/merge_when_pipeline_succeeds.html)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing(SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***

# Editing this README

When you're ready to make this README your own, just edit this file and use the handy template below (or feel free to structure it however you want - this is just a starting point!).  Thank you to [makeareadme.com](https://www.makeareadme.com/) for this template.

## Suggestions for a good README
Every project is different, so consider which of these sections apply to yours. The sections used in the template are suggestions for most open source projects. Also keep in mind that while a README can be too long and detailed, too long is better than too short. If you think your README is too long, consider utilizing another form of documentation rather than cutting out information.

## Name
Choose a self-explaining name for your project.

## Description
Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with. A list of Features or a Background subsection can also be added here. If there are alternatives to your project, this is a good place to list differentiating factors.

## Badges
On some READMEs, you may see small images that convey metadata, such as whether or not all the tests are passing for the project. You can use Shields to add some to your README. Many services also have instructions for adding a badge.

## Visuals
Depending on what you are making, it can be a good idea to include screenshots or even a video (you'll frequently see GIFs rather than actual videos). Tools like ttygif can help, but check out Asciinema for a more sophisticated method.

## Installation
Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support
Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
For open source projects, say how it is licensed.

## Project status
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.
