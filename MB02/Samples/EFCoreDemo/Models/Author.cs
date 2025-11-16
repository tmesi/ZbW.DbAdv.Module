namespace EFCoreDemo.Models {
    public class Author {
#nullable enable
        public int Id { get; set; }
        public string Name { get; set; }
        public string? PostalCode { get; set; }
        public string? City { get; set; }
        public string? Phone { get; set; }
        public string? Mail { get; set; }
        public string? MobilePhone { get; set; }
#nullable disable
        public ICollection<Course> Courses { get; set; }
    }

}
