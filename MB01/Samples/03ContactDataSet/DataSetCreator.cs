namespace ContactDataSet
{
  using System.Data;

  public class DataSetCreator
  {
    public DataSet Create()
    {
      DataSet ds = new DataSet("PersonContacts");
      DataTable personTable = new DataTable("Person");

      DataColumn col = new DataColumn();
      col.DataType = typeof(long);
      col.ColumnName = "ID";
      col.ReadOnly = true;
      col.Unique = true;          // values must be unique 
      col.AutoIncrement = true;   // keys are assigned automatically 
      col.AutoIncrementSeed = 1; // first key starts with -1 
      col.AutoIncrementStep = 1; // next key = prev. key - 1

      personTable.Columns.Add(col);
      personTable.PrimaryKey = [col];

      col = new DataColumn();
      col.DataType = typeof(string);
      col.ColumnName = "FirstName";
      personTable.Columns.Add(col);

      col = new DataColumn();
      col.DataType = typeof(string);
      col.ColumnName = "Name";
      personTable.Columns.Add(col);

      ds.Tables.Add(personTable);


      DataTable contactTable = new DataTable("Contact");

      col = new DataColumn();
      col.DataType = typeof(long);
      col.ColumnName = "ID";
      col.ReadOnly = true;
      col.Unique = true;          // values must be unique 
      col.AutoIncrement = true;   // keys are assigned automatically 
      col.AutoIncrementSeed = 1;     // first key starts with -1 
      col.AutoIncrementStep = 1;     // next key = prev. key - 1
      contactTable.Columns.Add(col);
      contactTable.PrimaryKey = [col];

      col = new DataColumn();
      col.DataType = typeof(string);
      col.ColumnName = "FirstName";
      contactTable.Columns.Add(col);

      col = new DataColumn();
      col.DataType = typeof(string);
      col.ColumnName = "Name";
      contactTable.Columns.Add(col);

      col = new DataColumn();
      col.DataType = typeof(string);
      col.ColumnName = "NickName";
      contactTable.Columns.Add(col);

      col = new DataColumn();
      col.DataType = typeof(string);
      col.ColumnName = "email";
      contactTable.Columns.Add(col);

      col = new DataColumn();
      col.DataType = typeof(string);
      col.ColumnName = "Phone";
      contactTable.Columns.Add(col);

      col = new DataColumn();
      col.DataType = typeof(long);
      col.ColumnName = "PersonID";
      contactTable.Columns.Add(col);
      ds.Tables.Add(contactTable);

      DataColumn parentCol = ds.Tables["Person"]!.Columns["ID"]!;
      DataColumn childCol = ds.Tables["Contact"]!.Columns["PersonID"]!;

      DataRelation rel = new DataRelation("PersonHasContacts", parentCol, childCol);
      ds.Relations.Add(rel);
      return ds;

    }
  }
}
