package com.tellmestory.infrastructure.adapters.in.web;

import com.tellmestory.application.ports.in.AuthenticationUseCase;
import com.tellmestory.application.ports.in.CreateUserUseCase;
import com.tellmestory.application.ports.in.CreateUserCommand;
import com.tellmestory.application.ports.in.LoginCommand;
import com.tellmestory.domain.auth.AuthToken;
import com.tellmestory.domain.user.User;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private final AuthenticationUseCase authenticationUseCase;
    private final CreateUserUseCase createUserUseCase;

    public AuthController(AuthenticationUseCase authenticationUseCase, CreateUserUseCase createUserUseCase) {
        this.authenticationUseCase = authenticationUseCase;
        this.createUserUseCase = createUserUseCase;
    }

    @PostMapping("/register")
    public ResponseEntity<UserResponse> register(@Valid @RequestBody CreateUserCommand command) {
        User user = createUserUseCase.createUser(command);
        return ResponseEntity.ok(new UserResponse(
                user.getId().toString(),
                user.getUsername(),
                user.getEmail(),
                user.getCreatedAt()
        ));
    }

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@Valid @RequestBody LoginCommand command) {
        AuthToken token = authenticationUseCase.login(command);
        return ResponseEntity.ok(new AuthResponse(
                token.getToken(),
                token.getTokenType(),
                token.getExpiresAt()
        ));
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@RequestHeader("Authorization") String authHeader) {
        String token = authHeader.replace("Bearer ", "");
        authenticationUseCase.logout(token);
        return ResponseEntity.ok().build();
    }
}