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
        public string? UsuarioCedula { get; set; }
        public string? FormaPagoNombre{ get; set; }
        public int? ProductoId { get; set; }
        public int? Cantidad { get; set; }
        public DateTime? CreatedAt { set; get; }
        public DateTime? UpdatedAt { set; get; }
    }
}
