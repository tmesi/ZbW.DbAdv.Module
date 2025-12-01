using System.Data;
using System.Data.OleDb;

public class DumpDB
{

    public static void Main(string[] args)
    {
        if (args.Length == 0)
        {
            Console.WriteLine("usage: DumpDB DBname {TableName}");
            return;
        }
        //--- create a DataSet
        DataSet ds = new DataSet();

        //--- open the database and fill the tables
        OleDbConnection con = new OleDbConnection("provider=Microsoft.ACE.OLEDB.16.0;Data Source = " + args[0]);
    
        OleDbDataAdapter adapter = new();
        for (int i = 1; i < args.Length; i++)
        {
            string tableName = args[i];
      using var _ = adapter.SelectCommand = new OleDbCommand($"SELECT * FROM {tableName}", con);
            adapter.Fill(ds, tableName);
        }
        con.Close();

        //--- display the tables on the Console
        foreach (DataTable table in ds.Tables)
        {
            Console.WriteLine(table.TableName);
            foreach (DataColumn col in table.Columns)
            {
                Console.Write(col.ColumnName + "\t");
            }
            Console.WriteLine();
            foreach (DataRow row in table.Rows)
            {
                foreach (object obj in row.ItemArray) Console.Write(obj + "\t");
                Console.WriteLine();
            }
            Console.WriteLine();
        }
    }
}
