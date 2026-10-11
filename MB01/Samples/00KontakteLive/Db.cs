namespace KontakteLive
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SQLite;
    using System.IO;
    using System.Linq;

    /// <summary>Verbindungsaufbau an EINER Stelle – ConnectionStringBuilder statt Strings zusammenkleben.</summary>
    internal static class Db
    {
        // Neben der .exe ablegen – unabhängig davon, ob über Visual Studio oder "dotnet run" gestartet wird
        public static readonly string FileName = Path.Combine(AppContext.BaseDirectory, "Contacts.db");

        public static string ConnectionString
        {
            get
            {
                SQLiteConnectionStringBuilder builder = new SQLiteConnectionStringBuilder();
                builder.DataSource = FileName;
                builder.FailIfMissing = true;   // ohne: falscher Pfad => SQLite legt still eine LEERE DB an ("no such table")
                builder.ForeignKeys = true;     // ohne: SQLite ignoriert Fremdschlüssel!
                builder.DefaultTimeout = 3;     // Sekunden warten, wenn die DB von jemand anderem gesperrt ist
                return builder.ConnectionString;
            }
        }

        public static SQLiteConnection Open()
        {
            SQLiteConnection con = new SQLiteConnection(ConnectionString);
            con.Open();
            return con;
        }

        /// <summary>Beliebiges Ergebnis tabellarisch ausgeben (Spaltenbreite aus den Daten).</summary>
        public static void Print(IDataReader reader)
        {
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
                    row[i] = values[i] == DBNull.Value ? "NULL" : Flat(values[i].ToString());
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

            Console.WriteLine(FormatRow(header, width));
            Console.WriteLine(string.Join("-+-", width.Select(w => new string('-', w))));
            foreach (string[] row in rows)
            {
                Console.WriteLine(FormatRow(row, width));
            }
            Console.WriteLine($"({rows.Count} Zeilen)");
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

        /// <summary>Zeilenumbrüche und Mehrfach-Leerzeichen entfernen (z.B. für sql aus sqlite_master).</summary>
        static string Flat(string? s)
        {
            string[] words = (s ?? "").Split((char[]?)null, StringSplitOptions.RemoveEmptyEntries);
            return string.Join(' ', words);
        }
    }
}
