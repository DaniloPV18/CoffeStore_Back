using CoffeStore.APIs.Data;
using CoffeStore.APIs.Models;
using Microsoft.AspNetCore.Mvc;

namespace CoffeStore.APIs.Controller;

[Route("api/authentication")]
[ApiController]
public class AuthController : ControllerBase
{

    private AuthRepository authRepository;

    public AuthController() {
        this.authRepository = new AuthRepository();
    }

    [Route("login")]
    [HttpPost]
    public async Task<ActionResult<Usuario>> Login()
    {
        Usuario userRetrieved = await this.authRepository.Login("Keneth@example.com", "hola");
        return Ok(userRetrieved);
    }

}