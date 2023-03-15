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
        public int? Codigo { get; set; }
        public string? Nombre { get; set; }
        public string? Descripcion { get; set; }
        public string? ImagenUrl { get; set;}
        public float? Precio { get; set; }
        public string? Categoria { get; set; }
        public string? Estado { get; set; }
        public DateTime? CreatedAt { set; get; }
        public DateTime? UpdatedAt { set; get; }
    }
}
