package com.tellmestory.application.services;

import com.tellmestory.application.ports.in.AuthenticationUseCase;
import com.tellmestory.application.ports.in.LoginCommand;
import com.tellmestory.application.ports.out.PasswordEncoder;
import com.tellmestory.application.ports.out.TokenGenerator;
import com.tellmestory.application.ports.out.UserRepository;
import com.tellmestory.domain.auth.AuthToken;
import com.tellmestory.domain.user.User;
import org.springframework.stereotype.Service;

@Service
public class AuthenticationService implements AuthenticationUseCase {
    
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final TokenGenerator tokenGenerator;

    public AuthenticationService(UserRepository userRepository, 
                                PasswordEncoder passwordEncoder,
                                TokenGenerator tokenGenerator) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.tokenGenerator = tokenGenerator;
    }

    @Override
    public AuthToken login(LoginCommand command) {
        User user = userRepository.findByUsername(command.username())
                .orElseThrow(() -> new IllegalArgumentException("Invalid username or password"));

        if (!passwordEncoder.matches(command.password(), user.getPasswordHash())) {
            throw new IllegalArgumentException("Invalid username or password");
        }

        return tokenGenerator.generateToken(user);
    }

    @Override
    public void logout(String token) {
    }

    @Override
    public boolean validateToken(String token) {
        return tokenGenerator.validateToken(token);
    }
}