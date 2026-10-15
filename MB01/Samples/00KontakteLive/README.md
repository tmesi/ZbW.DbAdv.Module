# KontakteLive – durchgehende Live-Demo zu MB01 ADO.NET

Eine kleine Kontaktverwaltung als Konsolen-App. Pro Theorieblock kommt **ein Befehl** dazu.
Am Ende der Lektion haben die Studierenden gesehen, wie dieselbe App vom `DataReader`
über Transaktionen bis zum `DataSet`/`DataAdapter` und XML wächst.

| Datei        | Befehl(e)                      | Folien         | Kernaussage                                                      |
| ------------ | ------------------------------ | -------------- | ---------------------------------------------------------------- |
| S00_Init     | `init`                         | 4–10           | SQLite = eine Datei, kein Server, kein Treiber                   |
| S01_List     | `list`, `sql`                  | 15–18, 32–34   | Programmmuster, `using`, typsicheres Lesen, NULL                 |
| S02_Search   | `search-unsafe`, `search`      | 30–31          | SQL-Injection live – und die Lösung                              |
| S03_Add      | `count`, `add`                 | 26–27          | `ExecuteScalar` (Int64!), `RETURNING`, Fremdschlüssel            |
| S04_Delete   | `delete`, `delete-notx`        | 37–41          | Absturz mit/ohne Transaktion                                     |
| S05_Bulk     | `bulk`                         | 37–41          | Transaktion = auch Performance (Faktor 50–500)                   |
| S06_Locking  | `lock`, `isolation`            | 42             | ein Schreiber, viele Leser; IsolationLevel ist provider-abhängig |
| S07_Provider | `provider sqlite\|sqlserver`   | 5–6, 13, 21–22 | `DbProviderFactory`: gleicher Code, zwei DBs                     |
| S08_DataSet  | `dataset`, `rowstates`         | 44–61          | Hauptspeicher-DB, Relation, RowState/Version                     |
| S09_Edit     | `edit`, `edit-lastwins`        | 67–75          | `CommandBuilder`, `DBConcurrencyException`                       |
| S10_View     | `view`                         | 63–64          | Filtern/Sortieren/Suchen ohne DB                                 |
| S11_Xml      | `export`, `import`, `diffgram` | 80–81          | DataSet ↔ XML, DiffGram                                          |
| S12_Async    | `async`                        | ersetzt 28–29  | `async/await` statt Begin/End                                    |

## Start

* **Visual Studio:** Profil „KontakteLive (interaktiv)“ → `kontakte>`-Prompt. Zuerst `init`.
* **Zwei Terminals** (für `lock` und `edit`): einmal bauen, dann in `bin\Debug\net9.0`
  zwei Terminals öffnen und `.\KontakteLive.exe lock` bzw. `.\KontakteLive.exe list` ausführen.
  (Zweimal parallel `dotnet run` vermeiden – die beiden Builds sperren sich gegenseitig.)
* Zurücksetzen jederzeit mit `init`.

## Live-Coding-Tipp

Vor der Lektion die Rümpfe der `Run`-Methoden auskommentieren und im Unterricht live schreiben.
Die fertigen Dateien sind der Rettungsanker (`git stash` / `git checkout -- S04_Delete.cs`).

## Pakete

`System.Data.SQLite` 2.x bringt die native SQLite-Bibliothek nicht mehr mit –
`SourceGear.sqlite3` liefert sie. Fehlt das Paket: *Unable to load DLL 'e_sqlite3'*.
