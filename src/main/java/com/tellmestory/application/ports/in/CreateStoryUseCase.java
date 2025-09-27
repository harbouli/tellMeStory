package com.tellmestory.application.ports.in;

import com.tellmestory.domain.story.Story;

public interface CreateStoryUseCase {
    Story createStory(CreateStoryCommand command);
}