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
        return await this.authService.Login(user);
    }

    [Route("register")]
    [HttpPost]
    public async Task<ActionResult<AuthResponse>> Register([FromBody] Usuario user)
    {
        return await this.authService.Register(user);
    }

}