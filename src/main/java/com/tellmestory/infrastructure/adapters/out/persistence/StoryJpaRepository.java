package com.tellmestory.infrastructure.adapters.out.persistence;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.UUID;

@Repository
public interface StoryJpaRepository extends JpaRepository<StoryEntity, UUID> {
    List<StoryEntity> findByAuthorId(UUID authorId);
}