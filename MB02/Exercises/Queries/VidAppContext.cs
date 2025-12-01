namespace Queries.VidApp
{
  using Queries.VidApp.Models;
  using Microsoft.EntityFrameworkCore;

  public class VidAppContext : DbContext
  {
    public DbSet<Video> Videos { get; set; }
    
    public DbSet<Genre> Genres { get; set; }
   
    public DbSet<Tag> Tags { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
      optionsBuilder.UseSqlServer("Server=.;Database=VidApp_Queries;Trusted_Connection=True;TrustServerCertificate=True");
    }
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
    }
  }
}
