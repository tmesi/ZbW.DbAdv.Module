namespace UserDefinedAggragate
{
  using System;
  using System.Data.SqlTypes;
  using Microsoft.SqlServer.Server;


  /*
  * CREATE ASSEMBLY UserDefinedAggragate
  * FROM '<Pfad: ..\UserDefinedAggragate\bin\Release\UserDefinedAggragate.dll>'
  * WITH PERMISSION_SET = SAFE
  *
  * -- DROP ASSEMBLY UserDefinedAggragate
  *
  * GO
  *
  * CREATE AGGREGATE Sum5(@value INT)
  * RETURNS INT
  * EXTERNAL NAME UserDefinedAggragate.[UserDefinedAggragate.Sum5];
  *
  * -- DROP AGGREGATE Sum5
  *
  * DROP TABLE IF EXISTS #Numbers
  *
  * CREATE TABLE #Numbers (val INT)
  *
  * INSERT INTO #Numbers VALUES (3), (7), (10), (5), (8), (2)
  *
  * SELECT dbo.Sum5(val) AS Sum5 FROM #Numbers
  */
  [Serializable]
  [SqlUserDefinedAggregate(
      Format.UserDefined,
      IsInvariantToNulls = true,
      IsInvariantToDuplicates = false,
      IsInvariantToOrder = true,
      MaxByteSize = 8000)]
  public struct Sum5 : IBinarySerialize
  {
    private int _sum;

    // Initialisierung
    public void Init()
    {
      _sum = 0;
    }

    // Hier kommt die Logik für jede neue Zeile
    public void Accumulate(SqlInt32 value)
    {
      if (!value.IsNull && value.Value > 5)
      {
        _sum += value.Value;
      }
    }

    // Merge zwei Aggregate (bei Parallelisierung etc.)
    public void Merge(Sum5 other)
    {
      _sum += other._sum;
    }

    // Das finale Ergebnis zurückgeben
    public SqlInt32 Terminate()
    {
      return new SqlInt32(_sum);
    }

    // Serialisierung (BinarySerialize)
    public void Read(System.IO.BinaryReader r)
    {
      _sum = r.ReadInt32();
    }

    public void Write(System.IO.BinaryWriter w)
    {
      w.Write(_sum);
    }
  }
}
