package com.tellmestory.application.ports.out;

import com.tellmestory.domain.comment.Comment;
import com.tellmestory.domain.comment.CommentId;
import java.util.List;
import java.util.Optional;

public interface CommentRepository {
    Comment save(Comment comment);
    Optional<Comment> findById(CommentId id);
    List<Comment> findAll();
    void deleteById(CommentId id);
}