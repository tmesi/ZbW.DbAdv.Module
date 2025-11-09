namespace CodeFirst.VidApp
{
  using CodeFirst.VidApp.Models;
  using Microsoft.EntityFrameworkCore;

  public class VidAppContext : DbContext
  {
    public DbSet<Video> Videos { get; set; }
    
    public DbSet<Genre> Genres { get; set; }
   
    public DbSet<VideoGenre> VideoGenres { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
      optionsBuilder.UseSqlServer("Server=.;Database=VidApp_CodeFirst;Trusted_Connection=True;TrustServerCertificate=True");
    }
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
      modelBuilder.Entity<VideoGenre>()
        .HasKey(vg => new { vg.VideoId, vg.GenreId });

      modelBuilder.Entity<VideoGenre>()
        .HasOne(vg => vg.Video)
        .WithMany(v => v.VideoGenres)
        .HasForeignKey(vg => vg.VideoId);

      modelBuilder.Entity<VideoGenre>()
        .HasOne(vg => vg.Genre)
        .WithMany(g => g.VideoGenres)
        .HasForeignKey(vg => vg.GenreId);
    }
  }
}
