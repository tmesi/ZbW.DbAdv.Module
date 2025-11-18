namespace EFCoreDemo
{
  internal class Program
  {
    static void Main(string[] args)
    {
      var conceptDemos = new ConceptDemos();

      /*  
          call methods separately 
          before every call execute:
          dotnet ef database drop --force
          dotnet ef database update
      */

      //conceptDemos.DoCodeFirst();

      //conceptDemos.DoQueries();

      //conceptDemos.DoLoading();

      conceptDemos.DoEdit();

      //conceptDemos.DoUnitOfWork();
    }
  }
}
