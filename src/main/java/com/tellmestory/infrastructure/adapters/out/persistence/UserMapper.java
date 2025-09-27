package com.tellmestory.infrastructure.adapters.out.persistence;

import com.tellmestory.domain.user.User;
import com.tellmestory.domain.user.UserId;
import org.springframework.stereotype.Component;

@Component
public class UserMapper {
    
    public UserEntity toEntity(User user) {
        return new UserEntity(
                user.getId().getValue(),
                user.getUsername(),
                user.getEmail(),
                user.getPasswordHash(),
                user.getCreatedAt(),
                user.getUpdatedAt()
        );
    }

    public User toDomain(UserEntity entity) {
        return new User(
                new UserId(entity.getId()),
                entity.getUsername(),
                entity.getEmail(),
                entity.getPasswordHash(),
                entity.getCreatedAt(),
                entity.getUpdatedAt()
        );
    }
}