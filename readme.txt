<------------GITHUB-------------------------------------------------->

Netbeans erstellt automatisch einen Ordner build im Projektordner.
Wenn dieser Ordner nicht gelöscht wird, werdet ihr nicht eure aktuellen
Änderungen sehen können. Genauer: Eure Arbeit ist in dem Ordner web, aber
wenn ihr das Programm startet wird automatisch die index.html / index.jsp in dem Ordner build geöffnet. Daher 

>>>>>LÖSCHT DIESE VOR JEDEM COMMIT

<--------------------------------------------------------------------->

<-------------------------------Datenbank----------------------------->
Datenbankname : USERS
Benutzername  : root
Passwort	  : Müsst ihr euer eigenes Eingeben (in den Dateien index.jsp , doLogin.jsp, register.jsp .. usw )
Also überall da wo auf die Datenbank zugegeriffen wird.

Tabellen(Achtet auf die Groß und Kleinschreibung bei den Tabellennamen und Spaltennamen)

1. Tabelle 
Tabellenname : administrator

Spalten: (auf die Reihenfolge achten)
Benutzername (Typ: Varchar , Size 30)
Passwort (Typ: Varchar, Size 20)

2.Tabelle
Tabellenname : benutzer

Spalten: (Wieder auf die Reihenfolge achten)
Vorname (Typ: Varchar,Size 30)
Nachname (Typ: Varchar,Size 30)
Email (Typ: Varchar,Size 50)
Passwort (Typ: Varchar,Size 20)
Benutzername (Typ: Varchar,Size 30)

<--------------------------------------------------------------------->









