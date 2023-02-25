using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CoffeStore.Models
{
    public class CompraConjunto
    {
        public int? Id { get; set; }
        public CompraUnidad? CompraUnidad { get; set; }
    }
}
