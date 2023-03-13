using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using CoffeStore.APIs.Models;
using System.Security.Cryptography;

namespace CoffeStore.APIs.Utils;

public class SecurityUtils
{
    public static string GenerateJWTToken(Usuario user, string secretKey)
    {
        if (user == null)
        {
            throw new ArgumentNullException("user");
        }

        var claims = new List<Claim>
        {
            new Claim("id", user.Id.ToString()!),
            new Claim("nombres", user.Nombres!),
            new Claim("apellidos", user.Apellidos!),
            new Claim("rol", user.Rol!),
        };

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey));
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha512Signature);

        var tokenDescriptor = new SecurityTokenDescriptor
        {
            Subject = new ClaimsIdentity(claims),
            Expires = DateTime.UtcNow.AddDays(7),
            SigningCredentials = creds,
        };

        var tokenHandler = new JwtSecurityTokenHandler();

        var token = tokenHandler.CreateToken(tokenDescriptor);
        return tokenHandler.WriteToken(token);
    }

    public static bool ValidateJWTToken(string token, string secretKey)
    {
        var tokenHandler = new JwtSecurityTokenHandler();
        var key = Encoding.UTF8.GetBytes(secretKey);

        tokenHandler.ValidateToken(token, new TokenValidationParameters
        {
            ValidateIssuerSigningKey = true,
            IssuerSigningKey = new SymmetricSecurityKey(key),
            ValidateIssuer = false,
            ValidateAudience = false,
            ValidateLifetime = true,
            ClockSkew = TimeSpan.Zero
        }, out SecurityToken validatedToken);

        return validatedToken != null;
    }

    public static Usuario GetUserFromJWTToken(string tokenStr, string secretKey)
    {
        var tokenHandler = new JwtSecurityTokenHandler();
        var key = Encoding.UTF8.GetBytes(secretKey);
        var token = tokenHandler.ReadJwtToken(tokenStr);
        var payload = token.Payload;

        var usuario = new Usuario
        {
            Id = int.Parse(payload["id"].ToString()!),
            Nombres = payload["nombres"]?.ToString(),
            Apellidos = payload["apellidos"]?.ToString(),
            Rol = payload["rol"]?.ToString(),
        };

        return usuario;
    }

    public static string HashPassword(string passwordToEncrypt)
    {
        byte[] salt;
        byte[] buffer2;
        if (passwordToEncrypt == null)
        {
            throw new ArgumentNullException("password");
        }
        using (Rfc2898DeriveBytes bytes = new Rfc2898DeriveBytes(passwordToEncrypt, 0x10, 0x3e8))
        {
            salt = bytes.Salt;
            buffer2 = bytes.GetBytes(0x20);
        }
        byte[] dst = new byte[0x31];
        Buffer.BlockCopy(salt, 0, dst, 1, 0x10);
        Buffer.BlockCopy(buffer2, 0, dst, 0x11, 0x20);
        return Convert.ToBase64String(dst);
    }

    public static bool VerifyHashedPassword(string hashedPassword, string password)
    {
        byte[] buffer4;
        if (hashedPassword == null)
        {
            return false;
        }
        if (password == null)
        {
            throw new ArgumentNullException("password");
        }
        byte[] src = Convert.FromBase64String(hashedPassword);
        if ((src.Length != 0x31) || (src[0] != 0))
        {
            return false;
        }
        byte[] dst = new byte[0x10];
        Buffer.BlockCopy(src, 1, dst, 0, 0x10);
        byte[] buffer3 = new byte[0x20];
        Buffer.BlockCopy(src, 0x11, buffer3, 0, 0x20);
        using (Rfc2898DeriveBytes bytes = new Rfc2898DeriveBytes(password, dst, 0x3e8))
        {
            buffer4 = bytes.GetBytes(0x20);
        }
        return ByteArraysEqual(buffer3, buffer4);
    }

    private static bool ByteArraysEqual(byte[] b1, byte[] b2)
    {
        if (b1 == b2) return true;
        if (b1 == null || b2 == null) return false;
        if (b1.Length != b2.Length) return false;
        for (int i = 0; i < b1.Length; i++)
        {
            if (b1[i] != b2[i]) return false;
        }
        return true;
    }
}