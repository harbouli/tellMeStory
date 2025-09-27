package com.tellmestory.infrastructure.adapters.in.web;

import com.tellmestory.application.ports.in.CreateCommentUseCase;
import com.tellmestory.application.ports.in.CreateCommentCommand;
import com.tellmestory.application.ports.in.GetCommentsQuery;
import com.tellmestory.domain.comment.Comment;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/comments")
public class CommentController {
    private final CreateCommentUseCase createCommentUseCase;
    private final GetCommentsQuery getCommentsQuery;

    public CommentController(CreateCommentUseCase createCommentUseCase, 
                         GetCommentsQuery getCommentsQuery) {
        this.createCommentUseCase = createCommentUseCase;
        this.getCommentsQuery = getCommentsQuery;
    }

    @PostMapping
    public ResponseEntity<CommentResponse> createComment(@Valid @RequestBody CreateCommentCommand command) {
        Comment comment = createCommentUseCase.createComment(command);
        return ResponseEntity.ok(new CommentResponse(
                comment.getId().toString(),
                comment.getName(),
                comment.getDescription(),
                comment.getCreatedAt(),
                comment.getUpdatedAt()
        ));
    }

    @GetMapping
    public ResponseEntity<List<CommentResponse>> getAllComments() {
        List<Comment> comments = getCommentsQuery.getAllComments();
        List<CommentResponse> responses = comments.stream()
                .map(comment -> new CommentResponse(
                        comment.getId().toString(),
                        comment.getName(),
                        comment.getDescription(),
                        comment.getCreatedAt(),
                        comment.getUpdatedAt()
                ))
                .collect(Collectors.toList());
        return ResponseEntity.ok(responses);
    }

    @GetMapping("/{id}")
    public ResponseEntity<CommentResponse> getCommentById(@PathVariable String id) {
        return getCommentsQuery.getCommentById(id)
                .map(comment -> ResponseEntity.ok(new CommentResponse(
                        comment.getId().toString(),
                        comment.getName(),
                        comment.getDescription(),
                        comment.getCreatedAt(),
                        comment.getUpdatedAt()
                )))
                .orElse(ResponseEntity.notFound().build());
    }
}