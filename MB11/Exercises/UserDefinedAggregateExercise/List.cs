namespace UserDefinedAggregateExercise
{
  using System;
  using System.Data.SqlTypes;
  using Microsoft.SqlServer.Server;
  using System.Text;


  /*
   * 
   *    EXEC sp_configure 'clr enabled',1;
   *    RECONFIGURE;
   *    GO
   *    
   *    --Add DLL to SQL 
   *    CREATE ASSEMBLY UserDefinedAggregateExercise 
   *    FROM '<Pfad: ..\UserDefinedAggregateExercise\bin\Debug\UserDefinedAggregateExercise.dll>'
   *    WITH PERMISSION_SET = SAFE; 
   *    GO

   *    --Create the UDF
   *    CREATE Aggregate Median (@value INT) RETURNS INT
   *    EXTERNAL NAME UserDefinedAggregateExercise.[UserDefinedAggregateExercise.Median];
   *    
   *    CREATE Aggregate List (@value nvarchar(max), @delimiter nvarchar(max)) RETURNS nvarchar(max)
   *    EXTERNAL NAME UserDefinedAggregateExercise.[UserDefinedAggregateExercise.List];
   *    GO
   *    
   *    SELECT dbo.List(SalesOrderNumber,'/') FROM [AdventureWorks2016].[Sales].[SalesOrderHeader]
   *    where SalesOrderID BETWEEN 43660 AND 43665
  */

  [Serializable]
  [SqlUserDefinedAggregate(
      Format.UserDefined,
      IsInvariantToDuplicates = false,
      IsInvariantToNulls = false,
      IsInvariantToOrder = false,
      MaxByteSize = 8000
  )]
  public struct List : IBinarySerialize
  {
    private StringBuilder accumulator;
    private string _delimiter;

    public void Init()
    {
      // your solution
    }

    public void Accumulate(SqlString value, SqlString delimiter)
    {
      // your solution
    }

    public void Merge(List other)
    {
      // your solution
    }

    public SqlString Terminate()
    {
      var output = string.Empty;

      // your solution
      return new SqlString(output);
    }

    public void Read(System.IO.BinaryReader r)
    {
      // your solution
    }

    public void Write(System.IO.BinaryWriter w)
    {
      // your solution
    }
  }
}