using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CoffeStore.Models
{
    public class FormaPago_Usuario
    {
        public int? Id { get; set; }
        public Usuario? Usuario { get; set; }
        public FormaPago? FormaPago { get; set; }
        public string? Cuenta { get; set; }
        public SqlDateTime? CreatedAt { get; set; }
    }
}
