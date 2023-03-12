using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CoffeStore.APIs.Models
{
    public class CompraUnidad
    {
        public int? Id { get; set; }
        public Usuario? Usuario { get; set; }
        public FormaPago? FormaPago { get; set; }
        public Producto? Producto { get; set; }
        public int? Cantidad { get; set; }
        public DateTime? CreatedAt { set; get; }
        public DateTime? UpdatedAt { set; get; }
    }
}
