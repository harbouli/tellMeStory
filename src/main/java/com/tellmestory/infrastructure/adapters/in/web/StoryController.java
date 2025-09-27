package com.tellmestory.infrastructure.adapters.in.web;

import com.tellmestory.application.ports.in.CreateStoryUseCase;
import com.tellmestory.application.ports.in.CreateStoryCommand;
import com.tellmestory.application.ports.in.GetStoriesQuery;
import com.tellmestory.domain.story.Story;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/stories")
public class StoryController {
    private final CreateStoryUseCase createStoryUseCase;
    private final GetStoriesQuery getStoriesQuery;

    public StoryController(CreateStoryUseCase createStoryUseCase, GetStoriesQuery getStoriesQuery) {
        this.createStoryUseCase = createStoryUseCase;
        this.getStoriesQuery = getStoriesQuery;
    }

    @PostMapping
    public ResponseEntity<StoryResponse> createStory(@Valid @RequestBody CreateStoryCommand command) {
        Story story = createStoryUseCase.createStory(command);
        return ResponseEntity.ok(new StoryResponse(
                story.getId().toString(),
                story.getTitle(),
                story.getContent(),
                story.getAuthorId().toString(),
                story.getCreatedAt(),
                story.getUpdatedAt()
        ));
    }

    @GetMapping
    public ResponseEntity<List<StoryResponse>> getAllStories() {
        List<Story> stories = getStoriesQuery.getAllStories();
        List<StoryResponse> responses = stories.stream()
                .map(story -> new StoryResponse(
                        story.getId().toString(),
                        story.getTitle(),
                        story.getContent(),
                        story.getAuthorId().toString(),
                        story.getCreatedAt(),
                        story.getUpdatedAt()
                ))
                .collect(Collectors.toList());
        return ResponseEntity.ok(responses);
    }

    @GetMapping("/author/{authorId}")
    public ResponseEntity<List<StoryResponse>> getStoriesByAuthor(@PathVariable String authorId) {
        List<Story> stories = getStoriesQuery.getStoriesByAuthor(authorId);
        List<StoryResponse> responses = stories.stream()
                .map(story -> new StoryResponse(
                        story.getId().toString(),
                        story.getTitle(),
                        story.getContent(),
                        story.getAuthorId().toString(),
                        story.getCreatedAt(),
                        story.getUpdatedAt()
                ))
                .collect(Collectors.toList());
        return ResponseEntity.ok(responses);
    }
}