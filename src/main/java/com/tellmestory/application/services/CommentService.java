package com.tellmestory.application.services;

import com.tellmestory.application.ports.in.CreateCommentCommand;
import com.tellmestory.application.ports.in.CreateCommentUseCase;
import com.tellmestory.application.ports.in.GetCommentsQuery;
import com.tellmestory.application.ports.out.CommentRepository;
import com.tellmestory.domain.comment.Comment;
import com.tellmestory.domain.comment.CommentId;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class CommentService implements CreateCommentUseCase, GetCommentsQuery {
    
    private final CommentRepository commentRepository;

    public CommentService(CommentRepository commentRepository) {
        this.commentRepository = commentRepository;
    }

    @Override
    public Comment createComment(CreateCommentCommand command) {
        LocalDateTime now = LocalDateTime.now();
        
        Comment comment = new Comment(
                CommentId.generate(),
                command.name(),
                command.description(),
                now,
                now
        );

        return commentRepository.save(comment);
    }

    @Override
    public List<Comment> getAllComments() {
        return commentRepository.findAll();
    }

    @Override
    public Optional<Comment> getCommentById(String id) {
        return commentRepository.findById(CommentId.of(id));
    }
}