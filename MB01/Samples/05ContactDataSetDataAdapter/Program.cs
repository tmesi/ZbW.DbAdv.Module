namespace ContactDataSetDataAdapter
{
  using ContactDSDataAdapter;
  using System.Data;
  using System.Data.OleDb;

  internal class Program
  {

    static IDbCommand GetSelectAllCmd()
    {
      OleDbCommand cmd = new OleDbCommand();
      cmd.Connection = new OleDbConnection("Provider=SQLOLEDB;Data Source=(local);Integrated Security=SSPI;Initial Catalog=playground");
      cmd.CommandText = "SELECT * FROM Person; SELECT * FROM Contact";
      return cmd;
    }

    static DataSet LoadData()
    {
      DataSet ds = new DataSet("PersonContacts");
      IDbDataAdapter adapter = new OleDbDataAdapter();
      adapter.SelectCommand = GetSelectAllCmd();
      //----- the DataSet is empty => add tables in Fill operation!
      adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
      //----- rename automatically named tables
      adapter.TableMappings.Add("Table", "Person");
      adapter.TableMappings.Add("Table1", "Contact");
      //----- load data from the database

      adapter.Fill(ds);
      if (ds.HasErrors)
      {
        ds.RejectChanges();
      }
      else
      {
        ds.AcceptChanges();
      }
      if (adapter is IDisposable) ((IDisposable)adapter).Dispose();
      return ds;
    }

    public static void Main()
    {
      //----- load data and schema
      DataSet ds = LoadData();


      //----- print data
      Print(ds);

      //----- store data as an XML file
      //ds.WriteXml("data.xml", XmlWriteMode.WriteSchema);

      //----- Show Datatables with use of Views
      var f = new Playground(ds);
      f.ShowDialog();

      Console.ReadLine();
    }

    static void Print(DataSet ds)
    {
      Console.WriteLine("DataSet {0}:", ds.DataSetName);
      Console.WriteLine();
      foreach (DataTable t in ds.Tables)
      {
        Print(t);
        Console.WriteLine();
      }
    }

    static void Print(DataTable t)
    {
      //---- table header
      Console.WriteLine("Table {0}:", t.TableName);
      foreach (DataColumn col in t.Columns)
      {
        Console.Write(col.ColumnName + "|");
      }
      Console.WriteLine();
      for (int i = 0; i < 40; i++) { Console.Write("-"); }
      Console.WriteLine();

      //---- table data
      int nrOfCols = t.Columns.Count;
      foreach (DataRow row in t.Rows)
      {
        for (int i = 0; i < nrOfCols; i++)
        {
          Console.Write(row[i]); Console.Write("|");
        }
        Console.WriteLine();
      }
    }
  }
}
