package com.tellmestory.infrastructure.adapters.out.persistence;

import com.tellmestory.application.ports.out.StoryRepository;
import com.tellmestory.domain.story.Story;
import com.tellmestory.domain.story.StoryId;
import com.tellmestory.domain.user.UserId;
import org.springframework.stereotype.Component;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Component
public class StoryRepositoryAdapter implements StoryRepository {
    private final StoryJpaRepository storyJpaRepository;
    private final StoryMapper storyMapper;

    public StoryRepositoryAdapter(StoryJpaRepository storyJpaRepository, StoryMapper storyMapper) {
        this.storyJpaRepository = storyJpaRepository;
        this.storyMapper = storyMapper;
    }

    @Override
    public Story save(Story story) {
        StoryEntity entity = storyMapper.toEntity(story);
        StoryEntity savedEntity = storyJpaRepository.save(entity);
        return storyMapper.toDomain(savedEntity);
    }

    @Override
    public Optional<Story> findById(StoryId id) {
        return storyJpaRepository.findById(id.getValue())
                .map(storyMapper::toDomain);
    }

    @Override
    public List<Story> findByAuthorId(UserId authorId) {
        return storyJpaRepository.findByAuthorId(authorId.getValue())
                .stream()
                .map(storyMapper::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<Story> findAll() {
        return storyJpaRepository.findAll()
                .stream()
                .map(storyMapper::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public void deleteById(StoryId id) {
        storyJpaRepository.deleteById(id.getValue());
    }
}