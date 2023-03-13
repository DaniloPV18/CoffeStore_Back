using CoffeStore.APIs.Data;
using CoffeStore.APIs.Data.DTO;
using CoffeStore.APIs.Exceptions;
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
            if (user.Email == null || "".Equals(user.Email))
            {
                throw new BadRequestException();
            }

            Usuario userRtrv = await this.authRepository.Login(user.Email!);
            if (SecurityUtils.VerifyHashedPassword(userRtrv.Contrasena!, user.Contrasena!))
            {
                string token = SecurityUtils.GenerateJWTToken(userRtrv, "this is my custom Secret key for authentication");
                AuthResponse resp = new AuthResponse(
                    token, (int)userRtrv.Id!, userRtrv.Email!, userRtrv.Rol!);
                return resp;
            }
            else
            {
                throw new UnauthorizedException("Credenciales no validas");
            }
        }
        catch (UserNotFoundException e)
        {
            throw new UserNotFoundException("No se ha encontrado el usuario: ", e);
        }
        catch (Exception e)
        {
            throw new UnauthorizedException("Credenciales no validas: ", e);
        }
    }

    public async Task<AuthResponse> Register(Usuario user)
    {
        try
        {
            if (validateUserFields(user))
            {
                throw new BadRequestException();
            }

            string hashedPass = SecurityUtils.HashPassword(user.Contrasena!);
            user.Contrasena = hashedPass;

            Usuario userRtrv = await this.authRepository.Register(user);
            string token = SecurityUtils.GenerateJWTToken(userRtrv, "this is my custom Secret key for authentication");
            AuthResponse resp = new AuthResponse(
                    token, (int)userRtrv.Id!, userRtrv.Email!, userRtrv.Rol!);
            return resp;
        }
        catch (Exception e)
        {
            throw new UnauthorizedException("Credenciales no validas: ", e);
        }
    }

    private bool validateUserFields(Usuario user)
    {
        return user.Nombres == null || "".Equals(user.Nombres) ||
        user.Apellidos == null || "".Equals(user.Apellidos) ||
        user.Email == null || "".Equals(user.Email) ||
        user.Contrasena == null || "".Equals(user.Contrasena) ||
        user.Rol == null || "".Equals(user.Rol);
    }

}