namespace KontakteLive
{
    using System;
    using System.Data;
    using System.IO;
    using System.Linq;

    // Folien 80–81: DataSet und XML
    internal static class S11_Xml
    {
        static readonly string XmlFile = Path.Combine(AppContext.BaseDirectory, "contacts.xml");

        public static void Export()
        {
            DataSet ds = S08_DataSet.Load();
            ds.WriteXml(XmlFile, XmlWriteMode.WriteSchema);
            Console.WriteLine($"Geschrieben: {XmlFile}  (im Editor/VS öffnen: xs:schema, xs:keyref, Daten)");
        }

        public static void Import()
        {
            DataSet ds = new DataSet();
            ds.ReadXml(XmlFile, XmlReadMode.ReadSchema);   // Schema + Daten zurück – OHNE Datenbank

            string tables = string.Join(", ", ds.Tables.Cast<DataTable>().Select(t => $"{t.TableName} ({t.Rows.Count})"));
            string relations = string.Join(", ", ds.Relations.Cast<DataRelation>().Select(r => r.RelationName));
            Console.WriteLine($"DataSet '{ds.DataSetName}' aus XML: {tables}, Relationen: {relations}");
        }

        public static void DiffGram()
        {
            DataSet ds = S08_DataSet.Load();
            ds.Tables["Person"]!.Rows.Find(1L)!["Name"] = "Bier";
            ds.Tables["Person"]!.Rows.Find(2L)!.Delete();

            string file = Path.Combine(AppContext.BaseDirectory, "diffgram.xml");
            ds.WriteXml(file, XmlWriteMode.DiffGram);
            Console.WriteLine($"Geschrieben: {file}");
            Console.WriteLine("Darin: aktuelle Werte + <diffgr:before> mit den Original-Werten -> RowVersions als XML.");
        }
    }
}
