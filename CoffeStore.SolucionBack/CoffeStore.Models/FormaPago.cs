using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CoffeStore.Models
{
    public class FormaPago
    {
        public string? Codigo { get; set; }
        public string? Metodo { get; set; }
        public string? Cuenta { get; set; }
        public SqlDateTime? CreatedAt { get; set; }
    }
}
