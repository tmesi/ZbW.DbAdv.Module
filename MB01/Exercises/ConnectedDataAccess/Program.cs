// Aufgabe 6: SqlBatch (Musterlösung, SQLite-Variante)
//
// Aufruf:  SqlBatch sqlcmd.txt result.txt
//   Zeile 1 der Eingabedatei: ConnectionString
//   danach: SQL-Anweisungen, jeweils mit ';' abgeschlossen (dürfen über mehrere Zeilen gehen)
//
// Alle Anweisungen laufen in EINER Transaktion. Schlägt eine fehl -> Rollback.
namespace SqlBatch
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SQLite;
    using System.IO;
    using System.Linq;
    using System.Text;

    internal class Program
    {
        static int Main(string[] args)
        {
            if (args.Length != 2)
            {
                Console.WriteLine("usage: SqlBatch inputFile outputFile");
                return 1;
            }

            string[] lines = File.ReadAllLines(args[0]);
            if (lines.Length == 0)
            {
                Console.WriteLine("Eingabedatei ist leer.");
                return 1;
            }

            string connectionString = lines[0];
            List<string> statements = SplitStatements(lines.Skip(1));

            using (StreamWriter output = new StreamWriter(args[1], false, Encoding.UTF8))
            using (SQLiteConnection con = new SQLiteConnection(connectionString))
            {
                con.Open();

                using (IDbTransaction trans = con.BeginTransaction())
                {
                    try
                    {
                        foreach (string sql in statements)
                        {
                            using (IDbCommand cmd = con.CreateCommand())
                            {
                                cmd.Transaction = trans;      // jedes Command muss der Transaktion zugeordnet sein
                                cmd.CommandText = sql;
                                Execute(cmd, output);
                            }
                        }
                        trans.Commit();
                        output.WriteLine("==> COMMIT");
                    }
                    catch (Exception e)
                    {
                        trans.Rollback();
                        output.WriteLine($"FEHLER: {e.Message}");
                        output.WriteLine("==> ROLLBACK – alle Änderungen dieses Batches wurden zurückgenommen.");
                    }
                }
            }

            Console.WriteLine($"{statements.Count} Anweisungen verarbeitet, Ergebnis in {args[1]}");
            return 0;
        }

        /// <summary>Zeilen zu Anweisungen zusammenfassen; ';' am Zeilenende beendet eine Anweisung.</summary>
        static List<string> SplitStatements(IEnumerable<string> lines)
        {
            List<string> result = new List<string>();
            StringBuilder current = new StringBuilder();

            foreach (string line in lines)
            {
                if (string.IsNullOrWhiteSpace(line))
                {
                    continue;
                }

                // Zeilenumbruch behalten, sonst "verschluckt" ein -- Kommentar den Rest der Anweisung
                current.AppendLine(line);

                if (line.TrimEnd().EndsWith(';'))
                {
                    result.Add(current.ToString().Trim());
                    current.Clear();
                }
            }

            if (current.ToString().Trim().Length > 0)
            {
                result.Add(current.ToString().Trim());
            }
            return result;
        }

        static void Execute(IDbCommand cmd, StreamWriter output)
        {
            output.WriteLine(cmd.CommandText);
            output.WriteLine();

            using (IDataReader reader = cmd.ExecuteReader())
            {
                if (reader.FieldCount == 0)
                {
                    // INSERT / UPDATE / DELETE: keine Spalten, aber RecordsAffected
                    output.WriteLine($"{reader.RecordsAffected} Datensätze betroffen");
                    output.WriteLine();
                    return;
                }

                // Kopfzeile + alle Zeilen puffern, damit die Spaltenbreite bekannt ist.
                // Hinweis: In SQLite ist VARCHAR(50) nur ein Hinweis (dynamische Typisierung).
                // ColumnSize aus GetSchemaTable() ist deshalb nicht verlässlich -> Breite aus den Daten.
                string[] header = new string[reader.FieldCount];
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    header[i] = reader.GetName(i);
                }

                List<string[]> rows = new List<string[]>();
                object[] values = new object[reader.FieldCount];
                while (reader.Read())
                {
                    reader.GetValues(values);
                    string[] row = new string[values.Length];
                    for (int i = 0; i < values.Length; i++)
                    {
                        row[i] = values[i] == DBNull.Value ? "NULL" : values[i].ToString() ?? "";
                    }
                    rows.Add(row);
                }

                int[] width = new int[header.Length];
                for (int i = 0; i < header.Length; i++)
                {
                    width[i] = header[i].Length;
                    foreach (string[] row in rows)
                    {
                        width[i] = Math.Max(width[i], row[i].Length);
                    }
                }

                output.WriteLine(FormatRow(header, width));
                output.WriteLine(string.Join("-+-", width.Select(w => new string('-', w))));
                foreach (string[] row in rows)
                {
                    output.WriteLine(FormatRow(row, width));
                }
                output.WriteLine($"({rows.Count} Zeilen)");
                output.WriteLine();
            }
        }

        static string FormatRow(string[] cells, int[] width)
        {
            string[] padded = new string[cells.Length];
            for (int i = 0; i < cells.Length; i++)
            {
                padded[i] = cells[i].PadRight(width[i]);
            }
            return string.Join(" | ", padded);
        }
    }
}
