namespace UserDefinedAggregateExercise
{
  using System;
  using System.Data.SqlTypes;
  using Microsoft.SqlServer.Server;
  using System.Collections.Generic;

  /*
   * IsInvariantToDuplicates:
   * Used by the query processor, this property is true if the aggregate is invariant to duplicates. 
   * That is, the aggregate of S, {X} is the same as aggregate of S when X is already in S. 
   * For example, aggregate functions such as MIN and MAX satisfy this property, while SUM does not.
   * 
   * analog für die weiteren IsInvariantTo...-Optionen
   */

  [Serializable]
  [SqlUserDefinedAggregate(
      Format.UserDefined,
      IsInvariantToDuplicates = false,
      IsInvariantToNulls = false,
      IsInvariantToOrder = false,
      MaxByteSize = 8000
  )]
  public struct Median : IBinarySerialize
  {
    // Damit das hier serialisiert werden kann, verwenden wir
    // Format.UserDefined und müssen dann IBinarySerialize implementieren
    // Serialisierung ist nötig für die Aufteilung in Gruppen und parallele Ausführung
    private List<SqlInt32> numList;
    private SqlInt32 median;


    public void Init()
    {
      // your solution
    }

    public void Accumulate(SqlInt32 value)
    {
      // your solution
    }

    public void Merge(Median group)
    {
      // your solution

    }

    public SqlInt32 Terminate()
    {
      // your solution

      return SqlInt32.MaxValue;
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