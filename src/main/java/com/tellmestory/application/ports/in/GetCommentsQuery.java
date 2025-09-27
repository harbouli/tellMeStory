package com.tellmestory.application.ports.in;

import com.tellmestory.domain.comment.Comment;
import java.util.List;
import java.util.Optional;

public interface GetCommentsQuery {
    List<Comment> getAllComments();
    Optional<Comment> getCommentById(String id);
}