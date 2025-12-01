namespace ChangingData
{
  using ChangingData.VidApp;
  using ChangingData.VidApp.Models;
  using Microsoft.EntityFrameworkCore;
  using System.Linq;

  internal class Program
  {
    static void Main(string[] args)
    {
      // Aufgabe 1
      // Hier wurde die GenreId (2) hardcodiert. In einer real-world Applikation,
      // würde der Benutzer das Genre z.B. aus einer Drop-Down-List selektieren. Dort wäre
      // die Id für jedes Genre vorhanden.
      AddVideo(new Video
      {
        Name = "Terminator 1",
        GenreId = 2,
        Classification = Classification.Silver,
        ReleaseDate = new DateTime(1984, 10, 26)
      });


      // Aufgabe 2
      AddTags("classics", "drama");


      // Aufgabe 3
      AddTagsToVideo(1, "classics", "drama", "comedy");


      // Aufgabe 4
      RemoveTagsFromVideo(1, "comedy");


      // Aufgabe 5
      RemoveVideo(1);


      // Aufgabe 6
      RemoveGenre(2, true);
    }

    public static void AddVideo(Video video)
    {
      using (var context = new VidAppContext())
      {
        context.Videos.Add(video);
        context.SaveChanges();
      }
    }

    public static void AddTags(params string[] tagNames)
    {
      using (var context = new VidAppContext())
      {
        // Wir laden die Tags vorgängig um Duplikate zu vermeiten
        var tags = context.Tags.Where(t => tagNames.Contains(t.Name)).ToList();

        foreach (var name in tagNames)
        {
          if (!tags.Any(t => t.Name.Equals(name, StringComparison.CurrentCultureIgnoreCase)))
            context.Tags.Add(new Tag { Name = name });
        }

        context.SaveChanges();
      }
    }

    public static void AddTagsToVideo(int videoId, params string[] tagNames)
    {
      using (var context = new VidAppContext())
      {
        // Mit LINQ:
        // SELECT FROM Tags WHERE Name IN ('classics', 'drama')
        var tags = context.Tags.Where(t => tagNames.Contains(t.Name)).ToList();

        foreach (var tagName in tagNames)
        {
          if (!tags.Any(t => t.Name.Equals(tagName, StringComparison.CurrentCultureIgnoreCase)))
            tags.Add(new Tag { Name = tagName });
        }

        var video = context.Videos.Single(v => v.Id == videoId);

        tags.ForEach(t => video.AddTag(t));

        context.SaveChanges();
      }
    }

    public static void RemoveTagsFromVideo(int videoId, params string[] tagNames)
    {
      using (var context = new VidAppContext())
      {
        context.Tags.Where(t => tagNames.Contains(t.Name)).Load();

        var video = context.Videos.Single(v => v.Id == videoId);

        foreach (var tagName in tagNames)
        {
          // Wir haben die Logik für das Entfernen von Tags in der Video-Klasse gekapselt.
          // Das ist sauberes OO. Die Video-Klasse soll verantwortlich sein, um Tags 
          // um Tags zu ihrer Liste hinzuzufügen bzw. zu entfernen. 
          video.RemoveTag(tagName);
        }

        context.SaveChanges();
      }
    }

    public static void RemoveVideo(int videoId)
    {
      using (var context = new VidAppContext())
      {
        var video = context.Videos.SingleOrDefault(v => v.Id == videoId);
        if (video == null) return;

        context.Videos.Remove(video);
        context.SaveChanges();
      }
    }

    public static void RemoveGenre(int genreId, bool enforceDeletingVideos)
    {
      using (var context = new VidAppContext())
      {
        var genre = context.Genres.Include(g => g.Videos).SingleOrDefault(g => g.Id == genreId);
        if (genre == null) return;

        if (enforceDeletingVideos)
          context.Videos.RemoveRange(genre.Videos);

        context.Genres.Remove(genre);
        context.SaveChanges();
      }
    }
  }
}
