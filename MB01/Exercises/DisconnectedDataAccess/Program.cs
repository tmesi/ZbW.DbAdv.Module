// Aufgabe 7: DumpDB (Musterlösung, SQLite-Variante)
//
// Aufruf:  DumpDB Contacts.db Person Contact
//
// Liest die angegebenen Tabellen verbindungslos in ein DataSet und gibt sie aus.
namespace DumpDB
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SQLite;
    using System.IO;
    using System.Linq;

    internal class Program
    {
        static int Main(string[] args)
        {
            if (args.Length < 2)
            {
                Console.WriteLine("usage: DumpDB DbFile TableName {TableName}");
                return 1;
            }

            SQLiteConnectionStringBuilder csb = new SQLiteConnectionStringBuilder();
            csb.DataSource = args[0];
            csb.FailIfMissing = true;     // sonst legt SQLite bei falschem Pfad still eine LEERE Datenbank an

            DataSet ds = new DataSet(Path.GetFileNameWithoutExtension(args[0]));

            using (SQLiteConnection con = new SQLiteConnection(csb.ConnectionString))
            {
                // Tabellennamen lassen sich NICHT als Parameter übergeben.
                // -> gegen die Liste der existierenden Tabellen prüfen (Whitelist), statt blind zu verketten.
                HashSet<string> existing = ReadTableNames(con);

                for (int i = 1; i < args.Length; i++)
                {
                    string tableName = args[i];
                    if (!existing.Contains(tableName))
                    {
                        Console.WriteLine($"Tabelle '{tableName}' existiert nicht – übersprungen.");
                        continue;
                    }

                    using (SQLiteDataAdapter adapter = new SQLiteDataAdapter($"SELECT * FROM \"{tableName}\"", con))
                    {
                        adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;   // Primärschlüssel mitladen
                        adapter.Fill(ds, tableName);                                     // Fill öffnet und schliesst die Verbindung selbst
                    }
                }
            }
            // ab hier: keine Verbindung mehr – das DataSet lebt allein im Hauptspeicher

            foreach (DataTable table in ds.Tables)
            {
                string pk = string.Join(",", table.PrimaryKey.Select(c => c.ColumnName));
                Console.WriteLine($"=== {table.TableName} ({table.Rows.Count} Zeilen, PK: {pk})");
                Console.WriteLine(string.Join("\t", table.Columns.Cast<DataColumn>().Select(c => c.ColumnName)));

                foreach (DataRow row in table.Rows)
                {
                    Console.WriteLine(string.Join("\t", row.ItemArray));
                }
                Console.WriteLine();
            }
            return 0;
        }

        static HashSet<string> ReadTableNames(SQLiteConnection con)
        {
            HashSet<string> names = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            con.Open();

            using (SQLiteCommand cmd = new SQLiteCommand(
                       "SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE 'sqlite_%'", con))
            using (SQLiteDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    names.Add(reader.GetString(0));
                }
            }

            con.Close();
            return names;
        }
    }
}
