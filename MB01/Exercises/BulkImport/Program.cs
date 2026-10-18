// Aufgabe 12: Transaktionen und Performance – Ausgangslage
//
// contacts_import.csv enthält 5000 Kontakte (Format: FirstName;Name;EMail;Phone;PersonID).
// ACHTUNG: Eine Zeile gegen Ende ist fehlerhaft (ungültige PersonID).
//
//  a) Importieren Sie die Datei OHNE explizite Transaktion. Messen Sie die Zeit (Stopwatch).
//     Wie viele Zeilen stehen danach in der Tabelle Contact?
//  b) Importieren Sie die Datei in EINER Transaktion. Zeit? Anzahl Zeilen danach?
//  c) Verwenden Sie EIN Command-Objekt mit Parametern, das Sie für jede Zeile wiederverwenden
//     (cmd.Prepare()). Bringt das zusätzlich etwas?
//  d) Erklären Sie die Unterschiede. Was hat die Zeitmessung mit der Dauerhaftigkeit (das D in ACID) zu tun?
//
// Tipp: Vor jedem Durchlauf die Testdaten entfernen:  DELETE FROM Contact WHERE ID > 10
// Wichtig: "Foreign Keys=True" im ConnectionString – sonst prüft SQLite die PersonID gar nicht!
namespace BulkImport
{
    using System;
    using System.Data.SQLite;
    using System.Diagnostics;
    using System.IO;
    using System.Linq;

    internal class Program
    {
        static void Main(string[] args)
        {
            // Dateien liegen neben der .exe (werden beim Build kopiert)
            string dir = AppContext.BaseDirectory;
            string connectionString = $"Data Source={Path.Combine(dir, "Contacts.db")};FailIfMissing=True;Foreign Keys=True";

            string[] lines = File.ReadAllLines(Path.Combine(dir, "contacts_import.csv")).Skip(1).ToArray();   // Kopfzeile überspringen
            Console.WriteLine($"{lines.Length} Zeilen gelesen");

            Stopwatch sw = Stopwatch.StartNew();
            using (SQLiteConnection con = new SQLiteConnection(connectionString))
            {
                con.Open();

                // TODO: Import implementieren (a, b, c)

            }
            sw.Stop();
            Console.WriteLine($"Dauer: {sw.ElapsedMilliseconds} ms");
        }
    }
}
