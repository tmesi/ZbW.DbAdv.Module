using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CodeFirst.VidApp.Migrations
{
    /// <inheritdoc />
    public partial class AddGenreToVideosTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "VideoGenres");

            migrationBuilder.AddColumn<byte>(
                name: "GenreId",
                table: "Videos",
                type: "tinyint",
                nullable: false,
                defaultValue: (byte)0);

            migrationBuilder.CreateIndex(
                name: "IX_Videos_GenreId",
                table: "Videos",
                column: "GenreId");

            migrationBuilder.AddForeignKey(
                name: "FK_Videos_Genres_GenreId",
                table: "Videos",
                column: "GenreId",
                principalTable: "Genres",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Videos_Genres_GenreId",
                table: "Videos");

            migrationBuilder.DropIndex(
                name: "IX_Videos_GenreId",
                table: "Videos");

            migrationBuilder.DropColumn(
                name: "GenreId",
                table: "Videos");

            migrationBuilder.CreateTable(
                name: "VideoGenres",
                columns: table => new
                {
                    VideoId = table.Column<int>(type: "int", nullable: false),
                    GenreId = table.Column<byte>(type: "tinyint", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VideoGenres", x => new { x.VideoId, x.GenreId });
                    table.ForeignKey(
                        name: "FK_VideoGenres_Genres_GenreId",
                        column: x => x.GenreId,
                        principalTable: "Genres",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_VideoGenres_Videos_VideoId",
                        column: x => x.VideoId,
                        principalTable: "Videos",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_VideoGenres_GenreId",
                table: "VideoGenres",
                column: "GenreId");
        }
    }
}
