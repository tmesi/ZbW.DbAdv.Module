namespace CodeFirst.VidApp.Models
{
  using System.ComponentModel.DataAnnotations;

  public class Genre
  {
    public byte Id { get; set; }

    [Required]
    [MaxLength(255)]
    public required string Name { get; set; }
    
    public ICollection<VideoGenre>? VideoGenres { get; set; }
  }
}
