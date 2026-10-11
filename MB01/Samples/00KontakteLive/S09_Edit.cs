namespace KontakteLive
{
    using System;
    using System.Data;
    using System.Data.SQLite;

    // Folien 67–75: DataAdapter.Update, CommandBuilder, Konflikte, Events
    //
    // Konflikt-Demo mit ZWEI Terminals (in bin\Debug\net9.0):
    //   Terminal A:  KontakteLive edit 1 071 111 11 11    (lädt, wartet auf Enter)
    //   Terminal B:  KontakteLive edit 1 079 999 99 99    (sofort Enter -> gespeichert)
    //   Terminal A:  Enter                               -> DBConcurrencyException
    // Danach dasselbe mit edit-lastwins: A überschreibt B still ("last one wins").
    internal static class S09_Edit
    {
        public static void Run(string args, bool lastWins)
        {
            string[] a = args.Split(' ', 2, StringSplitOptions.RemoveEmptyEntries);
            if (a.Length == 0)
            {
                Console.WriteLine("usage: edit <contactId> <neue Telefonnummer>");
                return;
            }
            long contactId = long.Parse(a[0]);
            string newPhone = a.Length > 1 ? a[1] : "000";

            using (SQLiteConnection con = new SQLiteConnection(Db.ConnectionString))
            using (SQLiteDataAdapter adapter = new SQLiteDataAdapter(
                       "SELECT ID, FirstName, Name, NickName, EMail, Phone, PersonID FROM Contact", con))
            using (SQLiteCommandBuilder builder = new SQLiteCommandBuilder(adapter))
            {
                adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;

                // CommandBuilder erzeugt Insert-/Update-/DeleteCommand aus dem SelectCommand
                builder.ConflictOption = lastWins ? ConflictOption.OverwriteChanges : ConflictOption.CompareAllSearchableValues;

                DataTable table = new DataTable("Contact");
                adapter.Fill(table);

                Console.WriteLine("Vom CommandBuilder generiert:\n" + builder.GetUpdateCommand().CommandText + "\n");

                DataRow? row = table.Rows.Find(contactId);
                if (row == null)
                {
                    Console.WriteLine($"Kontakt {contactId} nicht gefunden");
                    return;
                }

                Console.WriteLine($"Geladen: {row["FirstName"]} {row["Name"]}, Tel. {row["Phone"]}");
                Console.Write($"Neue Nummer '{newPhone}' setzen – Enter = speichern ... ");
                Console.ReadLine();

                row["Phone"] = newPhone;

                adapter.RowUpdating += (s, e) => Console.WriteLine($"  RowUpdating: {e.StatementType} ID={e.Row["ID"]}");
                adapter.RowUpdated += (s, e) => Console.WriteLine($"  RowUpdated:  {e.RecordsAffected} Zeile(n) betroffen");

                try
                {
                    int n = adapter.Update(table);       // schickt nur die geänderten Zeilen (RowState != Unchanged)
                    Console.WriteLine($"{n} Änderung(en) gespeichert.");
                }
                catch (DBConcurrencyException ex)
                {
                    Console.WriteLine($"KONFLIKT: {ex.Message}");
                    Console.WriteLine("Jemand hat den Datensatz zwischen Fill und Update geändert (WHERE fand 0 Zeilen).");
                    Console.WriteLine("Optionen: neu laden und Benutzer entscheiden lassen / last one wins / mergen.");
                }
            }
        }
    }
}
