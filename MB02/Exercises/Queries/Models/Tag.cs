namespace Queries.VidApp.Models
{


  public class Tag
  {
    public int Id { get; set; }
    public string Name { get; set; }
    public ICollection<Video> Videos { get; private set; }

  }
}
