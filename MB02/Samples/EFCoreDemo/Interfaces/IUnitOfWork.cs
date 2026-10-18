namespace EFCoreDemo.Interfaces
{
  using System;

  public interface IUnitOfWork : IDisposable
  {
    ICourseRepository Courses { get; }

    IAuthorRepository Authors { get; }
  }
}
