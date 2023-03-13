namespace CoffeStore.APIs.Data.DTO;

public class AuthResponse
{
    public AuthResponse(string accessToken, int userID, string userEmail, string userRole)
    {
        this.AccessToken = accessToken;
        this.UserID = userID;
        this.UserEmail = userEmail;
        this.UserRole = userRole;
    }

    public string AccessToken { get; set; }
    public int UserID { get; set; }
    public string UserEmail { get; set; }
    public string UserRole { get; set; }
}