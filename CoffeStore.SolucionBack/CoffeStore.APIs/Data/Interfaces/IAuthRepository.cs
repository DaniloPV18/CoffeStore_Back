using CoffeStore.APIs.Models;

namespace CoffeStore.APIs.Data.Interfaces 
{
    public interface IAuthRepository
    {
        Task<Usuario> Register(Usuario user, string password);
        Task<Usuario> Login(string email);
        Task<bool> UserExists(string email);
    }
}