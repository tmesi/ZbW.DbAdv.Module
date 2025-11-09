namespace EFCoreDemo.Model {


  using System.ComponentModel.DataAnnotations;
  using System.ComponentModel.DataAnnotations.Schema;


  public class Course
  {
    // Id oder CourseId wird autom. zum PK oder [Key]
    public int Id { get; set; }

    [Required]
    public string Title { get; set; }

    [Required]
    public string? Description { get; set; }
    public CourseLevel Level { get; set; }

    [Column(TypeName = "decimal(7,2)")]
    public decimal FullPrice { get; set; }

    public Author Author { get; set; }
    public ICollection<CourseTag> CourseTags { get; set; }

    public Category Category { get; set; }

  }
}
