using CoffeStore.APIs.Models;
using CoffeStore.APIs.Shared;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Data;
using System.Transactions;
using System.Xml.Linq;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace CoffeStore.APIs.Controller
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        [Route("getall")]
        [HttpGet]
        public async Task<ActionResult<Usuario>> GetUsuario()
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["default_bd"];
            DataSet dsResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesUsuario.GetUsuario, "CONSULTA_USUARIO_TODOS");
            return Ok(JsonConvert.SerializeObject(dsResultado, Newtonsoft.Json.Formatting.Indented));
        }

        /*
        [Route("getid")]
        [HttpGet]
        public async Task<ActionResult<Usuario>> GetUsuarioId(int id, string transaccion)
        {
            Usuario u = new Usuario();
            u.Id = id;
            u.Transaccion = transaccion;
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["default_bd"];
            XDocument xmlParam = DBXmlMethods.getXML(u);
            DataSet dsResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNames.GetUsuario, u.Transaccion, xmlParam.ToString());
            return Ok(JsonConvert.SerializeObject(dsResultado, Newtonsoft.Json.Formatting.Indented));
        }
        */

        [Route("get-account")]
        [HttpPost]
        public async Task<ActionResult<Usuario>> GetUsuario([FromBody] Usuario usuario)
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["default_bd"];
            XDocument xmlParam = DBXmlMethods.getXML(usuario);
            DataSet dsResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesUsuario.GetUsuario, usuario.Transaccion, xmlParam.ToString());
            return Ok(JsonConvert.SerializeObject(dsResultado, Newtonsoft.Json.Formatting.Indented));
        }


        [Route("adm-account")]
        [HttpPost]
        public async Task<ActionResult<Usuario>> SetUsuario([FromBody] Usuario usuario)
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["default_bd"];
            XDocument xmlParam = DBXmlMethods.getXML(usuario);
            DataSet dsResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesUsuario.SetUsuario, usuario.Transaccion, xmlParam.ToString());
            return Ok(JsonConvert.SerializeObject(dsResultado, Newtonsoft.Json.Formatting.Indented));
        }
    }
}
