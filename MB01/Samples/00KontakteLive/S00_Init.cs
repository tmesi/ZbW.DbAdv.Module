namespace KontakteLive
{
    using System;
    using System.Data.SQLite;
    using System.IO;

    // Folien: Einführung / Provider / ConnectionString
    // Botschaft: Eine SQLite-Datenbank ist EINE Datei. Kein Server, kein Treiber, kein Office.
    internal static class S00_Init
    {
        public static void Run()
        {
            string script = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "Contacts.sql"));

            // Hier bewusst OHNE FailIfMissing: die Datei soll entstehen
            SQLiteConnectionStringBuilder csb = new SQLiteConnectionStringBuilder();
            csb.DataSource = Db.FileName;

            using (SQLiteConnection con = new SQLiteConnection(csb.ConnectionString))
            {
                con.Open();

                using (SQLiteCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = script;     // SQLite-Provider: mehrere Anweisungen in einem Command möglich
                    cmd.ExecuteNonQuery();
                }

                Console.WriteLine($"Datenbank neu erstellt: {Path.GetFullPath(Db.FileName)}");
                Console.WriteLine($"SQLite-Version: {con.ServerVersion}");
            }
        }
    }
}
