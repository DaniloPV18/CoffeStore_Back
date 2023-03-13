using CoffeStore.APIs.Models;
using CoffeStore.APIs.Shared;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Data;
using System.Xml.Linq;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace CoffeStore.APIs.Controller
{
    [Route("api/[controller]")]
    [ApiController]
    public class CompraUnidadController : ControllerBase
    {
        [Route("buy")]
        [HttpPost]
        public async Task<ActionResult<Usuario>> RealizarCompra([FromBody] CompraUnidad compraUnidad)
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["conexion_bd"];
            XDocument xmlParam = DBXmlMethods.getXML(compraUnidad);
            DataSet dsResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesProducto.SetCompraUnidad, "INSERT", xmlParam.ToString());
            return Ok(JsonConvert.SerializeObject(dsResultado.Tables[0], Newtonsoft.Json.Formatting.Indented));
        }
    }
}
