using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CoffeStore.APIs.Models
{
    public class CompraConjunto
    {
        public int? Id { get; set; }
        public CompraUnidad? CompraUnidad { get; set; }
        public DateTime? CreatedAt { set; get; }
        public DateTime? UpdatedAt { set; get; }
    }
}
