using EFCoreDemo.Models;
using Microsoft.EntityFrameworkCore;

namespace EFCoreDemo
{
    public class CourseContext : DbContext
    {
    public DbSet<Course> Courses { get; set; }
    public DbSet<Author> Authors { get; set; }
    public DbSet<Tag> Tags { get; set; }
    public DbSet<CourseTag> CourseTags { get; set; }
    public DbSet<Category> Categories { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
      optionsBuilder.UseSqlServer("Server=.;Database=EFCoreDemo;Trusted_Connection=True;TrustServerCertificate=True");

      //optionsBuilder.LogTo(Console.WriteLine);
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
      modelBuilder.Entity<CourseTag>()
          .HasKey(ct => new { ct.CourseId, ct.TagId });

      modelBuilder.Entity<CourseTag>()
          .HasOne(ct => ct.Course)
          .WithMany(c => c.CourseTags)
          .HasForeignKey(ct => ct.CourseId);

      modelBuilder.Entity<CourseTag>()
          .HasOne(ct => ct.Tag)
          .WithMany(t => t.CourseTags)
          .HasForeignKey(ct => ct.TagId);

      modelBuilder.Entity<Course>().Property(c => c.Title).IsRequired();

      #region Categories
      modelBuilder.Entity<Category>().HasData(
                new Category { Id = 1, Name = "Web Development" },
                new Category { Id = 2, Name = "Programming Languages" },
                new Category { Id = 3, Name = "Science" }
            );
      #endregion


      #region Add Tags
      var tags = new Dictionary<string, Tag>
            {
                {"c#", new Tag {Id = 1, Name = "c#"}},
                {"angularjs", new Tag {Id = 2, Name = "angularjs"}},
                {"javascript", new Tag {Id = 3, Name = "javascript"}},
                {"nodejs", new Tag {Id = 4, Name = "nodejs"}},
                {"oop", new Tag {Id = 5, Name = "oop"}},
                {"linq", new Tag {Id = 6, Name = "linq"}},
            };

      foreach (var tag in tags.Values)
        modelBuilder.Entity<Tag>().HasData(tag);
      #endregion

      #region Add Authors
      var authors = new List<Author>
            {
                new()
                {
                    Id = 1,
                    Name = "Bill Gates"
                },
                new()
                {
                    Id = 2,
                    Name = "Anthony Alicea"
                },
                new()
                {
                    Id = 3,
                    Name = "Eric Wise"
                },
                new()
                {
                    Id = 4,
                    Name = "Tom Owsiak"
                },
                new()
                {
                    Id = 5,
                    Name = "John Smith"
                }
            };

      foreach (var author in authors)
        modelBuilder.Entity<Author>().HasData(author);
      #endregion

      #region Add Courses
      var courses = new List<object>
            {
                new
                {
                    Id = 1,
                    Title = "C# Basics",
                    AuthorId = 1,
                    FullPrice = 49.2m,
                    Description = "Description for C# Basics",
                    Level = CourseLevel.Beginner,
                    CategoryId = 1
                },
                new
                {
                    Id = 2,
                    Title = "C# Intermediate",
                    AuthorId = 1,
                    FullPrice = 49.2m,
                    Description = "Description for C# Intermediate",
                    Level = CourseLevel.Beginner,
                    CategoryId = 1
                },
                new
                {
                    Id = 3,
                    Title = "C# Advanced",
                    AuthorId = 1,
                    FullPrice = 69.9m,
                    Description = "Description for C# Advanced",
                    Level = CourseLevel.Advanced,
                    CategoryId = 1
                },
                new
                {
                    Id = 4,
                    Title = "Javascript: Understanding the Weird Parts",
                    AuthorId = 2,
                    FullPrice = 149.0m,
                    Description = "Description for Javascript",
                    Level = CourseLevel.Intermediate,
                    CategoryId = 1
                },
                new
                {
                    Id = 5,
                    Title = "Learn and Understand AngularJS",
                    AuthorId = 2,
                    FullPrice = 99m,
                    Description = "Description for AngularJS",
                    Level = CourseLevel.Intermediate,
                    CategoryId = 1
                },
                new
                {
                    Id = 6,
                    Title = "Learn and Understand NodeJS",
                    AuthorId = 2,
                    FullPrice = 149m,
                    Description = "Description for NodeJS",
                    Level = CourseLevel.Advanced,
                    CategoryId = 1
                },
                new
                {
                    Id = 7,
                    Title = "Programming for Complete Beginners",
                    AuthorId = 3,
                    FullPrice = 45m,
                    Description = "Description for Programming for Beginners",
                    Level = CourseLevel.Advanced,
                    CategoryId = 1
                },
                new
                {
                    Id = 8,
                    Title = "A 16 Hour C# Course with Visual Studio 2013",
                    AuthorId = 4,
                    FullPrice = 150.9m,
                    Description = "Description 16 Hour Course",
                    Level = CourseLevel.Beginner,
                    CategoryId = 1
                },
                new
                {
                    Id = 9,
                    Title = "Learn JavaScript Through Visual Studio 2013",
                    AuthorId = 4,
                    FullPrice = 20m,
                    Description = "Description Learn Javascript",
                    Level = CourseLevel.Intermediate,
                    CategoryId = 1
                }
            };

      foreach (var course in courses)
        modelBuilder.Entity<Course>().HasData(course);
      #endregion

      #region Add CourseTags
      var courseTags = new List<CourseTag>
            {
                             new()
                {
                    CourseId = 1,
                    TagId = tags["c#"].Id
                },
                               new()
                {
                    CourseId = 7,
                    TagId = tags["c#"].Id
                },
                               new()
                {
                    CourseId = 8,
                    TagId = tags["c#"].Id
                },
 new()
                {
                    CourseId = 3,
                    TagId = tags["c#"].Id
                },
                new()
                {
                    CourseId = 2,
                    TagId = tags["c#"].Id
                },
                      new()
                {
                    CourseId = 2,
                    TagId = tags["oop"].Id
                },
                      new()
                {
                    CourseId = 4,
                    TagId = tags["javascript"].Id
                },
                                  new()
                {
                    CourseId = 9,
                    TagId = tags["javascript"].Id
                },
          new()
                {
                    CourseId = 5,
                    TagId = tags["angularjs"].Id
                },
                      new()
                {
                    CourseId = 6,
                    TagId = tags["nodejs"].Id
                },

            };

      foreach (var courseTag in courseTags)
        modelBuilder.Entity<CourseTag>().HasData(courseTag);
      #endregion
    }
  }
}
