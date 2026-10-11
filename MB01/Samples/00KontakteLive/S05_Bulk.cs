namespace KontakteLive
{
    using System;
    using System.Data;
    using System.Data.SQLite;
    using System.Diagnostics;

    // Transaktionen haben auch eine Performance-Seite:
    // Ohne explizite Transaktion ist JEDES INSERT eine eigene Transaktion (Autocommit)
    // -> SQLite schreibt jedes Mal sicher auf die Platte (fsync). Das ist der Aha-Moment.
    internal static class S05_Bulk
    {
        const string Insert = "INSERT INTO Contact (Name, PersonID) VALUES (@name, 1)";

        public static void Run(int n)
        {
            using (SQLiteConnection con = Db.Open())
            {
                Measure(con, n, false, false);
                Measure(con, n, true, false);
                Measure(con, n, true, true);

                using (SQLiteCommand cleanup = new SQLiteCommand("DELETE FROM Contact WHERE Name LIKE 'Bulk%'", con))
                {
                    Console.WriteLine($"Aufgeräumt: {cleanup.ExecuteNonQuery()} Testzeilen gelöscht");
                }
            }
        }

        static void Measure(SQLiteConnection con, int n, bool useTransaction, bool reuseCommand)
        {
            Stopwatch sw = Stopwatch.StartNew();

            SQLiteTransaction? tx = null;
            if (useTransaction)
            {
                tx = con.BeginTransaction();
            }

            if (reuseCommand)
            {
                // EIN Command, SQL einmal übersetzen, n-mal ausführen
                using (SQLiteCommand prepared = new SQLiteCommand(Insert, con, tx))
                {
                    prepared.Parameters.Add("@name", DbType.String);
                    prepared.Prepare();

                    for (int i = 0; i < n; i++)
                    {
                        prepared.Parameters["@name"].Value = $"Bulk{i}";
                        prepared.ExecuteNonQuery();
                    }
                }
            }
            else
            {
                // für jede Zeile ein neues Command
                for (int i = 0; i < n; i++)
                {
                    using (SQLiteCommand cmd = new SQLiteCommand(Insert, con, tx))
                    {
                        cmd.Parameters.AddWithValue("@name", $"Bulk{i}");
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            if (tx != null)
            {
                tx.Commit();
                tx.Dispose();
            }
            sw.Stop();

            string label = (useTransaction ? "mit Transaktion" : "OHNE Transaktion") + (reuseCommand ? " + prepared" : "");
            Console.WriteLine($"{n,6} Inserts {label,-30} {sw.ElapsedMilliseconds,7} ms");
        }
    }
}
