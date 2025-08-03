[//]: # (######################################################)
[//]: # (#                                                    #)
[//]: # (#         SQL-Grundlagen - Sakila - Aufgaben         #)
[//]: # (#                                                    #)
[//]: # (######################################################)

[//]: # (@author      Christian Locher <locher@faithpro.ch>)
[//]: # (@copyright   2025 Faithful programming)
[//]: # (@license     http://www.gnu.org/licenses/gpl-3.0.en.html GNU/GPLv3)
[//]: # (@version     2025-05-13)

# SQL-Aufgaben

## Grundlagen

01. Gib alle Informationen aus der Tabelle actor aus.
02. Zeige nur die Vornamen aller Schauspieler.
03. Wie viele Filme gibt es in der Datenbank?
04. Zeige die Titel aller Filme, die 'PG' als Rating haben.
05. Zeige alle einzigartigen Vornamen der Kunden (customer).
06. Finde den längsten Filmtitel.
07. Gib die Anzahl der Schauspieler mit dem Nachnamen 'KILMER' aus.
08. Zeige alle Filme, die länger als 120 Minuten dauern.

## JOINs und Bedingungen

09. Zeige alle Kunden mit ihrem vollständigen Namen und der Stadt.
10. Zeige alle Filme und ihre Kategorien.
11. Zeige alle Filme mit dem Namen der Schauspielerin GINA DEGENERES (actor mit ID = 107).
12. Liste die Anzahl der Filme pro Kategorie.
13. Finde alle Kunden, die in 'California' wohnen.
14. Zeige die Top 5 Filme mit der höchsten Mietrate.
15. Zeige Kunden, die keinen aktiven Account haben.
16. Zeige alle Filme, die in keiner Kategorie sind (leere Antwort).

## Aggregationen und Unterabfragen

17. Wie viele Kunden wohnen in jeder Stadt?
18. Welche Kategorie hat die meisten Filme?
19. Finde den durchschnittlichen Mietpreis pro Kategorie.
20. Finde alle Kunden, die mehr als 40 Zahlungen getätigt haben.
21. Finde alle Filme, deren Mietdauer über dem Durchschnitt liegt.
22. Zeige alle Zahlungen, die höher als der Durchschnittswert sind.
23. Finde Kunden, die niemals etwas gemietet haben (leere Antwort).
24. Welche Schauspieler haben in den meisten Filmen mitgespielt?

## Komplexe Analysen

25. Finde die Filme, die von den meisten verschiedenen Kunden ausgeliehen wurden.
26. Wie viel Umsatz wurde pro Store gemacht?
27. Zeige für jeden Kunden den Gesamtumsatz und die durchschnittliche Zahlung.
28. Finde alle Filme, die innerhalb von 24 Stunden mehrfach ausgeliehen wurden (vom selben Inventory; leere Antwort).
29. Verwende eine Window Function, um den Rang (nach Umsatz) jedes Kunden zu berechnen.
30. Zeige für jeden Schauspieler die Anzahl Filme und seinen Anteil (%) an allen Filmen.
31. Erstelle eine View, die alle Zahlungen mit Kundenname, Store, Film, Betrag und Datum zeigt.
32. [Sehr schwer] Finde alle Kunden, deren durchschnittliche Zahlung höher ist als die aller Kunden ihres Landes.
