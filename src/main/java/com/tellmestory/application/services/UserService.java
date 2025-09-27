package com.tellmestory.application.services;

import com.tellmestory.application.ports.in.CreateUserCommand;
import com.tellmestory.application.ports.in.CreateUserUseCase;
import com.tellmestory.application.ports.out.PasswordEncoder;
import com.tellmestory.application.ports.out.UserRepository;
import com.tellmestory.domain.user.User;
import com.tellmestory.domain.user.UserId;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;

@Service
public class UserService implements CreateUserUseCase {
    
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public User createUser(CreateUserCommand command) {
        if (userRepository.existsByUsername(command.username())) {
            throw new IllegalArgumentException("Username already exists");
        }
        
        if (userRepository.existsByEmail(command.email())) {
            throw new IllegalArgumentException("Email already exists");
        }

        String encodedPassword = passwordEncoder.encode(command.password());
        LocalDateTime now = LocalDateTime.now();
        
        User user = new User(
                UserId.generate(),
                command.username(),
                command.email(),
                encodedPassword,
                now,
                now
        );

        return userRepository.save(user);
    }
}