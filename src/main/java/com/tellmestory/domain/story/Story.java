package com.tellmestory.domain.story;

import com.tellmestory.domain.user.UserId;
import java.time.LocalDateTime;
import java.util.Objects;

public class Story {
    private final StoryId id;
    private final String title;
    private final String content;
    private final UserId authorId;
    private final LocalDateTime createdAt;
    private final LocalDateTime updatedAt;

    public Story(StoryId id, String title, String content, UserId authorId,
                 LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = Objects.requireNonNull(id, "Story ID cannot be null");
        this.title = Objects.requireNonNull(title, "Title cannot be null");
        this.content = Objects.requireNonNull(content, "Content cannot be null");
        this.authorId = Objects.requireNonNull(authorId, "Author ID cannot be null");
        this.createdAt = Objects.requireNonNull(createdAt, "Created at cannot be null");
        this.updatedAt = Objects.requireNonNull(updatedAt, "Updated at cannot be null");
        
        validateTitle(title);
        validateContent(content);
    }

    private void validateTitle(String title) {
        if (title.trim().isEmpty() || title.length() > 200) {
            throw new IllegalArgumentException("Title must not be empty and must be at most 200 characters");
        }
    }

    private void validateContent(String content) {
        if (content.trim().isEmpty() || content.length() > 10000) {
            throw new IllegalArgumentException("Content must not be empty and must be at most 10000 characters");
        }
    }

    public StoryId getId() { return id; }
    public String getTitle() { return title; }
    public String getContent() { return content; }
    public UserId getAuthorId() { return authorId; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Story story = (Story) o;
        return Objects.equals(id, story.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}