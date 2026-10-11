namespace KontakteLive
{
    using System;
    using System.Data.SQLite;

    // Folien 26–27: ExecuteNonQuery / ExecuteScalar
    internal static class S03_Add
    {
        public static void Count()
        {
            using (SQLiteConnection con = Db.Open())
            using (SQLiteCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "SELECT COUNT(*) FROM Contact";

                object result = cmd.ExecuteScalar()!;
                Console.WriteLine($"{result} Kontakte  (Typ: {result.GetType().Name})");

                // Folie 27 macht "(int) cmd.ExecuteScalar()". Bei SQLite ist das Ergebnis Int64 ->
                // InvalidCastException. Live zeigen, dann: Convert.ToInt32(...)
                // int count = (int)cmd.ExecuteScalar()!;
            }
        }

        public static void Add()
        {
            Console.Write("Vorname: ");
            string first = Console.ReadLine() ?? "";
            Console.Write("Name: ");
            string name = Console.ReadLine() ?? "";
            Console.Write("Telefon (leer=NULL): ");
            string phone = Console.ReadLine() ?? "";
            Console.Write("Adressbuch von PersonID: ");
            long personId = long.Parse(Console.ReadLine() ?? "1");

            using (SQLiteConnection con = Db.Open())
            using (SQLiteCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = """
                    INSERT INTO Contact (FirstName, Name, Phone, PersonID)
                    VALUES (@first, @name, @phone, @person)
                    RETURNING ID
                    """;
                cmd.Parameters.AddWithValue("@first", first);
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@phone", string.IsNullOrWhiteSpace(phone) ? DBNull.Value : (object)phone);
                cmd.Parameters.AddWithValue("@person", personId);

                // INSERT + generierten Schlüssel in EINEM Roundtrip (SQL Server: OUTPUT INSERTED.ID)
                long newId = (long)cmd.ExecuteScalar()!;
                Console.WriteLine($"Neuer Kontakt mit ID {newId}");
                // Probieren: PersonID 999 -> FOREIGN KEY constraint failed (nur weil ForeignKeys=true!)
            }
        }
    }
}
