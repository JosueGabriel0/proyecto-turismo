package pe.edu.upeu.turismospringboot.util;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.stereotype.Component;
import java.util.Date;

@Component
public class JwtTokenUtil {

    private final String secretKey = "yourSecretKey";  // Esta clave debe mantenerse en secreto

    // Método para generar el token JWT
    public String generateToken(String username) {
        return Jwts.builder()
                .setSubject(username)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 10)) // 10 horas
                .signWith(SignatureAlgorithm.HS512, secretKey)
                .compact();
    }

    // Método para extraer el usuario (subject) del token
    public String getUsernameFromToken(String token) {
        return Jwts.parser()
                .setSigningKey(secretKey)
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }

    // Método para verificar si el token ha expirado
    public boolean isTokenExpired(String token) {
        return getExpirationDateFromToken(token).before(new Date());
    }

    // Método para obtener la fecha de expiración del token
    public Date getExpirationDateFromToken(String token) {
        return Jwts.parser()
                .setSigningKey(secretKey)
                .parseClaimsJws(token)
                .getBody()
                .getExpiration();
    }

    // Método para validar el token
    public boolean validateToken(String token, String username) {
        return (username.equals(getUsernameFromToken(token)) && !isTokenExpired(token));
    }
}
