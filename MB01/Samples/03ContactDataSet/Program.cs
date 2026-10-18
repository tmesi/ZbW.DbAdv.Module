namespace ContactDataSet
{
  using System.Data;

  internal class Program
  {
    static void Main(string[] args)
    {
      var creator = new DataSetCreator();

      var ds = creator.Create();

      DataRow personRow = ds.Tables["Person"]!.NewRow();  //person
      personRow[1] = "Wolfgang";
      personRow["Name"] = "Beer";
      ds.Tables["Person"]!.Rows.Add(personRow);

      DataRow contactRow = ds.Tables[1].NewRow();
      contactRow[1] = "Hans";
      contactRow[2] = "Meier";
      contactRow[3] = "Housi";
      contactRow[4] = "hmeier@hsr.ch";
      contactRow[5] = "379";

      contactRow["PersonID"] = (long)personRow["ID"]; // defines relation
      ds.Tables[1].Rows.Add(contactRow);

      contactRow = ds.Tables[1].NewRow();
      contactRow[1] = "Vreni";
      contactRow[2] = "Müller";
      contactRow[3] = "Vreni";
      contactRow[4] = "vmueller@hsr.ch";
      contactRow[5] = "382";

      contactRow["PersonID"] = (long)personRow["ID"]; // defines relation
      ds.Tables[1].Rows.Add(contactRow);


      ds.AcceptChanges();

      foreach (DataRow person in ds.Tables["Person"]!.Rows)
      {
        Console.WriteLine("Contacts of {0}:", person["Name"]);
        foreach (DataRow contact in person.GetChildRows("PersonHasContacts"))
        {
          Console.WriteLine("{0}, {1}: {2}", contact[0], contact["Name"], contact["Phone"]);
        }
      }

      Console.ReadLine();

    }
  }
}
