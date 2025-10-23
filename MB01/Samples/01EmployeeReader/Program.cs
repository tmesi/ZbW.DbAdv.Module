﻿namespace EmployeeReader
{
  using Microsoft.Data.SqlClient;
  using System.Data;

  internal class Program
  {
    static void Main(string[] args)
    {
      // Northwind-Datenbank: https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/northwind-pubs

      // Connectionstring: https://www.connectionstrings.com/sqlconnection/
      string connStr = @"Data Source=.\DEV;Initial Catalog=Northwind;Integrated Security=True;Encrypt=False";

      //string connStr = "provider=SQLOLEDB; data source=(local)\\NetSDK; " +
      //	"initial catalog=Northwind; user id=sa; password=; ";
      IDbConnection con = null!;       // Verbindung deklarieren
      try
      {
        con = new SqlConnection(connStr);   //Verbindung erzeugen
        con.Open();
        //----- SQL-Kommando aufbauen
        IDbCommand cmd = con.CreateCommand();
        cmd.CommandText = "SELECT EmployeeID, LastName, FirstName FROM Employees";
        //----- SQL-Kommando ausführen; liefert einen OleDbDataReader
        IDataReader reader = cmd.ExecuteReader();


        object[] dataRow = new object[reader.FieldCount];
        //----- Daten zeilenweise lesen und verarbeiten
        while (reader.Read())
        { // solange noch Daten vorhanden sind
          int cols = reader.GetValues(dataRow); // tatsächliches Lesen 
          var val = reader["LastName"];
          for (int i = 0; i < cols; i++)
          {
            Console.Write("| {0} ", dataRow[i]);
          }
          Console.WriteLine();
        }
        //----- Reader schließen
        reader.Close();
      }
      catch (Exception e)
      {
        Console.WriteLine(e.Message);
      }
      finally
      {
        try
        {
          if (con != null)
            // Verbindung schließen
            con.Close();
        }
        catch (Exception ex) { Console.WriteLine(ex.Message); }
      }
      Console.ReadLine();
    }
  }
}
