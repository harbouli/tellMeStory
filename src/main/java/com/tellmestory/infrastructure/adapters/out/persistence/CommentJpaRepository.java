package com.tellmestory.infrastructure.adapters.out.persistence;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.UUID;

@Repository
public interface CommentJpaRepository extends JpaRepository<CommentEntity, UUID> {
}