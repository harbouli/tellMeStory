package com.tellmestory.application.ports.in;

import com.tellmestory.domain.user.User;

public interface CreateUserUseCase {
    User createUser(CreateUserCommand command);
}