namespace Loading
{
  using Loading.VidApp;
  using Microsoft.EntityFrameworkCore;
  using System.Linq;

  internal class Program
  {
    static void Main(string[] args)
    {
      // Um LazyLoading zu aktivieren, müssen die Navigation-Properties als virtual definiert werden,
      // damit EF ein Proxy erstellen kann.

      using (var context = new VidAppContext())
      {

        var videos = context.Videos.ToList();

        Console.WriteLine();
        Console.WriteLine("LAZY LOADING");
        foreach (var v in videos)
          Console.WriteLine("{0} ({1})", v.Name, v.Genre.Name);

        // Eager loading
        var videosWithGenres = context.Videos.Include(v => v.Genre).ToList();

        Console.WriteLine();
        Console.WriteLine("EAGER LOADING");
        foreach (var v in videosWithGenres)
          Console.WriteLine("{0} ({1})", v.Name, v.Genre.Name);

        // Explicit loading

        // NOTE: At this point, genres are already loaded into the context,
        // so the following line is not going to make a difference. If you 
        // want to see expicit loading in action, comment out the eager loading 
        // part as well as the foreach block in the lazy loading.
        context.Genres.Load();

        Console.WriteLine();
        Console.WriteLine("EXPLICIT LOADING");
        foreach (var v in videos)
          Console.WriteLine("{0} ({1})", v.Name, v.Genre.Name);


      }
    }
  }
}
