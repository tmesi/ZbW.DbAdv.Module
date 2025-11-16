namespace EFCoreDemo.Interfaces
{
  using EFCoreDemo.Models;

  public interface ICourseRepository : IRepository<Course>
  {
    IEnumerable<Course> GetTopSellingCourses(int count);
    IEnumerable<Course> GetCoursesWithAuthors(int pageIndex, int pageSize);

  }
}
