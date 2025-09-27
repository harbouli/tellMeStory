package com.tellmestory.application.ports.in;

import com.tellmestory.domain.story.Story;
import java.util.List;

public interface GetStoriesQuery {
    List<Story> getAllStories();
    List<Story> getStoriesByAuthor(String authorId);
}