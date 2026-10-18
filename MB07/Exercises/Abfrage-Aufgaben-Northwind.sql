USE [Northwind]

/*
	1. INNER JOIN

	Aufgabe:
	Gib alle Bestellungen aus und zeige dazu den Firmennamen des Kunden sowie das Bestelldatum an.
*/

/*
2. INNER JOIN + WHERE

Aufgabe:
Zeige alle Bestellungen aus dem Jahr 1997 an, inklusive Kundenname und vollständigem Namen des Mitarbeiters.
*/

/*
3. INNER JOIN (mehrere Tabellen)

Aufgabe:
Zeige für alle Bestellpositionen die Bestellnummer, den Produktnamen, die Menge und den Einzelpreis an.
*/

/*
4. LEFT JOIN (fehlende Datensätze erkennen)

Aufgabe:
Liste alle Kunden und deren Bestellungen auf. Kunden ohne Bestellungen sollen ebenfalls erscheinen.
*/



/*
5. LEFT JOIN + WHERE (NULL-Filterung)

Aufgabe:
Ermittle alle Kunden, die noch nie eine Bestellung aufgegeben haben.
*/


/*
6. LEFT JOIN mit Aggregation

Aufgabe:
Zeige für jeden Kunden die Anzahl seiner Bestellungen an – auch Kunden ohne Bestellungen.
*/


/*
7. FULL OUTER JOIN

Aufgabe:
Erstelle eine Ergebnismenge, die alle Kunden und alle Bestellungen enthält – auch wenn auf einer Seite kein entsprechender Datensatz existiert.
*/


/*
8. FULL OUTER JOIN + WHERE

Aufgabe:
Identifiziere Kunden ohne Bestellungen sowie Bestellungen ohne zugeordneten Kunden (Datenintegritätsprüfung).
*/



/*
9. CROSS JOIN

Aufgabe:
Erzeuge alle möglichen Kombinationen von Produkten und Versandfirmen.
*/



/*
10. CROSS JOIN mit WHERE

Aufgabe:
Erstelle eine Preissimulation, bei der alle Produkte mit Rabattstufen von 5 %, 10 % und 15 % kombiniert werden.
*/


/*
11. GROUP BY (einfache Aggregation)

Aufgabe:
Berechne den Gesamtumsatz pro Bestellung.
*/


/*
12. GROUP BY mit mehreren Aggregaten

Aufgabe:
Zeige pro Produkt die verkaufte Gesamtmenge, den durchschnittlichen Einzelpreis und den Gesamtumsatz an.
*/



/*
13. GROUP BY + HAVING

Aufgabe:
Liste alle Kunden auf, die mehr als 10 Bestellungen aufgegeben haben.
*/



/*
14. GROUP BY mit Datumslogik

Aufgabe:
Zeige den Gesamtumsatz pro Jahr an.
*/


/*
15. Skalar-Subquery

Aufgabe:
Zeige alle Produkte, deren Einzelpreis über dem durchschnittlichen Produktpreis liegt.
*/


/*
16. Subquery in WHERE (IN)

Aufgabe:
Liste alle Kunden auf, die Produkte aus der Kategorie „Beverages“ bestellt haben.
*/


/*
17. Korrelierte Subquery

Aufgabe:
Zeige alle Mitarbeiter, die mehr Bestellungen bearbeitet haben als der durchschnittliche Mitarbeiter.
*/



/*
18. Einfache CTE

Aufgabe:
Berechne mit einer CTE den Gesamtumsatz pro Bestellung und zeige nur Bestellungen mit einem Umsatz über 10’000 an.
*/



/*
19. CTE mit JOIN

Aufgabe:
Berechne den Gesamtumsatz pro Kunde mithilfe einer CTE und verbinde das Ergebnis mit der Kundentabelle.
*/



/*
20. CTE + GROUP BY + HAVING

Aufgabe:
Erstelle eine CTE, die den Absatz pro Produkt aggregiert, und gib nur Produkte aus, von denen mehr als 1’000 Stück verkauft wurden.
*/

