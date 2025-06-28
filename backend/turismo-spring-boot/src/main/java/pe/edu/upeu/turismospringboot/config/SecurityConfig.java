package pe.edu.upeu.turismospringboot.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import pe.edu.upeu.turismospringboot.filter.JwtAuthenticationFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final JwtAuthenticationFilter jwtAuthenticationFilter;
    private final AuthenticationProvider authProvider;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        return http
                .csrf(csrf -> csrf.disable())
                .cors(Customizer.withDefaults())
                .authorizeHttpRequests(authRequest ->
                        authRequest
                                .requestMatchers(
                                        "/auth/**", "/doc/**", "/v3/api-docs/**",
                                        "/swagger-ui/**", "/swagger-ui.html", "/swagger-resources/**",
                                        "/webjars/**", "/filePerfil/**", "/general/**",
                                        "/ws-chat/**", "/ws-chat", "/topic/**", "/queue/**", "/app/**", "/user/**"
                                ).permitAll()
                                .requestMatchers("/admin/**").hasRole("ADMIN")
                                .requestMatchers("/usuario/**").hasRole("USUARIO")
                                .requestMatchers("/emprendedor/**").hasRole("EMPRENDEDOR")
                                .anyRequest().authenticated()
                )
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authenticationProvider(authProvider)
                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
                .httpBasic(httpBasic -> httpBasic.disable())
                .headers(headers -> headers.disable()) // ✅ Desactiva todos los headers de protección (incluye frameOptions)
                .build();
    }
}