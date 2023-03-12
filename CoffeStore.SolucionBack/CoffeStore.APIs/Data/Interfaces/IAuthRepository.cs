using CoffeStore.APIs.Models;

namespace CoffeStore.APIs.Data.Interfaces 
{
    public interface IAuthRepository
    {
        Task<Usuario> Register(Usuario user);
        Task<Usuario> Login(string email);
    }
}