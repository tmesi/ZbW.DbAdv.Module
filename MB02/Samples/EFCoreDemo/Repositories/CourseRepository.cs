namespace EFCoreDemo.Repositories
{
  using EFCoreDemo.Interfaces;
  using EFCoreDemo.Models;
  using Microsoft.EntityFrameworkCore;

  public class CourseRepository : Repository<Course>, ICourseRepository
  {
    public CourseRepository(CourseContext context)
        : base(context)
    {
    }

    public IEnumerable<Course>? GetTopSellingCourses(int count)
    {
      return CourseContext?.Courses.OrderByDescending(c => c.FullPrice).Take(count).ToList();
    }

    public IEnumerable<Course>? GetCoursesWithAuthors(int pageIndex, int pageSize = 10)
    {
      return CourseContext?.Courses
          .Include(c => c.Author)
          .OrderBy(c => c.Title)
          .Skip((pageIndex - 1) * pageSize)
          .Take(pageSize)
          .ToList();
    }

    public CourseContext? CourseContext
    {
      get { return Context as CourseContext; }
    }
  }
}
