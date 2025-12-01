using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ChangingData.VidApp.Migrations
{
    /// <inheritdoc />
    public partial class AddClassificationToVideosTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<byte>(
                name: "Classification",
                table: "Videos",
                type: "tinyint",
                nullable: false,
                defaultValue: (byte)0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Classification",
                table: "Videos");
        }
    }
}
