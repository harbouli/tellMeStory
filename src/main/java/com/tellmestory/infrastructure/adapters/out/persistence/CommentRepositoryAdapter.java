package com.tellmestory.infrastructure.adapters.out.persistence;

import com.tellmestory.application.ports.out.CommentRepository;
import com.tellmestory.domain.comment.Comment;
import com.tellmestory.domain.comment.CommentId;
import org.springframework.stereotype.Component;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Component
public class CommentRepositoryAdapter implements CommentRepository {
    private final CommentJpaRepository commentJpaRepository;
    private final CommentMapper commentMapper;

    public CommentRepositoryAdapter(CommentJpaRepository commentJpaRepository, 
                                 CommentMapper commentMapper) {
        this.commentJpaRepository = commentJpaRepository;
        this.commentMapper = commentMapper;
    }

    @Override
    public Comment save(Comment comment) {
        CommentEntity entity = commentMapper.toEntity(comment);
        CommentEntity savedEntity = commentJpaRepository.save(entity);
        return commentMapper.toDomain(savedEntity);
    }

    @Override
    public Optional<Comment> findById(CommentId id) {
        return commentJpaRepository.findById(id.getValue())
                .map(commentMapper::toDomain);
    }

    @Override
    public List<Comment> findAll() {
        return commentJpaRepository.findAll()
                .stream()
                .map(commentMapper::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public void deleteById(CommentId id) {
        commentJpaRepository.deleteById(id.getValue());
    }
}