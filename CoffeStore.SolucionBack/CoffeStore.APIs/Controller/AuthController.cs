using CoffeStore.APIs.Data.DTO;
using CoffeStore.APIs.Exceptions;
using CoffeStore.APIs.Models;
using CoffeStore.APIs.Services;
using Microsoft.AspNetCore.Mvc;

namespace CoffeStore.APIs.Controller;

[Route("api/authentication")]
[ApiController]
public class AuthController : ControllerBase
{

    private AuthService authService;
    private readonly IHttpContextAccessor _httpContextAccessor;

    public AuthController(IHttpContextAccessor httpContextAccessor)
    {
        this.authService = new AuthService();
        _httpContextAccessor = httpContextAccessor;
    }

    [Route("login")]
    [HttpPost]
    public async Task<ActionResult<AuthResponse>> Login([FromBody] Usuario user)
    {
        try
        {
            return Ok(await this.authService.Login(user));
        }
        catch (BadRequestException e)
        {
            return StatusCode(StatusCodes.Status400BadRequest, $"Error: {e.Message}");
        }
        catch (UserNotFoundException e)
        {
            return StatusCode(StatusCodes.Status404NotFound, $"Error: {e.Message}");
        }
        catch (UnauthorizedException e)
        {
            return StatusCode(StatusCodes.Status401Unauthorized, $"Error: {e.Message}");
        }
        catch (Exception e)
        {
            return StatusCode(StatusCodes.Status500InternalServerError, $"Error: {e.Message}");
        }
    }

    [Route("register")]
    [HttpPost]
    public async Task<ActionResult<AuthResponse>> Register([FromBody] Usuario user)
    {
        try
        {
            return Ok(await this.authService.Register(user));
        }
        catch (BadRequestException e)
        {
            return StatusCode(StatusCodes.Status400BadRequest, $"Error: {e.Message}");
        }
        catch (UnauthorizedException e)
        {
            return StatusCode(StatusCodes.Status401Unauthorized, $"Error: {e.Message}");
        }
        catch (Exception e)
        {
            return StatusCode(StatusCodes.Status500InternalServerError, $"Error: {e.Message}");
        }
    }

    [Route("refresh-token")]
    [HttpPost]
    public ActionResult<AuthResponse> RefreshToken()
    {
        try
        {
            var context = _httpContextAccessor.HttpContext;
            var token = context!.Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
            
            return Ok(this.authService.RefreshToken(token));
        }
        catch (UnauthorizedException e)
        {
            return StatusCode(StatusCodes.Status401Unauthorized, $"Error: {e.Message}");
        }
    }

}