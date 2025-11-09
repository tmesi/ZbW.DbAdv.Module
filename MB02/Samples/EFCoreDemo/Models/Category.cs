namespace EFCoreDemo.Model {

  using System.ComponentModel.DataAnnotations.Schema;

  public class Category {
        // Id oder CategoryId wird autom. zum PK
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Id { get; set; }
        public string Name { get; set; }
    }
}
