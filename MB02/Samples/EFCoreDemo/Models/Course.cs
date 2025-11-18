namespace EFCoreDemo.Models {


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
    public virtual CourseLevel Level { get; set; }

    [Column(TypeName = "decimal(7,2)")]
    public decimal FullPrice { get; set; }

    public virtual Author Author { get; set; }
    public virtual ICollection<CourseTag> CourseTags { get; set; }

    public virtual Category Category { get; set; }

  }
}
