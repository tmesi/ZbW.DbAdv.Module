namespace KontakteLive
{
    using System;
    using System.Data;
    using System.Data.SQLite;
    using System.Linq;

    // Folien 44–61: DataSet, DataRelation, RowState, DataRowVersion
    internal static class S08_DataSet
    {
        /// <summary>Person + Contact in ein DataSet laden (Folie 71: ein SelectCommand, zwei Ergebnismengen).</summary>
        public static DataSet Load()
        {
            DataSet ds = new DataSet("PersonContacts");

            using (SQLiteConnection con = new SQLiteConnection(Db.ConnectionString))   // NICHT öffnen: Fill macht Open/Close selbst
            using (SQLiteDataAdapter adapter = new SQLiteDataAdapter("SELECT * FROM Person; SELECT * FROM Contact", con))
            {
                adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;  // Primärschlüssel + Constraints mitladen
                adapter.TableMappings.Add("Table", "Person");
                adapter.TableMappings.Add("Table1", "Contact");
                adapter.Fill(ds);
                Console.WriteLine($"[Fill fertig – Verbindung ist wieder {con.State}]");
            }

            ds.Relations.Add("PersonHasContacts",
                ds.Tables["Person"]!.Columns["ID"]!,
                ds.Tables["Contact"]!.Columns["PersonID"]!);

            // Neue Zeilen bekommen negative, "vorläufige" Schlüssel (Folie 53) – die echten vergibt die DB.
            foreach (DataTable t in ds.Tables)
            {
                DataColumn id = t.Columns["ID"]!;
                id.AutoIncrement = true;
                id.AutoIncrementStep = -1;   // Reihenfolge wichtig: zuerst Step, dann Seed
                id.AutoIncrementSeed = -1;
            }
            return ds;
        }

        public static void Run()
        {
            DataSet ds = Load();

            foreach (DataTable t in ds.Tables)
            {
                string columns = string.Join(", ", t.Columns.Cast<DataColumn>().Select(c => $"{c.ColumnName}:{c.DataType.Name}"));
                Console.WriteLine($"Tabelle {t.TableName}: {t.Rows.Count} Zeilen, PK {t.PrimaryKey[0].ColumnName}, Spalten {columns}");
            }
            Console.WriteLine();

            // Navigation über die Relation – ganz ohne JOIN und ohne Verbindung
            foreach (DataRow person in ds.Tables["Person"]!.Rows)
            {
                Console.WriteLine($"{person["FirstName"]} {person["Name"]}");
                foreach (DataRow c in person.GetChildRows("PersonHasContacts"))
                {
                    Console.WriteLine($"    - {c["FirstName"]} {c["Name"]}, {c["Phone"]}");
                }
            }
        }

        public static void RowStates()
        {
            DataSet ds = Load();
            DataTable persons = ds.Tables["Person"]!;

            DataRow beer = persons.Rows.Find(1L)!;
            Show(beer, "nach Fill");

            beer["Name"] = "Bier";
            Show(beer, "nach Änderung");
            Console.WriteLine($"    Original = {beer["Name", DataRowVersion.Original]}, Current = {beer["Name", DataRowVersion.Current]}");

            DataRow neu = persons.NewRow();
            Show(neu, "NewRow()");
            neu["FirstName"] = "Ada";
            neu["Name"] = "Lovelace";
            persons.Rows.Add(neu);
            Show(neu, $"Rows.Add() – vorläufige ID {neu["ID"]}");

            DataRow kehl = persons.Rows.Find(3L)!;
            kehl.Delete();
            Show(kehl, "Delete()");
            int deletedChildren = ds.Tables["Contact"]!.Select("PersonID = 3", "", DataViewRowState.Deleted).Length;
            Console.WriteLine($"    Kinder von Kehl: {deletedChildren} Kontakte ebenfalls Deleted (Cascade der DataRelation)");

            DataSet? changes = ds.GetChanges();
            int changedPersons = changes?.Tables["Person"]?.Rows.Count ?? 0;
            int changedContacts = changes?.Tables["Contact"]?.Rows.Count ?? 0;
            Console.WriteLine($"\nGetChanges(): {changedPersons} geänderte Personen, {changedContacts} geänderte Kontakte" +
                              "  -> genau das schickt Update() zur DB");

            ds.RejectChanges();
            Show(beer, "nach RejectChanges()");
            Console.WriteLine($"    Name wieder: {beer["Name"]}");
        }

        static void Show(DataRow row, string when)
        {
            Console.WriteLine($"{when,-40} RowState = {row.RowState}");
        }
    }
}
