---
to: src/main/java/com/tellmestory/infrastructure/config/seed/<%= seedName %>Seeder.java
---
package com.tellmestory.infrastructure.config.seed;

<% if (entities.includes('User')) { -%>
import com.tellmestory.application.ports.out.UserRepository;
import com.tellmestory.application.ports.out.PasswordEncoder;
import com.tellmestory.domain.user.User;
import com.tellmestory.domain.user.UserId;
<% } -%>
<% if (entities.includes('Story')) { -%>
import com.tellmestory.application.ports.out.StoryRepository;
import com.tellmestory.domain.story.Story;
import com.tellmestory.domain.story.StoryId;
<% } -%>
<% if (entities.includes('Comment')) { -%>
import com.tellmestory.application.ports.out.CommentRepository;
import com.tellmestory.domain.comment.Comment;
import com.tellmestory.domain.comment.CommentId;
<% } -%>
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
<% if (seedEnvironment !== 'all') { -%>
import org.springframework.context.annotation.Profile;
<% } -%>
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

<% if (runOnStartup) { -%>
@Component
<% } -%>
<% if (seedEnvironment !== 'all') { -%>
@Profile("<%= seedEnvironment %>")
<% } -%>
@Order(100)
public class <%= seedName %>Seeder<% if (runOnStartup) { %> implements CommandLineRunner<% } %> {

    private static final Logger logger = LoggerFactory.getLogger(<%= seedName %>Seeder.class);
    
<% if (entities.includes('User')) { -%>
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
<% } -%>
<% if (entities.includes('Story')) { -%>
    private final StoryRepository storyRepository;
<% } -%>
<% if (entities.includes('Comment')) { -%>
    private final CommentRepository commentRepository;
<% } -%>
    private final Random random = new Random();

    public <%= seedName %>Seeder(
<% if (entities.includes('User')) { -%>
            UserRepository userRepository,
            PasswordEncoder passwordEncoder<% if (entities.includes('Story') || entities.includes('Comment')) { %>,<% } %>
<% } -%>
<% if (entities.includes('Story')) { -%>
            StoryRepository storyRepository<% if (entities.includes('Comment')) { %>,<% } %>
<% } -%>
<% if (entities.includes('Comment')) { -%>
            CommentRepository commentRepository
<% } -%>
    ) {
<% if (entities.includes('User')) { -%>
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
<% } -%>
<% if (entities.includes('Story')) { -%>
        this.storyRepository = storyRepository;
<% } -%>
<% if (entities.includes('Comment')) { -%>
        this.commentRepository = commentRepository;
<% } -%>
    }

<% if (runOnStartup) { -%>
    @Override
    public void run(String... args) throws Exception {
        seed();
    }
<% } -%>

    public void seed() {
        logger.info("Starting <%= seedDescription %>...");
        
<% if (entities.includes('User')) { -%>
        List<User> users = seedUsers();
        logger.info("Created {} users", users.size());
<% } -%>
<% if (entities.includes('Story')) { -%>
        List<Story> stories = seedStories(<% if (entities.includes('User')) { %>users<% } %>);
        logger.info("Created {} stories", stories.size());
<% } -%>
<% if (entities.includes('Comment')) { -%>
        List<Comment> comments = seedComments(<% if (entities.includes('Story')) { %>stories<% } %><% if (entities.includes('User') && entities.includes('Story')) { %>, users<% } else if (entities.includes('User')) { %>users<% } %>);
        logger.info("Created {} comments", comments.size());
<% } -%>
        
        logger.info("<%= seedDescription %> completed successfully!");
    }

<% if (entities.includes('User')) { -%>
    private List<User> seedUsers() {
        List<User> users = new ArrayList<>();
        String[] firstNames = {"John", "Jane", "Alice", "Bob", "Charlie", "Diana", "Eve", "Frank", "Grace", "Henry"};
        String[] lastNames = {"Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez"};
        
        for (int i = 0; i < <%= userCount %>; i++) {
            String firstName = firstNames[random.nextInt(firstNames.length)];
            String lastName = lastNames[random.nextInt(lastNames.length)];
            String username = (firstName + lastName + i).toLowerCase();
            String email = username + "@example.com";
            String password = passwordEncoder.encode("password123");
            
            LocalDateTime now = LocalDateTime.now().minusDays(random.nextInt(30));
            
            if (!userRepository.existsByUsername(username) && !userRepository.existsByEmail(email)) {
                User user = new User(
                    UserId.generate(),
                    username,
                    email,
                    password,
                    now,
                    now
                );
                
                users.add(userRepository.save(user));
            }
        }
        
        return users;
    }
<% } -%>

<% if (entities.includes('Story')) { -%>
    private List<Story> seedStories(<% if (entities.includes('User')) { %>List<User> users<% } %>) {
        List<Story> stories = new ArrayList<>();
        String[] titles = {
            "The Mysterious Forest", "A Day in the City", "The Lost Treasure", "Journey to the Mountains",
            "The Secret Garden", "Adventures in Space", "The Magic Castle", "Tales from the Ocean",
            "The Enchanted Kingdom", "Chronicles of Time", "The Hidden Valley", "Legends of the Past",
            "The Crystal Cave", "Stories of Friendship", "The Golden Phoenix", "Dreams of Tomorrow",
            "The Ancient Library", "Whispers in the Wind", "The Starlit Night", "Echoes of Eternity"
        };
        
        String[] contentSamples = {
            "Once upon a time, in a land far away, there lived a brave adventurer who set out on an incredible journey...",
            "In the heart of the bustling city, something extraordinary was about to happen that would change everything...",
            "The old map revealed secrets that had been hidden for centuries, waiting for the right person to discover them...",
            "As the sun set over the horizon, the true adventure was just beginning for our unlikely hero...",
            "Deep in the forest, ancient magic still flowed through the trees, protecting secrets of the past..."
        };
        
        for (int i = 0; i < <%= storyCount %>; i++) {
            String title = titles[random.nextInt(titles.length)] + " #" + (i + 1);
            String content = contentSamples[random.nextInt(contentSamples.length)];
            
<% if (entities.includes('User')) { -%>
            User author = users.get(random.nextInt(users.size()));
<% } else { -%>
            // Note: You'll need to provide a user ID when users are available
            UserId authorId = UserId.generate(); // This should be replaced with actual user ID
<% } -%>
            LocalDateTime createdAt = LocalDateTime.now().minusDays(random.nextInt(7));
            
            Story story = new Story(
                StoryId.generate(),
                title,
                content,
<% if (entities.includes('User')) { -%>
                author.getId(),
<% } else { -%>
                authorId,
<% } -%>
                createdAt,
                createdAt
            );
            
            stories.add(storyRepository.save(story));
        }
        
        return stories;
    }
<% } -%>

<% if (entities.includes('Comment')) { -%>
    private List<Comment> seedComments(<% if (entities.includes('Story')) { %>List<Story> stories<% } %><% if (entities.includes('User') && entities.includes('Story')) { %>, List<User> users<% } else if (entities.includes('User')) { %>List<User> users<% } %>) {
        List<Comment> comments = new ArrayList<>();
        String[] commentTexts = {
            "Great story! I really enjoyed reading it.",
            "This reminds me of my own experiences.",
            "Wonderful writing style and engaging plot.",
            "I can't wait to read more from this author.",
            "The characters are so well developed.",
            "This story made me laugh and cry at the same time.",
            "Incredible imagination and creativity!",
            "I'm sharing this with all my friends.",
            "Such a touching and meaningful story.",
            "The ending was perfect!"
        };
        
        for (int i = 0; i < <%= commentCount %>; i++) {
            String content = commentTexts[random.nextInt(commentTexts.length)];
            
<% if (entities.includes('Story')) { -%>
            Story story = stories.get(random.nextInt(stories.size()));
<% } -%>
<% if (entities.includes('User')) { -%>
            User author = users.get(random.nextInt(users.size()));
<% } -%>
            LocalDateTime createdAt = LocalDateTime.now().minusDays(random.nextInt(3));
            
            Comment comment = new Comment(
                CommentId.generate(),
                "Comment " + (i + 1),
                content,
<% if (entities.includes('User')) { -%>
                author.getId(),
<% } else { -%>
                UserId.generate(), // This should be replaced with actual user ID
<% } -%>
                createdAt,
                createdAt
            );
            
            comments.add(commentRepository.save(comment));
        }
        
        return comments;
    }
<% } -%>
}