namespace KontakteLive
{
    using System;
    using System.Data.SQLite;

    // Folien 30–31: Parameter
    // Live ausprobieren mit search-unsafe:
    //   Mül
    //   ' OR 1=1 --
    //   ' UNION SELECT 0, type, name, sql FROM sqlite_master --
    // und danach dieselben Eingaben mit search (parametrisiert).
    internal static class S02_Search
    {
        public static void Unsafe(string text)
        {
            using (SQLiteConnection con = Db.Open())
            using (SQLiteCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "SELECT ID, FirstName, Name, EMail FROM Contact WHERE Name LIKE '%" + text + "%'";
                Console.WriteLine($"SQL: {cmd.CommandText}\n");

                using (SQLiteDataReader reader = cmd.ExecuteReader())
                {
                    Db.Print(reader);
                }
            }
        }

        public static void Safe(string text)
        {
            using (SQLiteConnection con = Db.Open())
            using (SQLiteCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "SELECT ID, FirstName, Name, EMail FROM Contact WHERE Name LIKE @pattern";
                cmd.Parameters.AddWithValue("@pattern", $"%{text}%");   // Wert wird NIE Teil des SQL-Texts
                Console.WriteLine($"SQL: {cmd.CommandText}   @pattern = '%{text}%'\n");

                using (SQLiteDataReader reader = cmd.ExecuteReader())
                {
                    Db.Print(reader);
                }
            }
        }
    }
}
