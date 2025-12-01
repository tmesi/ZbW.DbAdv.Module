using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ChangingData.VidApp.Migrations
{
  /// <inheritdoc />
  public partial class DisableCascadeDeleteBetweenGenresAndVideos : Migration
  {
    /// <inheritdoc />
    protected override void Up(MigrationBuilder migrationBuilder)
    {
      migrationBuilder.DropForeignKey(
        name: "FK_Videos_Genres_GenreId",
        table: "Videos");
      migrationBuilder.AddForeignKey(
          name: "FK_Videos_Genres_GenreId",
          table: "Videos",
          column: "GenreId",
          principalTable: "Genres",
          principalColumn: "Id");
    }

    /// <inheritdoc />
    protected override void Down(MigrationBuilder migrationBuilder)
    {
      migrationBuilder.DropForeignKey(
        name: "FK_Videos_Genres_GenreId",
        table: "Videos");
      migrationBuilder.AddForeignKey(
               name: "FK_Videos_Genres_GenreId",
               table: "Videos",
               column: "GenreId",
               principalTable: "Genres",
               principalColumn: "Id",
               onDelete: ReferentialAction.Cascade);
    }
  }
}
