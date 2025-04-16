package pe.edu.upeu.turismospringboot.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import pe.edu.upeu.turismospringboot.model.entity.Usuario;

import java.util.Collection;
import java.util.List;

public class CustomUserDetails implements UserDetails {

    private final Usuario usuario;

    public CustomUserDetails(Usuario usuario) {
        this.usuario = usuario;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // Aquí puedes agregar los roles del usuario.
        // Supongamos que el usuario tiene un rol.
        return List.of(() -> usuario.getRol().getNombre());
    }

    @Override
    public String getPassword() {
        return usuario.getPassword();  // Contraseña del usuario
    }

    @Override
    public String getUsername() {
        return usuario.getUsername();  // O usa otro campo como el nombre de usuario
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;  // Puedes implementar la lógica de expiración de la cuenta si es necesario
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;  // Implementar la lógica de si la cuenta está bloqueada o no
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;  // Implementar la lógica de si las credenciales del usuario han expirado
    }

    @Override
    public boolean isEnabled() {
        return true;  // Implementar la lógica de si la cuenta del usuario está habilitada
    }

    // Método adicional para acceder al usuario completo
    public Usuario getUsuario() {
        return usuario;
    }
}