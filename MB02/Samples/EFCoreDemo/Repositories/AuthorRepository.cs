namespace EFCoreDemo.Repositories
{
  using EFCoreDemo.Interfaces;
  using EFCoreDemo.Models;
  using Microsoft.EntityFrameworkCore;

  using System.Linq;


  public class AuthorRepository : Repository<Author>, IAuthorRepository
  {
    public AuthorRepository(CourseContext context) : base(context)
    {
    }

    public Author? GetAuthorWithCourses(int id)
    {
      return CourseContext?.Authors.Include(a => a.Courses).SingleOrDefault(a => a.Id == id);
    }

    public CourseContext? CourseContext
    {
      get { return Context as CourseContext; }
    }
  }
}
