namespace Queries
{
  using Queries.VidApp;

  internal class Program
  {
    static void Main(string[] args)
    {
      using (var context = new VidAppContext())
      {

        // Aufgabe 1: Actionfilme sortiert nach Name
        Console.WriteLine();
        Console.WriteLine("ACTION MOVIES SORTED BY NAME");
        var actionMovies = context.Videos
            .Where(v => v.Genre.Name == "Action")
            .OrderBy(v => v.Name);

        foreach (var v in actionMovies)
          Console.WriteLine(v.Name);

        // Aufgabe 2: Gold Drama File sortiert nach Erscheinungsdatum (ReleaseDate). Neuster Film zuerst.
        var dramaMovies = context.Videos
            .Where(v => v.Genre.Name == "Drama" && v.Classification == Classification.Gold)
            .OrderByDescending(v => v.ReleaseDate);

        Console.WriteLine();
        Console.WriteLine("GOLD DRAMA MOVIES SORTED BY RELEASE DATE (NEWEST FIRST)");
        foreach (var v in dramaMovies)
          Console.WriteLine(v.Name);

        // Aufgabe 3: Alle Filme projiziert in einen anonymen Typ
        var projected = context.Videos
            .Select(v => new { MovieName = v.Name, Genre = v.Genre.Name });

        Console.WriteLine();
        Console.WriteLine("ALL MOVIES PROJECTED INTO AN ANONYMOUS TYPE");
        foreach (var v in projected)
          Console.WriteLine(v.MovieName);

        // Aufgabe 4: Alle Filme gruppiert nach Classification
        var groups = context.Videos
            .AsEnumerable()
            .GroupBy(v => v.Classification)
            .Select(g => new {
              Classification = g.Key.ToString(),
              Videos = g.OrderBy(v => v.Name)
            });

        Console.WriteLine();
        Console.WriteLine("ALL MOVIES GROUPED BY CLASSIFICATION");
        foreach (var g in groups)
        {
          Console.WriteLine("Classification: " + g.Classification);

          foreach (var v in g.Videos)
            Console.WriteLine("\t" + v.Name);
        }

        // Aufgabe 5: Classifications and Anzahl Videos
        var classifications = context.Videos
            .GroupBy(v => v.Classification)
            .Select(g => new {
              Name = g.Key.ToString(),
              VideosCount = g.Count()
            })
            .OrderBy(c => c.Name);

        Console.WriteLine();
        Console.WriteLine("CLASSIFICATIONS AND NUMBER OF VIDEOS IN THEM");
        foreach (var c in classifications)
          Console.WriteLine("{0} ({1})", c.Name, c.VideosCount);


        // Aufgabe 6: Genres and Anzahl Videos
        var genres = context.Genres
            .GroupJoin(context.Videos, g => g.Id, v => v.GenreId, (genre, videos) => new {
              Name = genre.Name,
              VideosCount = videos.Count()
            })
            .OrderByDescending(g => g.VideosCount);

        Console.WriteLine();
        Console.WriteLine("GENRES AND NUMBER OF VIDEOS IN THEM");
        foreach (var g in genres)
          Console.WriteLine("{0} ({1})", g.Name, g.VideosCount);
      }
    }
  }
}
