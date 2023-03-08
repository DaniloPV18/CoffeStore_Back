using CoffeStore.APIs.Data.Interfaces;
using CoffeStore.APIs.Models;

namespace CoffeStore.APIs.Data
{
    public class AuthRepository : IAuthRepository
    {
        public Task<Usuario> Login(string email, string password)
        {
            throw new NotImplementedException();
        }

        public Task<Usuario> Register(Usuario user, string password)
        {
            throw new NotImplementedException();
        }

        public Task<bool> UserExists(string email)
        {
            throw new NotImplementedException();
        }
    }
}