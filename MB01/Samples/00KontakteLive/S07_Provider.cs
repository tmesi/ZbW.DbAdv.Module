namespace KontakteLive
{
    using System;
    using System.Data.Common;
    using System.Data.SQLite;
    using Microsoft.Data.SqlClient;

    // Folien 5–6, 13, 21–22: Provider-Modell, DbProviderFactory
    // Derselbe Code läuft gegen SQLite und gegen SQL Server – nur Provider-Name + ConnectionString ändern.
    // SQL Server: Datenbank "Playground" aus Samples/05ContactDataSetDataAdapter/DBDefinitions.sql
    internal static class S07_Provider
    {
        // ggf. an die lokale Instanz anpassen (z.B. ".\\SQLEXPRESS" oder ".\\DEV")
        const string SqlServer = "Server=.;Database=Playground;Trusted_Connection=True;TrustServerCertificate=True";

        public static void Run(string which)
        {
            DbProviderFactories.RegisterFactory("System.Data.SQLite", SQLiteFactory.Instance);
            DbProviderFactories.RegisterFactory("Microsoft.Data.SqlClient", SqlClientFactory.Instance);

            string invariantName;
            string connectionString;
            if (which == "sqlserver")
            {
                invariantName = "Microsoft.Data.SqlClient";
                connectionString = SqlServer;
            }
            else
            {
                invariantName = "System.Data.SQLite";
                connectionString = Db.ConnectionString;
            }

            // ---- ab hier kein provider-spezifischer Typ mehr ----
            DbProviderFactory factory = DbProviderFactories.GetFactory(invariantName);

            using (DbConnection con = factory.CreateConnection()!)
            {
                con.ConnectionString = connectionString;
                con.Open();

                using (DbCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = "SELECT COUNT(*) FROM Contact WHERE Name LIKE @p";

                    DbParameter p = cmd.CreateParameter();
                    p.ParameterName = "@p";
                    p.Value = "%";
                    cmd.Parameters.Add(p);

                    Console.WriteLine($"Provider:   {factory.GetType().FullName}");
                    Console.WriteLine($"Connection: {con.GetType().Name}, Server {con.ServerVersion}");
                    Console.WriteLine($"Kontakte:   {Convert.ToInt64(cmd.ExecuteScalar())}");
                    // Diskussion: Wo hört die Unabhängigkeit auf? -> SQL-Dialekt (LIMIT/TOP, RETURNING/OUTPUT, ...)
                }
            }
        }
    }
}
