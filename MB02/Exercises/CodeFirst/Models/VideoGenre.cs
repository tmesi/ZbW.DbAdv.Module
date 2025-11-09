namespace CodeFirst.VidApp.Models
{

  public class VideoGenre
  {
    public int VideoId { get; set; }
    
    public Video? Video { get; set; }

    public byte GenreId { get; set; }
    
    public Genre? Genre { get; set; }
  }
}
