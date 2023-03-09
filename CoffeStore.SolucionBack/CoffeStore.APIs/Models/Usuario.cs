using System.Data.SqlTypes;

namespace CoffeStore.APIs.Models
{
    public class Usuario
    {
        public int Id { set; get; }
        public string? Cedula { set; get; }
        public string Nombres { set; get; }
        public string Apellidos { set; get; }
        public SqlDateTime? FechaNacimiento { set; get; }
        public string? Email { set; get; }
        public string? Contrasena { set; get; }
        public RolUsuario Rol { set; get; }
        public string? Estado { set; get; }
        public SqlDateTime? CreatedAt { set; get; }
        public SqlDateTime? UpdatedAt { set; get; }
    }
}