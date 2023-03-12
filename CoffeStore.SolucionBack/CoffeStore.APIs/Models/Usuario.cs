using System.Data.SqlTypes;

namespace CoffeStore.APIs.Models
{
    public class Usuario
    {
        public int Id { set; get; }
        public string? Cedula { set; get; }
        public string? Nombres { set; get; }
        public string? Apellidos { set; get; }
        public DateOnly? FechaNacimiento { set; get; }
        public string? Email { set; get; }
        public string? Contrasena { set; get; }
        public string? Rol { set; get; }
        public string? Estado { set; get; }
        public DateTime? CreatedAt { set; get; }
        public DateTime? UpdatedAt { set; get; }
    }
}