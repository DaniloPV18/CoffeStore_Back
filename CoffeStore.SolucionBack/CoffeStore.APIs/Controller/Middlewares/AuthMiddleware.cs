using CoffeStore.APIs.Utils;

namespace CoffeStore.APIs.Controller.Middlewares;

public class AuthMiddleware : IMiddleware
{
    private string secretKey;

    private string[] routes = {
        "/api/authentication/refresh-token"
    };
    
    public AuthMiddleware()
    {
        this.secretKey = new ConfigurationBuilder()
            .AddJsonFile("appsettings.json")
            .Build()
            .GetSection("JsonWebToken")["secret_key"];
    }

    public async Task InvokeAsync(HttpContext context, RequestDelegate next)
    {
        if (validateIfRouteIsProtected(routes, context.Request.Path.ToString()))
        {
            var token = context.Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
            try
            {
                SecurityUtils.ValidateJWTToken(token, this.secretKey);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                context.Response.StatusCode = 401;
                return;
            }
        }

        await next(context);
    }

    private bool validateIfRouteIsProtected(string[] routes, string route)
    {
        foreach (string r in routes)
        {
            if (route.Contains(r))
            {
                return true;
            }
        }
        return false;
    }
}