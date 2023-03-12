using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.SqlTypes;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CoffeStore.APIs.Models
{
    public class Producto
    {
        public Producto()
        {
            CreatedAt = DateTime.Now;
            Estado = "A";
        }
        public int? Id { get; set; }
        public string? Nombre { get; set; }
        public string? Descripcion { get; set; }
        public string? ImagenUrl { get; set;}
        public float? Precio { get; set; }
        [ForeignKey ("Categoria")]
        public string? CategoriaCodigo { get; set; }
        public CategoriaProducto? Categoria { get; set; }
        public string? Estado { get; set; }
        public DateTime? CreatedAt { set; get; }
        public DateTime? UpdatedAt { set; get; }
    }
}
