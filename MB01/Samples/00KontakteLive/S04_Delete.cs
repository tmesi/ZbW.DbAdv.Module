namespace KontakteLive
{
    using System;
    using System.Data.SQLite;

    // Folien 37–41: Lokale Transaktionen
    // Ablauf im Unterricht:
    //   delete-notx 3 crash   -> Kontakte weg, Person noch da  => inkonsistent!
    //   init
    //   delete 3 crash        -> ROLLBACK, alles noch da
    //   delete 3              -> COMMIT
    internal static class S04_Delete
    {
        public static void Run(string args, bool useTransaction)
        {
            string[] a = args.Split(' ', StringSplitOptions.RemoveEmptyEntries);
            if (a.Length == 0)
            {
                Console.WriteLine("usage: delete <personId> [crash]");
                return;
            }
            long personId = long.Parse(a[0]);
            bool crash = a.Length > 1 && a[1] == "crash";

            using (SQLiteConnection con = Db.Open())
            {
                SQLiteTransaction? tx = null;
                if (useTransaction)
                {
                    tx = con.BeginTransaction();
                }

                try
                {
                    using (SQLiteCommand cmd1 = con.CreateCommand())
                    {
                        cmd1.Transaction = tx;                 // Command der Transaktion zuordnen
                        cmd1.CommandText = "DELETE FROM Contact WHERE PersonID = @id";
                        cmd1.Parameters.AddWithValue("@id", personId);
                        Console.WriteLine($"{cmd1.ExecuteNonQuery()} Kontakt(e) gelöscht");
                    }

                    if (crash)
                    {
                        throw new InvalidOperationException("Simulierter Absturz zwischen den beiden DELETEs!");
                    }

                    using (SQLiteCommand cmd2 = con.CreateCommand())
                    {
                        cmd2.Transaction = tx;
                        cmd2.CommandText = "DELETE FROM Person WHERE ID = @id";
                        cmd2.Parameters.AddWithValue("@id", personId);
                        Console.WriteLine($"{cmd2.ExecuteNonQuery()} Person gelöscht");
                    }

                    if (tx != null)
                    {
                        tx.Commit();
                        Console.WriteLine("COMMIT");
                    }
                    else
                    {
                        Console.WriteLine("(ohne Transaktion: jede Anweisung sofort dauerhaft)");
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"FEHLER: {ex.Message}");
                    if (tx != null)
                    {
                        tx.Rollback();
                        Console.WriteLine("ROLLBACK – Datenbank unverändert.");
                    }
                    else
                    {
                        Console.WriteLine("Keine Transaktion – die Kontakte sind trotzdem weg. Prüfen mit: list");
                    }
                }
                finally
                {
                    if (tx != null)
                    {
                        tx.Dispose();
                    }
                }
            }
        }
    }
}
