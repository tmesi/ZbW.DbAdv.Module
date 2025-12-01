namespace Queries.VidApp.Models
{
  using System;
  using System.Collections.Generic;
  using System.ComponentModel.DataAnnotations;

  public class Video
  {
    public int Id { get; set; }

    [Required]
    [MaxLength(255)]
    public required string Name { get; set; }

    public DateTime ReleaseDate { get; set; }

    public Genre Genre { get; set; }
    public byte GenreId { get; set; }
    public Classification Classification { get; set; }

    public ICollection<Tag> Tags { get; private set; }

  }
}
