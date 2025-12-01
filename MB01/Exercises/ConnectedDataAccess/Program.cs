// See https://aka.ms/new-console-template for more information
using System.Data;
using System.Data.OleDb;

public class SqlBatch
{
    public static int Main(string[] args)
    {
        //--- open the input and output stream
        if (args.Length != 2)
        {
            Console.WriteLine("usage: SqlBatch inputFile outputFile");
            return 1;
        }
        StreamReader input = new StreamReader(new FileStream(args[0], FileMode.Open));
        StreamWriter output = new StreamWriter(new FileStream(args[1], FileMode.Create));

        //--- open the database connection
        String connection = input.ReadLine();
        OleDbConnection con = new OleDbConnection(connection);
        con.Open();
        //--- create a command object and begin a transaction
        IDbTransaction trans = con.BeginTransaction(IsolationLevel.ReadCommitted);
        IDbCommand cmd = con.CreateCommand();
        cmd.Transaction = trans;
        //--- read the SQL commands and execute them
        try
        {
            string sql = input.ReadLine();
            while (sql != null)
            {
                cmd.CommandText = sql;
                Execute(cmd, output);
                sql = input.ReadLine();
            }
            trans.Commit();
        }
        catch (Exception e)
        {
            output.WriteLine(e.Message);
            trans.Rollback();
        }
        //--- close everything
        input.Close();
        output.Close();
        con.Close();
        return 0;
    }

    public static void Execute(IDbCommand cmd, StreamWriter output)
    {
        output.WriteLine(cmd.CommandText);
        IDataReader r = cmd.ExecuteReader();
        //--- if the command returns a set of rows print them in tabular form
        object[] row = new object[r.FieldCount];
        while (r.Read())
        {
            int cols = r.GetValues(row);
            for (int i = 0; i < cols; i++)
            {
                output.Write(row[i] + "\t");
            }
            output.WriteLine();
        }
        output.WriteLine();
        r.Close();
    }
}
