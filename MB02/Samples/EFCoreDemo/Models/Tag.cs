namespace EFCoreDemo.Model {
    public class Tag {
        public int Id { get; set; }
        public string Name { get; set; }
        public ICollection<CourseTag> CourseTags { get; set; }
    }
}
