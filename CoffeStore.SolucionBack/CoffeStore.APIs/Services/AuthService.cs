using CoffeStore.APIs.Data;
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

    public async Task<bool> Login(Usuario user)
    {
        try
        {
            Usuario userRtrv = await this.authRepository.Login(user.Email!);
            if (SecurityUtils.VerifyHashedPassword(userRtrv.Contrasena!, user.Contrasena!))
            {
                Console.WriteLine("La contraseña es válida.");
                return true;
            }
            else
            {
                Console.WriteLine("La contraseña es incorrecta.");
                return false;
            }
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            return false;
        }
    }

}