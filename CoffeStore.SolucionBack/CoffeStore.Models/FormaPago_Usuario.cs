using System;
using System.Collections.Generic;
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
    }
}
