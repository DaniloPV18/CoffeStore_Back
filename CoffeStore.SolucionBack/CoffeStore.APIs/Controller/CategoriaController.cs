using CoffeStore.APIs.Models;
using CoffeStore.APIs.Shared;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Data;

namespace CoffeStore.APIs.Controller
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriaController : ControllerBase
    {
        [Route("getall")]
        [HttpGet]
        public async Task<ActionResult> GetCategoriaProducto()
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["conexion_bd"];
            DataSet dsResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesProducto.GetCategoriaProducto, "CONSULTA_CATEGORIA_TODOS", "");
            return Ok(JsonConvert.SerializeObject(dsResultado.Tables[0], Newtonsoft.Json.Formatting.Indented));
        }

    }
}
