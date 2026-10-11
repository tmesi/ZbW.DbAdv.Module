// KontakteLive – Einstieg und Befehls-Verteiler.
//
// Jeder Theorieblock fügt EINEN Befehl hinzu (Dateien S00_ ... S12_).
// Im Unterricht: Methodenrumpf auskommentieren und live schreiben,
// die fertige Version ist der "Rettungsanker", falls beim Live-Coding etwas klemmt.
namespace KontakteLive
{
    using System;
    using System.Data.SQLite;
    using System.Linq;
    using System.Threading.Tasks;

    internal class Program
    {
        static async Task Main(string[] args)
        {
            if (args.Length > 0)
            {
                // Ein einzelner Befehl, z.B. "KontakteLive lock" (für Demos mit zwei Terminals)
                await Dispatch(args[0], string.Join(' ', args.Skip(1)));
                return;
            }

            PrintHelp();
            while (true)
            {
                Console.Write("\nkontakte> ");
                string? line = Console.ReadLine();
                if (line == null)
                {
                    break;
                }

                line = line.Trim();
                if (line == "exit" || line == "quit")
                {
                    break;
                }
                if (line.Length == 0)
                {
                    continue;
                }

                string[] parts = line.Split(' ', 2);
                await Dispatch(parts[0], parts.Length > 1 ? parts[1].Trim() : "");
            }
        }

        static async Task Dispatch(string command, string rest)
        {
            try
            {
                switch (command.ToLowerInvariant())
                {
                    case "help":
                        PrintHelp();
                        break;

                    // Block 1 – Verbindungsorientierter Zugriff (Repetition)
                    case "init":
                        S00_Init.Run();
                        break;
                    case "list":
                        S01_List.Run();
                        break;
                    case "sql":
                        S01_List.RunSql(Ask(rest, "SQL"));
                        break;
                    case "search-unsafe":
                        S02_Search.Unsafe(Ask(rest, "Suchtext"));
                        break;
                    case "search":
                        S02_Search.Safe(Ask(rest, "Suchtext"));
                        break;
                    case "count":
                        S03_Add.Count();
                        break;
                    case "add":
                        S03_Add.Add();
                        break;

                    // Block 2 – Transaktionen
                    case "delete":
                        S04_Delete.Run(rest, true);
                        break;
                    case "delete-notx":
                        S04_Delete.Run(rest, false);
                        break;
                    case "bulk":
                        S05_Bulk.Run(rest.Length > 0 ? int.Parse(rest) : 1000);
                        break;
                    case "lock":
                        S06_Locking.HoldLock();
                        break;
                    case "isolation":
                        S06_Locking.IsolationLevels();
                        break;
                    case "provider":
                        S07_Provider.Run(rest.Length > 0 ? rest : "sqlite");
                        break;

                    // Block 3 – Verbindungsloser Zugriff
                    case "dataset":
                        S08_DataSet.Run();
                        break;
                    case "rowstates":
                        S08_DataSet.RowStates();
                        break;
                    case "edit":
                        S09_Edit.Run(rest, false);
                        break;
                    case "edit-lastwins":
                        S09_Edit.Run(rest, true);
                        break;
                    case "view":
                        S10_View.Run(rest);
                        break;

                    // Block 4 – XML und Ausblick
                    case "export":
                        S11_Xml.Export();
                        break;
                    case "import":
                        S11_Xml.Import();
                        break;
                    case "diffgram":
                        S11_Xml.DiffGram();
                        break;
                    case "async":
                        await S12_Async.RunAsync();
                        break;

                    default:
                        Console.WriteLine($"Unbekannter Befehl '{command}' – 'help' zeigt alle Befehle.");
                        break;
                }
            }
            catch (SQLiteException ex)
            {
                Console.WriteLine($"SQLite-Fehler [{ex.ResultCode}]: {ex.Message}");
                if (ex.ResultCode == SQLiteErrorCode.CantOpen)
                {
                    Console.WriteLine("Tipp: Datenbank fehlt? Zuerst 'init' ausführen.");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"{ex.GetType().Name}: {ex.Message}");
            }
        }

        static string Ask(string given, string prompt)
        {
            if (given.Length > 0)
            {
                return given;
            }
            Console.Write($"{prompt}: ");
            return Console.ReadLine() ?? "";
        }

        static void PrintHelp()
        {
            Console.WriteLine("""
                KontakteLive – ADO.NET mit SQLite                         (exit = beenden)

                Block 1  Verbindungsorientiert
                  init                       Datenbank aus Contacts.sql neu erstellen
                  list                       Kontakte mit DataReader lesen
                  sql <SELECT ...>           beliebiges SQL ausführen und anzeigen
                  search-unsafe <text>       Suche per String-Verkettung (SQL-Injection!)
                  search <text>              Suche mit Parameter
                  count | add                ExecuteScalar | INSERT ... RETURNING

                Block 2  Transaktionen
                  delete <personId> [crash]       Person + Kontakte löschen, MIT Transaktion
                  delete-notx <personId> [crash]  dasselbe OHNE Transaktion
                  bulk [n]                        n Inserts: ohne / mit Transaktion / prepared
                  lock                            Schreibsperre halten (zweites Terminal!)
                  isolation                       welche IsolationLevels kennt der Provider?
                  provider [sqlite|sqlserver]     gleicher Code, anderer Provider

                Block 3  Verbindungslos
                  dataset                    DataSet + DataRelation, Navigation
                  rowstates                  RowState / DataRowVersion live beobachten
                  edit <contactId> <phone>   DataAdapter + CommandBuilder (Konflikt-Demo)
                  edit-lastwins <id> <phone> dasselbe mit ConflictOption.OverwriteChanges
                  view [prefix]              DataView: Filter, Sortierung, Find

                Block 4  XML + Ausblick
                  export | import | diffgram DataSet <-> XML
                  async                      ExecuteReaderAsync
                """);
        }
    }
}
