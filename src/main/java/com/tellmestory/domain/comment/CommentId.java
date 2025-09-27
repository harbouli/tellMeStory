package com.tellmestory.domain.comment;

import java.util.Objects;
import java.util.UUID;

public class CommentId {
    private final UUID value;

    public CommentId(UUID value) {
        this.value = Objects.requireNonNull(value, "Comment ID value cannot be null");
    }

    public static CommentId generate() {
        return new CommentId(UUID.randomUUID());
    }

    public static CommentId of(String value) {
        return new CommentId(UUID.fromString(value));
    }

    public UUID getValue() {
        return value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CommentId commentId = (CommentId) o;
        return Objects.equals(value, commentId.value);
    }

    @Override
    public int hashCode() {
        return Objects.hash(value);
    }

    @Override
    public String toString() {
        return value.toString();
    }
}