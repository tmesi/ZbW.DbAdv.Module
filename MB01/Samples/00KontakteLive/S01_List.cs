namespace KontakteLive
{
    using System;
    using System.Data.SQLite;

    // Folien 15–18, 32–34: Programmmuster, IDataReader
    internal static class S01_List
    {
        public static void Run()
        {
            using (SQLiteConnection con = Db.Open())          // using = Close/Dispose garantiert (ersetzt finally)
            using (SQLiteCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = """
                    SELECT c.ID, c.FirstName, c.Name, c.Phone, p.Name AS Owner
                      FROM Contact c
                      JOIN Person p ON p.ID = c.PersonID
                     ORDER BY c.Name, c.FirstName
                    """;

                using (SQLiteDataReader reader = cmd.ExecuteReader())
                {
                    // Metadaten: was liefert die Abfrage?
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        Console.Write($"{reader.GetName(i)}:{reader.GetDataTypeName(i)}  ");
                    }
                    Console.WriteLine("\n");

                    while (reader.Read())
                    {
                        long id = reader.GetInt64(0);                                  // typsicher über Ordinal
                        string first = reader.IsDBNull(1) ? "" : reader.GetString(1);  // NULL-Prüfung!
                        string name = (string)reader["Name"];                          // über Spaltenname
                        string phone = reader["Phone"] as string ?? "-";
                        Console.WriteLine($"{id,3}  {first,-10} {name,-12} {phone,-15} Adressbuch von {reader.GetString(4)}");
                    }
                }
            }
        }

        /// <summary>Hilfsbefehl für den Unterricht: beliebiges SQL ausführen und Ergebnis zeigen.</summary>
        public static void RunSql(string sql)
        {
            using (SQLiteConnection con = Db.Open())
            using (SQLiteCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = sql;

                using (SQLiteDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.FieldCount == 0)
                    {
                        Console.WriteLine($"{reader.RecordsAffected} Zeile(n) betroffen");
                    }
                    else
                    {
                        Db.Print(reader);
                    }
                }
            }
        }
    }
}
