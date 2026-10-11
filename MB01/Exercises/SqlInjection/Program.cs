// Aufgabe 11: SQL-Injection – Ausgangslage (absichtlich UNSICHER!)
//
// Das Programm sucht Kontakte anhand der E-Mail-Adresse.
//  a) Finden Sie Eingaben, mit denen Sie
//       1. ALLE Kontakte sehen,
//       2. die Tabellendefinitionen der Datenbank (sqlite_master) sehen.
//  b) Beheben Sie die Lücke mit einem Parameter.
//  c) Warum lässt sich der Tabellenname (siehe ListTable) NICHT als Parameter übergeben?
//     Wie schützen Sie diese Stelle trotzdem?
namespace SqlInjection
{
    using System;
    using System.Data.SQLite;
    using System.IO;

    internal class Program
    {
        // Contacts.db liegt neben der .exe (wird beim Build kopiert)
        static readonly string ConnectionString =
            $"Data Source={Path.Combine(AppContext.BaseDirectory, "Contacts.db")};FailIfMissing=True";

        static void Main(string[] args)
        {
            while (true)
            {
                Console.Write("\nE-Mail (leer = Ende): ");
                string? email = Console.ReadLine();
                if (string.IsNullOrEmpty(email))
                {
                    break;
                }
                FindByEmail(email);
            }

            Console.Write("\nTabelle anzeigen: ");
            ListTable(Console.ReadLine() ?? "Person");
        }

        static void FindByEmail(string email)
        {
            using (SQLiteConnection con = new SQLiteConnection(ConnectionString))
            {
                con.Open();
                using (SQLiteCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = "SELECT FirstName, Name, Phone FROM Contact WHERE EMail = '" + email + "'";   // <-- !!!

                    using (SQLiteDataReader reader = cmd.ExecuteReader())
                    {
                        int count = 0;
                        while (reader.Read())
                        {
                            Console.WriteLine($"  {reader[0]} {reader[1]}  {reader[2]}");
                            count++;
                        }
                        Console.WriteLine($"  ({count} Treffer)");
                    }
                }
            }
        }

        static void ListTable(string table)
        {
            using (SQLiteConnection con = new SQLiteConnection(ConnectionString))
            {
                con.Open();
                using (SQLiteCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = "SELECT * FROM " + table;                                                   // <-- !!!

                    using (SQLiteDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            object[] values = new object[reader.FieldCount];
                            reader.GetValues(values);
                            Console.WriteLine("  " + string.Join(" | ", values));
                        }
                    }
                }
            }
        }
    }
}
