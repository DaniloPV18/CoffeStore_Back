using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CoffeStore.Models
{
    public class Producto
    {
        public int? Id { get; set; }
        public string? Nombre { get; set; }
        public string? Descripcion { get; set; }
        public string? ImagenUrl { get; set;}
        public float? Precio { get; set; }
        public CategoriaProducto? Categoria { get; set; }
        public string? Estado { get; set; }
        public SqlDateTime? CreatedAt { set; get; }
        public SqlDateTime? UpdatedAt { set; get; }
    }
}
