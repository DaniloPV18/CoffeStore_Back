using CoffeStore.APIs.Utils;

namespace CoffeStore.APIs.Controller.Middlewares;

public class AuthMiddleware : IMiddleware
{

    private string[] routes = {
        "/api/Categoria",
        "/api/Producto"
    };

    public async Task InvokeAsync(HttpContext context, RequestDelegate next)
    {
        if (validateIfRouteIsProtected(routes, context.Request.Path.ToString()))
        {
            var token = context.Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
            Console.WriteLine(token);
            try
            {
                SecurityUtils.ValidateJWTToken(token, "this is my custom Secret key for authentication");
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                context.Response.StatusCode = 401;
                return;
            }
            Console.WriteLine("Entré al middleware!");
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