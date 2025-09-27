package com.tellmestory.application.ports.in;

import com.tellmestory.domain.comment.Comment;

public interface CreateCommentUseCase {
    Comment createComment(CreateCommentCommand command);
}