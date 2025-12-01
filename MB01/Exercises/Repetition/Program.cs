using System;
using System.Data.SqlClient;

namespace AdoNetRep {
    class Program {
        static void Main(string[] args) {
            Console.Write("Enter Filter-Criteria: ");
            var filter = Console.ReadLine();
            try {
                // using C#8: https://docs.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-8#using-declarations
                using var conn = new SqlConnection("Server=.;Database=Northwind;Trusted_Connection=True;");
                conn.Open();
                using var cmd = conn.CreateCommand();


                cmd.CommandText = @"
                    select a.CompanyName, a.ContactName, 
                           IsNull((select sum(CONVERT(money,UnitPrice*Quantity*(1-Discount)/100)) from [dbo].[Order Details] x inner join [dbo].[Orders] y on x.OrderID = y.OrderID where y.CustomerID = a.CustomerID),0) as Sales 
                       from [dbo].[Customers] a
                       where CompanyName like @filter or ContactName like @filter";
                
                
                
                cmd.Parameters.AddWithValue("@filter", $"%{filter}%");
                using var reader = cmd.ExecuteReader();
                while (reader.Read()) {
                    Console.WriteLine($"{reader.GetString(0).PadRight(20).Substring(0, 20)} | {reader.GetString(1).PadRight(20).Substring(0, 20)} | {reader.GetDecimal(2):N2}");
                }
                reader.Close();
                conn.Close();
            } catch (Exception ex) {
                Console.WriteLine(ex.Message);
            }

            Console.ReadLine();
        }
    }
}
