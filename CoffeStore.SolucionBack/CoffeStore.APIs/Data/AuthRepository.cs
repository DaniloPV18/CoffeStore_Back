using System.Data;
using System.Xml.Linq;
using CoffeStore.APIs.Data.Interfaces;
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

    public async Task<Usuario> Login(string email, string password)
    {
        var user = new Usuario();
        user.Email = email;
        XDocument xmlParam = DBXmlMethods.getXML(user);

        DataSet dataSetRetrieved = await DBXmlMethods
            .ejecutaBase(this.conexionString, SPNamesProducto.Authentication, "LOGIN", xmlParam.ToString());

        var userRetrieved = dataSetRetrieved.Tables[0].Rows[0];
        user.Nombres = userRetrieved["Nombres"].ToString();
        user.Apellidos = userRetrieved["Apellidos"].ToString();
        user.Id = Int32.Parse(userRetrieved["Id"].ToString());
        user.Rol = userRetrieved["Rol"].ToString();
        
        return user;
    }

    public Task<Usuario> Register(Usuario user, string password)
    {
        throw new NotImplementedException();
    }

    public Task<bool> UserExists(string email)
    {
        throw new NotImplementedException();
    }
}
