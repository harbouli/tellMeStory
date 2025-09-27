# TellMeStory

A Spring Boot application for sharing stories with authentication, built using hexagonal architecture (Ports and Adapters pattern).

## Features

- User registration and authentication
- JWT-based security
- Story creation and sharing
- RESTful API endpoints
- PostgreSQL database with Docker
- Hexagonal architecture implementation

## Architecture

This project follows the hexagonal architecture pattern with clear separation of concerns:

```
src/main/java/com/tellmestory/
├── domain/                 # Business entities and rules
│   ├── user/              # User domain objects
│   ├── story/             # Story domain objects
│   └── auth/              # Authentication domain objects
├── application/           # Use cases and business logic
│   ├── ports/in/          # Input ports (interfaces)
│   ├── ports/out/         # Output ports (interfaces)
│   └── services/          # Service implementations
└── infrastructure/        # External adapters
    ├── adapters/in/web/   # REST controllers
    ├── adapters/out/      # Database and security adapters
    └── config/            # Configuration classes
```

## Getting Started

### Prerequisites

- Java 17 or higher
- Maven 3.6+
- Docker and Docker Compose

### Running the Application

1. Clone the repository
2. Navigate to the project directory
3. Start the PostgreSQL database:

```bash
docker-compose up -d
```

4. Run the application:

```bash
mvn spring-boot:run
```

The application will start on `http://localhost:8080`

### Database

The application uses PostgreSQL running in Docker. The database setup includes:

- **PostgreSQL**: Available at `localhost:5432`
  - Database: `tellmestory`
  - Username: `tellmestory_user`
  - Password: `tellmestory_password`

- **Adminer** (Database management): Available at `http://localhost:8081`
  - Server: `postgres`
  - Username: `tellmestory_user`
  - Password: `tellmestory_password`
  - Database: `tellmestory`

#### Database Commands

```bash
# Start the database
docker-compose up -d

# Stop the database
docker-compose down

# View database logs
docker-compose logs postgres

# Reset database (removes all data)
docker-compose down -v
docker-compose up -d
```

## API Endpoints

### Authentication

#### Register a new user
```
POST /api/auth/register
Content-Type: application/json

{
  "username": "john_doe",
  "email": "john@example.com",
  "password": "password123"
}
```

#### Login
```
POST /api/auth/login
Content-Type: application/json

{
  "username": "john_doe",
  "password": "password123"
}
```

#### Logout
```
POST /api/auth/logout
Authorization: Bearer <token>
```

### Stories

#### Create a story
```
POST /api/stories
Authorization: Bearer <token>
Content-Type: application/json

{
  "title": "My Amazing Story",
  "content": "Once upon a time...",
  "authorId": "user-id"
}
```

#### Get all stories
```
GET /api/stories
Authorization: Bearer <token>
```

#### Get stories by author
```
GET /api/stories/author/{authorId}
Authorization: Bearer <token>
```

## Configuration

The application can be configured via `application.yml`:

- `server.port`: Application port (default: 8080)
- `app.jwt.secret`: JWT signing secret
- `app.jwt.expiration`: JWT token expiration time in seconds

## Security

- Passwords are encrypted using BCrypt
- JWT tokens are used for authentication
- Stateless session management
- CORS configuration for API access

## Technologies Used

- Spring Boot 3.2.0
- Spring Security
- Spring Data JPA
- PostgreSQL Database
- Docker & Docker Compose
- JWT (JSON Web Tokens)
- Maven
- Java 17

## Development

### Building the project
```bash
mvn clean compile
```

### Running tests
```bash
mvn test
```

### Creating a JAR file
```bash
mvn clean package
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License.