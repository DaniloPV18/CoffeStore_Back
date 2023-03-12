namespace CoffeStore.APIs.Data.DTO;

public class AuthResponse
{
    public int StatusCode { get; set; }
    public string? AccessToken { get; set; }
    public int? UserID { get; set; }
    public string? UserEmail { get; set; }
    public string? UserRole { get; set; }
}