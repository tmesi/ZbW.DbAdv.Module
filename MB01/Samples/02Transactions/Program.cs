namespace Transactions
{
  using Microsoft.Data.SqlClient;
  using System.Data;

  internal class Program
  {
    static void Main(string[] args)
    {
      // Installation Northwind-Datenbank: https://northwinddatabase.codeplex.com/releases/view/71634

      // Connectionstring: https://www.connectionstrings.com/sqlconnection/
      string connStr = "Data Source=.\\DEV;Initial Catalog=Northwind;Integrated Security=True;Encrypt=False";

      IDbConnection con = new SqlConnection(connStr);   //Verbindung erzeugen
      IDbTransaction trans = null!;
      try
      {
        con.Open();
        trans = con.BeginTransaction(IsolationLevel.ReadCommitted);

        IDbCommand cmd1 = con.CreateCommand();
        cmd1.CommandText = "DELETE [Order Details] WHERE OrderId = 10258";
        cmd1.Transaction = trans;
        cmd1.ExecuteNonQuery();

        IDbCommand cmd2 = con.CreateCommand();
        cmd2.CommandText = "DELETE Orders WHERE OrderId = 10258";
        cmd2.Transaction = trans;
        cmd2.ExecuteNonQuery();

        trans.Commit();
      }
      catch
      {
        if (trans != null)
          trans.Rollback();
      }
      finally
      {
        con.Close();
      }

      Console.ReadLine();
    }
  }
}
