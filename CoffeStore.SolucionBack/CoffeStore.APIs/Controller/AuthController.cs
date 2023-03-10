using CoffeStore.APIs.Data.DTO;
using CoffeStore.APIs.Models;
using CoffeStore.APIs.Services;
using Microsoft.AspNetCore.Mvc;

namespace CoffeStore.APIs.Controller;

[Route("api/authentication")]
[ApiController]
public class AuthController : ControllerBase
{

    private AuthService authService;

    public AuthController()
    {
        this.authService = new AuthService();
    }

    [Route("login")]
    [HttpPost]
    public async Task<ActionResult<AuthResponse>> Login([FromBody] Usuario user)
    {
        if (await this.authService.Login(user))
        {
            AuthResponse resp = new AuthResponse();
            resp.StatusCode = 200;
            resp.AccessToken = ""; // todo: enviar el token como respuesta
            return resp;
        }
        else
        {
            AuthResponse resp = new AuthResponse();
            resp.StatusCode = 500; // todo: retornar el código adecuado
            return resp;
        }
    }

}