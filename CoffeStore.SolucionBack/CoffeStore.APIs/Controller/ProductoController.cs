using CoffeStore.Models;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using proyecto.API.Shared;
using System.Data;
using System.Xml.Linq;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace CoffeStore.APIs.Controller
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductoController : ControllerBase
    {

        [Route("getall")]
        [HttpGet]
        public async Task<ActionResult<Producto>> GetProducto()
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["default_bd"];
            DataSet dsResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNames.GetProducto, "CONSULTA_PRODUCTO_TODOS");
            return Ok(JsonConvert.SerializeObject(dsResultado, Newtonsoft.Json.Formatting.Indented));
        }

        [Route("[action]")]
        [HttpPost]

        public async Task<ActionResult<Producto>> GetProductoModificar([FromBody] Producto producto)
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["conexion_bd"];
            XDocument xmlParam = DBXmlMethods.getXML(producto);
            DataSet sResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNames.GetProducto, xmlParam.ToString(), "MODIFY");
            return Ok(JsonConvert.SerializeObject(sResultado, Formatting.Indented));
        }

        [HttpDelete("{id}")]

        public async Task<ActionResult<Producto>> GetProductoEliminar([FromBody] Producto producto)
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["conexion_bd"];
            XDocument xmlParam = DBXmlMethods.getXML(producto);
            DataSet sResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNames.GetProducto, xmlParam.ToString(), "DELETE");
            return Ok(JsonConvert.SerializeObject(sResultado, Formatting.Indented));
        }

        [Route("[action]")]
        [HttpPost]

        public async Task<ActionResult<Producto>> GetProductoInsertar([FromBody]Producto producto)
        {
            try
            {
                var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["conexion_bd"];
                XDocument xmlParam = DBXmlMethods.getXML(producto);
                DataSet sResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNames.GetProducto, xmlParam.ToString(), "INSERT");
                return Ok(JsonConvert.SerializeObject(sResultado, Formatting.Indented));

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}

