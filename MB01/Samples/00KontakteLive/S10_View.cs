namespace KontakteLive
{
    using System;
    using System.Data;

    // Folien 63–64: DataView – Filtern, Sortieren, Suchen im Hauptspeicher
    internal static class S10_View
    {
        public static void Run(string prefix)
        {
            DataTable contacts = S08_DataSet.Load().Tables["Contact"]!;

            // Berechnete Spalte (DataColumn.Expression)
            contacts.Columns.Add("Anzeige", typeof(string), "Name + ', ' + ISNULL(FirstName, '?')");

            DataView view = new DataView(contacts);
            view.RowFilter = $"Name LIKE '{prefix.Replace("'", "''")}*'";   // Filterausdruck ist wieder ein String -> Hochkommas verdoppeln!
            view.Sort = "Name ASC, FirstName ASC";

            Console.WriteLine($"RowFilter: {view.RowFilter}   Sort: {view.Sort}");
            foreach (DataRowView r in view)
            {
                Console.WriteLine($"  {r["Anzeige"],-25} {r["Phone"]}");
            }

            // Schnelle Suche über die Sortierspalte(n)
            view.RowFilter = "";
            view.Sort = "Name";
            DataRowView[] hits = view.FindRows("Kehl");
            Console.WriteLine($"\nFindRows(\"Kehl\"): {hits.Length} Treffer");
            if (hits.Length == 0)
            {
                return;
            }

            // Sicht auf Änderungen: nur modifizierte Zeilen
            hits[0].Row["Phone"] = "neu!";            // über .Row: direkt ändern (DataRowView-Indexer würde BeginEdit/EndEdit brauchen)
            DataView changed = new DataView(contacts);
            changed.RowStateFilter = DataViewRowState.ModifiedCurrent;
            Console.WriteLine($"RowStateFilter=ModifiedCurrent: {changed.Count} Zeile(n) -> {changed[0]["Anzeige"]}");
        }
    }
}
