namespace KontakteLive
{
    using System;
    using System.Data.Common;
    using System.Data.SQLite;
    using System.Threading.Tasks;

    // Ersetzt Folien 28–29 (BeginExecuteReader/EndExecuteReader = altes APM-Muster).
    // Heute: async/await. Achtung: System.Data.SQLite implementiert die Async-Methoden nicht wirklich
    // asynchron (Basisklasse führt synchron aus). Bei Microsoft.Data.SqlClient sind sie echt asynchron.
    internal static class S12_Async
    {
        public static async Task RunAsync()
        {
            await using (SQLiteConnection con = new SQLiteConnection(Db.ConnectionString))
            {
                await con.OpenAsync();

                await using (SQLiteCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = "SELECT FirstName, Name FROM Person ORDER BY Name";

                    await using (DbDataReader reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            string first = await reader.IsDBNullAsync(0) ? "" : reader.GetString(0);
                            Console.WriteLine($"{reader.GetString(1)}, {first}");
                        }
                    }
                }
            }
        }
    }
}
