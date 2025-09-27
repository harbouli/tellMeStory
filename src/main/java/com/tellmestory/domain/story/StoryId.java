package com.tellmestory.domain.story;

import java.util.Objects;
import java.util.UUID;

public class StoryId {
    private final UUID value;

    public StoryId(UUID value) {
        this.value = Objects.requireNonNull(value, "Story ID value cannot be null");
    }

    public static StoryId generate() {
        return new StoryId(UUID.randomUUID());
    }

    public static StoryId of(String value) {
        return new StoryId(UUID.fromString(value));
    }

    public UUID getValue() {
        return value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        StoryId storyId = (StoryId) o;
        return Objects.equals(value, storyId.value);
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