using System.Data.SqlTypes;

namespace CoffeStore.APIs.Models
{
    public class User
    {
        public int? Id { set; get; }
        public string? IdentificationNumber { set; get; }
        public string? Names { set; get; }
        public string? Surnames { set; get; }
        public SqlDateTime? DateOfBirth { set; get; }
        public string? Email { set; get; }
        public string? Password { set; get; }
        public string? Role { set; get; }
        public string? Status { set; get; }
        public SqlDateTime? CreatedAt { set; get; }
        public SqlDateTime? UpdatedAt { set; get; }
    }
}