namespace EFCoreDemo
{
  using EFCoreDemo.Models;
  using Microsoft.EntityFrameworkCore;

  public class ConceptDemos
  {
    public void DoCodeFirst()
    {
      using (var context = new CourseContext())
      {
        var a = context.Authors.Include(x => x.Courses).First(x => x.Id == 1);
        context.Courses.RemoveRange(a.Courses);
        context.Authors.Remove(a);
        context.SaveChanges();

        var author = new Author()
        {
          Name = "Thomas Kehl"
        };


        var course = new Course()
        {
          Title = "C# Programming",
          Description = "Description of C# Programming",
          Author = author,
          Category = context.Categories.FirstOrDefault(c => c.Id == 2)!
        };

        context.Courses.Add(course);

        var c2 = context.Courses.Single(x => x.Id == 4);
        c2.FullPrice = 700;

        var c3 = context.Courses.Single(x => x.Id == 9);
        context.Courses.Remove(c3);

        context.SaveChanges();

      }
    }

    public void DoQueries()
    {
      using (var context = new CourseContext())
      {

        // LINQ-QuerySyntax
        var query =
                from c in context.Courses
                where c.Title.Contains("c#")
                orderby c.FullPrice
                select c;

        query = (IOrderedQueryable<Course>)query.Where(x => x.FullPrice > 10);

        foreach (var c in query)
        {
          Console.WriteLine(c.Title);
        }


        // Extension Methods
        var q = context.Courses
            .Where(x => x.Author.Name.StartsWith("T"))
            .OrderBy(x => x.FullPrice);

        //if (onlyCoursesWithHashTag) {
        //    q = (IOrderedQueryable<Course>)q.Where(x => x.Title.Contains("#"));
        //}


        var q1 = q.Where(x => x.Title.Contains("#"));

        var query10 =
            context.Courses
                .Where(c => c.Author.Name.StartsWith("T"))
                .OrderBy(c => c.FullPrice);

        query10 = query10.ThenByDescending(c => c.Level);

        //var list = query.SingleOrDefault();

        foreach (var c in query10)
        {
          Console.WriteLine(c.Title);
        }


        var course = context.Courses.Find(8);


        var author = context.Authors.Include(c => c.Courses).Single(c => c.Id == 2);
        foreach (var c in author.Courses)
        {
          Console.WriteLine(c.Title);
        }

        var courses = context.Courses.Include(c => c.Author).ToList();
        foreach (var c in courses)
        {
          Console.WriteLine($"{c.Title}-{c.Author.Name}");
        }


        // ------------------------- Samples
        var query1 =
            from c in context.Courses
            where c.Author.Id == 1
            orderby c.Level descending, c.Title
            select c;
        foreach (var c in query1)
        {
          Console.WriteLine(c.Title);
        }

        // Projection to Anonymous Object
        var query2 =
            from c in context.Courses
            where c.Author.Id == 1
            orderby c.Level descending, c.Title
            select new { Name = c.Title, Author = c.Author.Name };
        foreach (var c in query2)
        {
          Console.WriteLine($"Kurs: {c.Name}, Autor: {c.Author}");
        }

        // Group: Database group (selektiert nur Key und Count = Aggragate-Function)
        var query3 =
            from c in context.Courses
            group c by c.Level
            into g
            select new { Key = g.Key, Count = g.Count() };
        foreach (var group in query3)
        {
          Console.WriteLine($"{group.Key} ({group.Count})");
        }


        // Group: eine Liste von Objekte in eine oder mehrere Gruppen aufteilen
        // -> funktioniert bei EFCore nicht mehr, Objekte herunterladen und dann 
        //    lokal gruppieren -> siehe LINQ
        // aaa
        //var query31 =
        //    from c in context.Courses
        //    group c by c.Level
        //    into g
        //    select g;
        //foreach (var group in query31) {
        //    Console.WriteLine($"{group.Key} ({group.Count()})");

        //    foreach (var c in group) {
        //        Console.WriteLine($"\t{c.Title}");
        //    }
        //}


        // Inner Join 
        // Wenn kein NavigationProperty oder Relationship zwischen den zwei Entities - Link über einen Key
        var query4 =
            from c in context.Courses
            join a in context.Authors on c.Author.Id equals a.Id
            select new { CourseName = c.Title, AuthorName = a.Name };
        foreach (var c in query4)
        {
          Console.WriteLine($"Kurs: {c.CourseName}, Autor: {c.AuthorName}");
        }


        // Cross Join
        var query5 =
            from a in context.Authors
            from c in context.Courses
            select new { AuthorName = a.Name, CourseName = c.Title };
        foreach (var c in query5)
        {
          Console.WriteLine($"Kurs: {c.CourseName}, Autor: {c.AuthorName}");
        }


        // Inner Join mit Extension Methods
        var courses2 = context.Courses.Join(context.Authors, c => c.Author.Id, a => a.Id, (course, author) => new {
          CourseName = course.Title,
          AuthorName = author.Name
        });
        foreach (var c in courses2)
        {
          Console.WriteLine($"Kurs: {c.CourseName}, Autor: {c.AuthorName}");
        }


        // Cross Join mit Extension Methods
        var courses3 = context.Authors.SelectMany(a => context.Courses, (author, course) => new {
          AuthorName = author.Name,
          CourseName = course.Title
        });
        foreach (var c in courses3)
        {
          Console.WriteLine($"Kurs: {c.CourseName}, Autor: {c.AuthorName}");
        }


        // Partitioning
        var courses4 = context.Courses.OrderBy(c => c.Level).Skip(10).Take(10);
        foreach (var c in courses4)
        {
          Console.WriteLine($"Kurs: {c.Title}");
        }

        var course1 = context.Courses.OrderBy(c => c.Level).FirstOrDefault(c => c.FullPrice > 100);

        // Aggregates
        var count = context.Courses.Count();
        var min = context.Courses.Min(c => c.FullPrice);
        var max = context.Courses.Max(c => c.FullPrice);
        var avg = context.Courses.Average(c => c.FullPrice);


        // Deffered Execution
        var courses5 = context.Courses;
        var filtered = courses5.Where(c => c.Level == CourseLevel.Beginner);
        var sorted = filtered.OrderBy(c => c.Title);
        foreach (var c in sorted)
        {
          Console.WriteLine($"Kurs: {course!.Title}");
        }

        // Find
        var course2 = context.Courses.Find(4);
        var course3 = context.Courses.Find(5);
        var course4 = context.Courses.Find(4);
        var course6 = context.Courses.SingleOrDefault(c => c.Id == 4);


      }
    }

    public void DoLoading()
    {
      using (var context = new CourseContext())
      {

        // ACHTUNG: für Lazy-Loading am besten nicht den Debugger verwenden sondern Ctrl+F5
        //          Der Debugger zeigt z.B. bei der foreach-Schleife als Hint zu course.Tags die Anzahl an,
        //          was zur Folge hat, dass das "Lazy-STatement" sofort ausgeführt wird.
        // EAGER LOADING: Wird Lazy-Loading ausgeschaltet (entweder durch entfernen von virtual, dann muss jedoch im Context 
        //                auch die Config UseLazyLoadingProxies() entfernt werden),
        //                führt EF nicht automatisch Eager-Loading aus. Dies muss explizit gesagt werden (.Include())
        //                https://stackoverflow.com/a/18920095/2042829

        // Lazy Loading
        var course = context.Courses
            .Include(x => x.CourseTags)
            .ThenInclude(x => x.Tag)
            .Include(x => x.Author)
            .Include(x => x.Category)
            .Single(c => c.Id == 4);
        //Wait();

        
        foreach (var courseTag in course.CourseTags)
        {
          Console.WriteLine(courseTag.Tag.Name);
        }

        //Wait();

        // Lazy Loading N+1
        var courses = context.Courses.Include(c => c.Author).ToList();
        //Wait();

        foreach (var c in courses)
        {
          Console.WriteLine($"{c.Title} - {c.Author.Name}");
        }

        //Wait();

        // Eager Loading (mit Magic String)
        var courses1 = context.Courses.Include("Author").ToList();
        foreach (var c in courses1)
        {
          Console.WriteLine($"{c.Title} - {c.Author.Name}");
        }

        //Wait();

        // Eager Loading (ohne Magic String)
        var courses2 = context.Courses.Include(c => c.Author).ToList();
        //Wait();
        foreach (var c in courses2)
        {
          Console.WriteLine($"{c.Title} - {c.Author.Name}");
        }

        //Wait();

        // Eager Loading -> komplexe Statements
        var author1 = context.Authors.Include(a => a.Courses).Single(a => a.Id == 2);
        //Wait();

        // Explicit Loading
        var author2 = context.Authors.Single(a => a.Id == 3);
        //Wait();
        context.Courses.Where(c => c.Author.Id == author2.Id).Load();
        //Wait();
        foreach (var c in author2.Courses)
        {
          Console.WriteLine($"{c.Title}");
        }
      }
    }

    public void DoEdit()
    {
      using (var context = new CourseContext())
      {
        var course = context.Courses.Find(4);
        course!.Title = "New Name";
        course.Author = context.Authors.Find(2)!;

        var author = context.Authors.Find(2);

        //context.Authors.Remove(author!);
        //context.SaveChanges(); // Fehler weil Referenz zu Course

        author = context.Authors
        .Include(a => a.Courses)
        .Single(a => a.Id == 2);

        context.Courses.RemoveRange(author.Courses);
        context.Authors.Remove(author);
        context.SaveChanges();

        // Delete (mit Cascade Delete auf der Datenbank - zu CourseTags)
        course = context.Courses.Find(7);
        context.Courses.Remove(course!);
        context.SaveChanges();


        context.Authors.Add(new Author() { Name = "New Author" });

        author = context.Authors.Find(3);
        author!.Name = "updated2";

        var another = context.Authors.Find(4);
        context.Authors.Remove(another!);

        context.SaveChanges();




        // Add object
        context.Authors.Add(new Author() { Name = "New Author" });
        // Update object
        author = context.Authors.Find(5);
        author!.Name = "updated";
        // Remove object
        another = context.Authors.Find(6);
        context.Authors.Remove(another!);

        var entries = context.ChangeTracker.Entries();
        foreach (var entry in entries)
        {
          // entry.Reload();
          Console.WriteLine(entry.State);
        }
      }
    }

    public void DoUnitOfWork()
    {
      using (var unitOfWork = new UnitOfWork(new CourseContext()))
      {
        // Example1
        var course = unitOfWork.Courses.Get(1);

        // Example2
        var courses = unitOfWork.Courses.GetCoursesWithAuthors(1, 4);

        // Example3
        var author = unitOfWork.Authors.GetAuthorWithCourses(1);
        unitOfWork.Courses.RemoveRange(author.Courses);
        unitOfWork.Authors.Remove(author);
        unitOfWork.Complete();
      }
    }

    private static void Wait()
    {
      Console.WriteLine("Press any key to continue");
      Console.ReadKey();
    }

  }
}
