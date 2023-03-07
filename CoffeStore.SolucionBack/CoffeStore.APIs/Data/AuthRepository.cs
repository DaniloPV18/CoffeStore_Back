using CoffeStore.APIs.Data.Interfaces;
using CoffeStore.APIs.Models;

namespace CoffeStore.APIs.Data
{
    public class AuthRepository : IAuthRepository
    {
        public Task<User> Login(string email, string password)
        {
            throw new NotImplementedException();
        }

        public Task<User> Register(User user, string password)
        {
            throw new NotImplementedException();
        }

        public Task<bool> UserExists(string email)
        {
            throw new NotImplementedException();
        }
    }
}