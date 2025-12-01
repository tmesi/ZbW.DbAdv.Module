namespace CodeFirst.VidApp.Models
{
  using System.Collections.Generic;
  using System.ComponentModel.DataAnnotations;

  public class Tag
  {
    public int Id { get; set; }

    [Required]
    [MaxLength(255)]
    public required string Name { get; set; }

    public ICollection<Video>? Videos { get; private set; }
  }
}
