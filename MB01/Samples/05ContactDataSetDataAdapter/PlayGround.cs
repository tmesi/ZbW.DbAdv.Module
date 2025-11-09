namespace ContactDSDataAdapter
{
  using System.Data;
  using System.Data.OleDb;

  public partial class Playground : Form
  {
    private readonly DataSet ds;


    public Playground(DataSet ds)
    {
      this.ds = ds;
      InitializeComponent();

      DataView view = new DataView(ds.Tables["Person"]);
      view.RowFilter = "FirstName like 'Thomas%'";
      view.RowStateFilter = DataViewRowState.Added |
                                DataViewRowState.ModifiedCurrent;
      view.Sort = "Name ASC"; // sort by Name in ascending order 

      this.dataGridView1.DataSource = view;

      DataView view2 = new DataView(ds.Tables["Person"]);
      //view.RowFilter = "FirstName = 'Thomas'";
      view.RowStateFilter = DataViewRowState.Added |
                                DataViewRowState.ModifiedCurrent;
      view2.Sort = "Name DESC"; // sort by Name in ascending order 
      this.dataGridView2.DataSource = view2;
    }

    private void button1_Click(object sender, EventArgs e)
    {
      var con = new OleDbConnection(
          "Provider=SQLOLEDB;Data Source=(local);Integrated Security=SSPI;Initial Catalog=playground");
      var adapter = new OleDbDataAdapter("SELECT * FROM Person", con);

      adapter.RowUpdated += new OleDbRowUpdatedEventHandler(this.onRowUpdated);



      // Im Constructor: DataAdapter = adapter;
      // Im Setter (Base-Klasse DbCommandBuilder): SetRowUpdatingHandler(value); 
      new OleDbCommandBuilder(adapter);
      adapter.Update(this.ds, "Person");
    }
    private void onRowUpdated(object sender, OleDbRowUpdatedEventArgs args)
    {
    }

  }
}
