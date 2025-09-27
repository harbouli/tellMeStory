package com.tellmestory.application.ports.out;

import com.tellmestory.domain.story.Story;
import com.tellmestory.domain.story.StoryId;
import com.tellmestory.domain.user.UserId;
import java.util.List;
import java.util.Optional;

public interface StoryRepository {
    Story save(Story story);
    Optional<Story> findById(StoryId id);
    List<Story> findByAuthorId(UserId authorId);
    List<Story> findAll();
    void deleteById(StoryId id);
}