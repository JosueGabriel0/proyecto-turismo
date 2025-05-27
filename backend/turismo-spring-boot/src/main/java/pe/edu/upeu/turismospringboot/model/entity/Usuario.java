package pe.edu.upeu.turismospringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import pe.edu.upeu.turismospringboot.model.enums.EstadoCuenta;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Entity
@Data
public class Usuario implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idUsuario;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    private String password;

    @Enumerated(EnumType.STRING)
    private EstadoCuenta estado;

    @ManyToOne
    @JoinColumn(name = "id_rol", nullable = false)
    @JsonManagedReference
    private Rol rol;

    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "id_persona", unique = true)
    @JsonManagedReference
    private Persona persona;

    @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<BitacoraAcceso> bitacoraAccesoList = new ArrayList<>();

    @OneToMany(mappedBy = "autor", cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<Noticia> noticias = new ArrayList<>();

    @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<Resena> resenas = new ArrayList<>();

    @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<Reserva> reservas = new ArrayList<>();

    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "id_emprendimiento", unique = true, nullable = true)
    @JsonManagedReference
    private Emprendimiento emprendimiento;

    private LocalDateTime fechaCreacionUsuario;
    private LocalDateTime fechaModificacionUsuario;

    @PrePersist
    public void onCreate(){
        fechaCreacionUsuario = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionUsuario = LocalDateTime.now();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(rol.getNombre()));
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
