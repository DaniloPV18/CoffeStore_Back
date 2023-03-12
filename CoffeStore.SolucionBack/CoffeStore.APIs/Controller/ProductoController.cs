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
    public class ProductoController : ControllerBase
    {

        [Route("getall")]
        [HttpGet]
        public async Task<ActionResult> GetProducto()
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["conexion_bd"];
            DataSet dsResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesProducto.GetProducto, "CONSULTA_PRODUCTO_TODOS", "");
            return Ok(JsonConvert.SerializeObject(dsResultado.Tables[0],Formatting.Indented));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Producto>> GetProductoid(int id)
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["conexion_bd"];
            Producto producto = new();
            producto.Id = id;
            XDocument xmlParam = DBXmlMethods.getXML(producto);
            DataSet sResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesProducto.GetProducto, "CONSULTA_PRODUCTO_ID", xmlParam.ToString());
            return Ok(JsonConvert.SerializeObject(sResultado, Formatting.Indented));
        }


        [Route("[action]")]
        [HttpPost]
        public async Task<ActionResult<Producto>> GetProductoModificar([FromBody] Producto producto)
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["conexion_bd"];
            producto.UpdatedAt = DateTime.Now;
            XDocument xmlParam = DBXmlMethods.getXML(producto);
            DataSet sResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesProducto.SetProducto, "MODIFY", xmlParam.ToString());
            return Ok(JsonConvert.SerializeObject(sResultado, Formatting.Indented));
        }

        
        [HttpPut("Eliminar/{id}")]

        public async Task<ActionResult<Producto>> GetProductoEliminar(int id)
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["conexion_bd"];
            Producto producto = new(); 
            producto.Id = id;
            XDocument xmlParam = DBXmlMethods.getXML(producto);
            DataSet sResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesProducto.SetProducto, "DELETE", xmlParam.ToString());
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
                DataSet sResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesProducto.SetProducto, "INSERT",xmlParam.ToString());
                return Ok(JsonConvert.SerializeObject(sResultado, Formatting.Indented));

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}

