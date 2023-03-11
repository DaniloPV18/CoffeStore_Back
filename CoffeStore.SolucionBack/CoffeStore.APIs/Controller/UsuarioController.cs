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
        public async Task<ActionResult<Usuario>> GetUsuarios()
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["default_bd"];
            DataSet dsResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesUsuario.GetUsuario, "CONSULTA_USUARIO_TODOS");
            return Ok(JsonConvert.SerializeObject(dsResultado, Newtonsoft.Json.Formatting.Indented));
        }

        /*
        [Route("action")]
        [HttpGet]
        public async Task<ActionResult<Usuario>> GetUsuario(string email)
        {
            Usuario usuario = new Usuario();
            usuario.Email = email;
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["default_bd"];
            XDocument xmlParam = DBXmlMethods.getXML(usuario);
            DataSet dsResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesUsuario.GetUsuario, "CONSULTA_USUARIO_CORREO", xmlParam.ToString());
            return Ok(JsonConvert.SerializeObject(dsResultado, Newtonsoft.Json.Formatting.Indented));
        }
        */

        [Route("createuser")]
        [HttpPost]
        public async Task<ActionResult<Usuario>> InsertarUsuario([FromBody] Usuario usuario)
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["default_bd"];
            XDocument xmlParam = DBXmlMethods.getXML(usuario);
            DataSet dsResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesUsuario.SetUsuario, "INSERT", xmlParam.ToString());
            return Ok(JsonConvert.SerializeObject(dsResultado, Newtonsoft.Json.Formatting.Indented));
        }

        [Route("updatedata")]
        [HttpPut]
        public async Task<ActionResult<Usuario>> UpdateUsuario([FromBody] Usuario usuario)
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["default_bd"];
            XDocument xmlParam = DBXmlMethods.getXML(usuario);
            DataSet dsResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesUsuario.SetUsuario, "UPDATE", xmlParam.ToString());
            return Ok(JsonConvert.SerializeObject(dsResultado, Newtonsoft.Json.Formatting.Indented));
        }
        /*
        [Route("deleteuser")]
        [HttpDelete("{cedula}")]
        public async Task<ActionResult<Usuario>> DeleteUsuario(string cedula)
        {
            Usuario usuario = new Usuario();
            usuario.Cedula = cedula;
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["default_bd"];
            XDocument xmlParam = DBXmlMethods.getXML(usuario);
            DataSet dsResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesUsuario.SetUsuario, "DELETE", xmlParam.ToString());
            return Ok(JsonConvert.SerializeObject(dsResultado, Newtonsoft.Json.Formatting.Indented));
        }
        */
    }
}
