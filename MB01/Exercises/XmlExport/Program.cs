// Aufgabe 8: ExportXML (Musterlösung, SQLite-Variante)
//
// Aufruf:  ExportXML "Data Source=Contacts.db;FailIfMissing=True" contacts.xml
//
// Liest ALLE Tabellen einer Datenbank in ein DataSet und speichert Schema + Daten als XML.
namespace ExportXML
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
            if (args.Length != 2)
            {
                Console.WriteLine("usage: ExportXML ConnectionString OutputFile");
                return 1;
            }

            Console.WriteLine("Loading data ...");
            DataSet? ds = LoadData(args[0]);
            if (ds == null)
            {
                Console.WriteLine("Could not load data!");
                return 1;
            }

            Console.WriteLine("Writing data ...");
            ds.WriteXml(args[1], XmlWriteMode.WriteSchema);   // Schema (XSD) + Daten in einer Datei
            Console.WriteLine($"{ds.Tables.Count} Tabellen nach {Path.GetFullPath(args[1])} exportiert.");

            // Kontrolle: Datei wieder einlesen (Roundtrip)
            DataSet check = new DataSet();
            check.ReadXml(args[1], XmlReadMode.ReadSchema);
            foreach (DataTable t in check.Tables)
            {
                string pk = string.Join(",", t.PrimaryKey.Select(c => c.ColumnName));
                Console.WriteLine($"  {t.TableName}: {t.Rows.Count} Zeilen, PK = {pk}");
            }
            return 0;
        }

        static DataSet? LoadData(string connStr)
        {
            try
            {
                using (SQLiteConnection conn = new SQLiteConnection(connStr))
                {
                    conn.Open();

                    DataSet ds = new DataSet("Contacts");

                    // Access/OleDb: conn.GetOleDbSchemaTable(...)
                    // SQLite:       Systemkatalog sqlite_master abfragen (alternativ conn.GetSchema("Tables"))
                    List<string> tableNames = new List<string>();
                    using (SQLiteCommand cmd = new SQLiteCommand(
                               "SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE 'sqlite_%' ORDER BY name", conn))
                    using (SQLiteDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            tableNames.Add(reader.GetString(0));
                        }
                    }

                    foreach (string tableName in tableNames)
                    {
                        using (SQLiteDataAdapter adapter = new SQLiteDataAdapter($"SELECT * FROM \"{tableName}\"", conn))
                        {
                            adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
                            adapter.Fill(ds, tableName);
                        }
                    }

                    // Bonus: Fremdschlüssel als DataRelation ins DataSet übernehmen,
                    // damit sie im XML-Schema (xs:keyref) auftauchen.
                    AddRelations(conn, ds);
                    return ds;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return null;
            }
        }

        static void AddRelations(SQLiteConnection conn, DataSet ds)
        {
            foreach (DataTable child in ds.Tables)
            {
                // Tabellenname stammt aus sqlite_master (nicht vom Benutzer) -> Verkettung hier unkritisch
                string sql = $"SELECT \"table\", \"from\", \"to\" FROM pragma_foreign_key_list('{child.TableName}')";

                using (SQLiteCommand cmd = new SQLiteCommand(sql, conn))
                using (SQLiteDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        string parentTable = reader.GetString(0);
                        string fromCol = reader.GetString(1);
                        string toCol = reader.GetString(2);

                        if (!ds.Tables.Contains(parentTable))
                        {
                            continue;
                        }

                        ds.Relations.Add($"{parentTable}_{child.TableName}",
                            ds.Tables[parentTable]!.Columns[toCol]!,
                            child.Columns[fromCol]!);
                    }
                }
            }
        }
    }
}
