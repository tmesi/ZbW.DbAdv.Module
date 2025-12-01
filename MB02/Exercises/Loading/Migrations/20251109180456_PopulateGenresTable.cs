using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Loading.VidApp.Migrations
{
    /// <inheritdoc />
    public partial class PopulateGenresTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
      migrationBuilder.Sql(@"
        INSERT INTO Genres (Id, Name)
        VALUES 
	        (1, 'Comedy'), 
	        (2, 'Action'), 
	        (3, 'Horror'), 
	        (4, 'Thriller'), 
	        (5, 'Family'), 
	        (6, 'Romance'), 
          (7, 'Dram'), 
          (8, 'Sci-Fi');
        ");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
          migrationBuilder.Sql("DELETE FROM Genres WHERE Id BETWEEN 1 AND 8;");
        }
    }
}
