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

        [HttpGet]
        public async Task<ActionResult> GetUsuarios()
        {
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["default_bd"];
            DataSet dsResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesUsuario.GetUsuario, "CONSULTA_USUARIO_TODOS");
            return Ok(JsonConvert.SerializeObject(dsResultado.Tables[0], Newtonsoft.Json.Formatting.Indented));
        }

        /*
        [HttpGet]
        public async Task<ActionResult<Usuario>> GetUsuarioId(string email)
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
        
        [HttpDelete("deleteuser/{id}")]
        public async Task<ActionResult<Usuario>> DeleteUsuario(int id)
        {
            Usuario usuario = new Usuario();
            usuario.Id = id;
            var cadenaConexion = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["default_bd"];
            XDocument xmlParam = DBXmlMethods.getXML(usuario);
            DataSet dsResultado = await DBXmlMethods.ejecutaBase(cadenaConexion, SPNamesUsuario.SetUsuario, "DELETE", xmlParam.ToString());
            return Ok(JsonConvert.SerializeObject(dsResultado, Newtonsoft.Json.Formatting.Indented));
        }
        
    }
}
