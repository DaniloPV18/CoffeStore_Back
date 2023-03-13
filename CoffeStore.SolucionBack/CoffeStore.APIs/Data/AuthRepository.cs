using System.Data;
using System.Xml.Linq;
using CoffeStore.APIs.Data.Interfaces;
using CoffeStore.APIs.Exceptions;
using CoffeStore.APIs.Models;
using CoffeStore.APIs.Shared;

namespace CoffeStore.APIs.Data;

public class AuthRepository : IAuthRepository
{
    private string conexionString;

    public AuthRepository()
    {
        this.conexionString = new ConfigurationBuilder()
            .AddJsonFile("appsettings.json")
            .Build()
            .GetSection("ConnectionStrings")["conexion_bd"];
    }

    public async Task<Usuario> Login(string email)
    {
        var user = new Usuario();
        user.Email = email;
        XDocument xmlParam = DBXmlMethods.getXML(user);

        DataSet dataSetRetrieved = await DBXmlMethods
            .ejecutaBase(this.conexionString, SPNamesProducto.Authentication, "LOGIN", xmlParam.ToString());

        if (dataSetRetrieved.Tables[0].Rows.Count == 0)
        {
            throw new UserNotFoundException("No hay registros");
        }
        else
        {
            var userRetrieved = dataSetRetrieved.Tables[0].Rows[0];
            user.Nombres = userRetrieved["Nombres"].ToString();
            user.Apellidos = userRetrieved["Apellidos"].ToString();
            user.Contrasena = userRetrieved["Contrasena"].ToString();
            user.Id = Int32.Parse(userRetrieved["Id"].ToString()!);
            user.Rol = userRetrieved["Rol"].ToString();
            return user;
        }
    }

    public async Task<Usuario> Register(Usuario user)
    {
        XDocument xmlParam = DBXmlMethods.getXML(user);
        DataSet dataSetRetrieved = await DBXmlMethods
            .ejecutaBase(this.conexionString, SPNamesProducto.Authentication, "REGISTER", xmlParam.ToString());

        var userRetrieved = dataSetRetrieved.Tables[0].Rows[0];
        user.Nombres = userRetrieved["Nombres"].ToString();
        user.Apellidos = userRetrieved["Apellidos"].ToString();
        user.Id = Int32.Parse(userRetrieved["Id"].ToString()!);
        user.Rol = userRetrieved["Rol"].ToString();

        return user;
    }
}
