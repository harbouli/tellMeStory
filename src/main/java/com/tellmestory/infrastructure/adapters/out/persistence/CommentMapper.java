package com.tellmestory.infrastructure.adapters.out.persistence;

import com.tellmestory.domain.comment.Comment;
import com.tellmestory.domain.comment.CommentId;
import org.springframework.stereotype.Component;

@Component
public class CommentMapper {
    
    public CommentEntity toEntity(Comment comment) {
        return new CommentEntity(
                comment.getId().getValue(),
                comment.getName(),
                comment.getDescription(),
                comment.getCreatedAt(),
                comment.getUpdatedAt()
        );
    }

    public Comment toDomain(CommentEntity entity) {
        return new Comment(
                new CommentId(entity.getId()),
                entity.getName(),
                entity.getDescription(),
                entity.getCreatedAt(),
                entity.getUpdatedAt()
        );
    }
}