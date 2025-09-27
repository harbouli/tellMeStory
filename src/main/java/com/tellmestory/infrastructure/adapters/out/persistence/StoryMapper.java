package com.tellmestory.infrastructure.adapters.out.persistence;

import com.tellmestory.domain.story.Story;
import com.tellmestory.domain.story.StoryId;
import com.tellmestory.domain.user.UserId;
import org.springframework.stereotype.Component;

@Component
public class StoryMapper {
    
    public StoryEntity toEntity(Story story) {
        return new StoryEntity(
                story.getId().getValue(),
                story.getTitle(),
                story.getContent(),
                story.getAuthorId().getValue(),
                story.getCreatedAt(),
                story.getUpdatedAt()
        );
    }

    public Story toDomain(StoryEntity entity) {
        return new Story(
                new StoryId(entity.getId()),
                entity.getTitle(),
                entity.getContent(),
                new UserId(entity.getAuthorId()),
                entity.getCreatedAt(),
                entity.getUpdatedAt()
        );
    }
}