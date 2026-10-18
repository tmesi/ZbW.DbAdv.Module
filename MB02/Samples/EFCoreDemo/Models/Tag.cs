namespace EFCoreDemo.Models {
    public class Tag {
        public int Id { get; set; }
        public string Name { get; set; }
        public virtual ICollection<CourseTag> CourseTags { get; set; }
    }
}
