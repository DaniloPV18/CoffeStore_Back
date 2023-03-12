using CoffeStore.APIs.Data;
using CoffeStore.APIs.Data.DTO;
using CoffeStore.APIs.Models;
using CoffeStore.APIs.Utils;

namespace CoffeStore.APIs.Services;

public class AuthService
{
    private AuthRepository authRepository;

    public AuthService()
    {
        this.authRepository = new AuthRepository();
    }

    public async Task<AuthResponse> Login(Usuario user)
    {
        try
        {
            Usuario userRtrv = await this.authRepository.Login(user.Email!);
            if (SecurityUtils.VerifyHashedPassword(userRtrv.Contrasena!, user.Contrasena!))
            {
                Console.WriteLine("La contraseña es válida.");
                string token = SecurityUtils.GenerateJWTToken(user, "this is my custom Secret key for authentication");
                AuthResponse resp = new AuthResponse();
                resp.StatusCode = 200;
                resp.AccessToken = token;
                return resp;
            }
            else
            {
                Console.WriteLine("La contraseña es incorrecta.");
                AuthResponse resp = new AuthResponse();
                resp.StatusCode = 500;
                return resp;
            }
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            AuthResponse resp = new AuthResponse();
            resp.StatusCode = 500;
            return resp;
        }
    }

    public async Task<AuthResponse> Register(Usuario user)
    {
        try
        {
            // Todo: Validar si correo existe

            // Hash password
            string hashedPass = SecurityUtils.HashPassword(user.Contrasena!);
            user.Contrasena = hashedPass;

            Usuario userRtrv = await this.authRepository.Register(user);
            string token = SecurityUtils.GenerateJWTToken(userRtrv, "this is my custom Secret key for authentication");
            AuthResponse resp = new AuthResponse();
            resp.StatusCode = 200;
            resp.AccessToken = token;
            return resp;
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            AuthResponse resp = new AuthResponse();
            resp.StatusCode = 500;
            return resp;
        }
    }

}