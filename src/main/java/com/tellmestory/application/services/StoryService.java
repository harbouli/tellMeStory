package com.tellmestory.application.services;

import com.tellmestory.application.ports.in.CreateStoryCommand;
import com.tellmestory.application.ports.in.CreateStoryUseCase;
import com.tellmestory.application.ports.in.GetStoriesQuery;
import com.tellmestory.application.ports.out.StoryRepository;
import com.tellmestory.domain.story.Story;
import com.tellmestory.domain.story.StoryId;
import com.tellmestory.domain.user.UserId;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class StoryService implements CreateStoryUseCase, GetStoriesQuery {
    
    private final StoryRepository storyRepository;

    public StoryService(StoryRepository storyRepository) {
        this.storyRepository = storyRepository;
    }

    @Override
    public Story createStory(CreateStoryCommand command) {
        LocalDateTime now = LocalDateTime.now();
        
        Story story = new Story(
                StoryId.generate(),
                command.title(),
                command.content(),
                UserId.of(command.authorId()),
                now,
                now
        );

        return storyRepository.save(story);
    }

    @Override
    public List<Story> getAllStories() {
        return storyRepository.findAll();
    }

    @Override
    public List<Story> getStoriesByAuthor(String authorId) {
        return storyRepository.findByAuthorId(UserId.of(authorId));
    }
}