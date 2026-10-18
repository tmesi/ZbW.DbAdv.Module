namespace EFCoreDemo.Interfaces
{
  using EFCoreDemo.Models;

  public interface IAuthorRepository : IRepository<Author>
  {
    Author GetAuthorWithCourses(int id);

  }
}
