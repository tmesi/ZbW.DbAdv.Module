namespace KontakteLive
{
    using System;
    using System.Data;
    using System.Data.SQLite;

    // Folie 42: Isolationsstufen – und was die konkrete Datenbank daraus macht.
    //
    // Demo mit ZWEI Terminals (in bin\Debug\net9.0):
    //   Terminal A:  KontakteLive lock          -> ändert Person 1, hält die Transaktion offen
    //   Terminal B:  KontakteLive list          -> sieht noch den ALTEN Namen (kein Dirty Read)
    //   Terminal B:  KontakteLive add  ...      -> wartet 3 s, dann "database is locked"
    //   Terminal A:  Enter                      -> COMMIT
    //   Terminal B:  KontakteLive list          -> neuer Name sichtbar
    // Erkenntnis: SQLite erlaubt viele Leser, aber nur EINEN Schreiber gleichzeitig.
    internal static class S06_Locking
    {
        public static void HoldLock()
        {
            using (SQLiteConnection con = Db.Open())
            using (SQLiteTransaction tx = con.BeginTransaction())
            {
                using (SQLiteCommand cmd = con.CreateCommand())
                {
                    cmd.Transaction = tx;
                    cmd.CommandText = "UPDATE Person SET Name = Name || ' (gesperrt)' WHERE ID = 1";
                    cmd.ExecuteNonQuery();              // ab hier hält diese Verbindung die Schreibsperre
                }

                Console.WriteLine("Person 1 geändert, Transaktion OFFEN. Jetzt im zweiten Terminal lesen/schreiben.");
                Console.Write("Enter = COMMIT ... ");
                Console.ReadLine();

                tx.Commit();
                Console.WriteLine("COMMIT. ('init' stellt den Ursprungszustand wieder her)");
            }
        }

        public static void IsolationLevels()
        {
            using (SQLiteConnection con = Db.Open())
            {
                foreach (IsolationLevel level in Enum.GetValues<IsolationLevel>())
                {
                    try
                    {
                        using (SQLiteTransaction tx = con.BeginTransaction(level))
                        {
                            Console.WriteLine($"{level,-16} akzeptiert");
                            tx.Rollback();
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"{level,-16} -> {ex.GetType().Name}: {ex.Message}");
                    }
                }
                Console.WriteLine("\nDas Enum gehört zu ADO.NET – was davon unterstützt wird, entscheidet der Provider/die DB.");
            }
        }
    }
}
