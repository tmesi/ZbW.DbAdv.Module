using System;
using System.Xml;
using System.Data;
using System.Data.OleDb;

public class ExportXML
{
    static void Main(string[] args)
    {
        if (args.Length != 2)
        {
            System.Console.Out.WriteLine("usage: ExportXML AccessDbName OutputFile");
            return;
        }
        Console.WriteLine("Loading data ...");
        string conStr = args[0];
        DataSet ds = LoadData(conStr);
        if (ds != null)
        {
            Console.WriteLine("Writing data ...");
            //write schema and data
            ds.WriteXml(args[1], XmlWriteMode.WriteSchema);
        }
        else
        {
            Console.WriteLine("Could not load data!");
        }
    }

    // Loads all the data using the given connection string
    public static DataSet LoadData(string connStr)
    {
        OleDbConnection conn = null;
        DataSet ds = null;
        try
        {
            conn = new OleDbConnection(connStr);
            OleDbDataAdapter adapter = new OleDbDataAdapter();
            adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
            conn.Open();

            if (conn.Database == null || conn.Database == "")
                ds = new DataSet();
            else
                ds = new DataSet(conn.Database);

            //load all user table names
            DataTable schemaTable = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables,
                    new object[] { null, null, null, "TABLE" });

            //create 'select *' statements (for every found table) and fill DS
            adapter.SelectCommand = conn.CreateCommand();
            for (int i = 0; i < schemaTable.Rows.Count; i++)
            {
                string tableName = schemaTable.Rows[i]["TABLE_NAME"].ToString();
                adapter.SelectCommand.CommandText =
                                       String.Format("SELECT * FROM {0};", tableName);
                adapter.Fill(ds, tableName);
            }
        }
        catch (Exception e)
        {
            HandleError(e);
        }
        finally
        {
            if (conn != null)
                conn.Close();
        }
        return ds;
    }

    // displays an error message on the console
    static void HandleError(Exception e)
    {
        System.Console.Out.WriteLine(e);
    }
}

