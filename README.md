# AllRide User Management System

A full-stack application for bulk user management with a React frontend and a Kotlin backend, structured as a monorepo using Git submodules.

## Repository Structure

This repository serves as a container for two main components, organized as Git submodules:

- `all-ride-interview-fe/`: React frontend application (submodule)
- `allride/`: Kotlin backend service (submodule)

## Quick Start with Docker

1. Clone the repository with submodules:
   ```bash
   git clone --recursive [repository-url]
   cd AllRide
   ```

2. If you already cloned without submodules:
   ```bash
   git submodule update --init --recursive
   ```

3. Start the application stack:
   ```bash
   docker-compose up -d
   ```

   This will start:
   - Frontend (port 3000)
   - Backend (port 50051)
   - Envoy Proxy (port 8090)
   - LocalStack (port 4566)
   - Memcached (port 11211)

## Frontend Application

### Features

- Bulk user import from CSV files
- Real-time data validation
- Error handling and validation feedback
- Progress tracking for imports
- Import results display with success/failure breakdown
- Searchable and sortable user tables
- Responsive design using Ant Design

### Tech Stack

- React 18
- TypeScript
- Redux Toolkit for state management
- Ant Design component library
- Jest for testing
- Webpack for bundling
- gRPC-Web for API communication

### Getting Started

1. Navigate to the frontend directory:
   ```bash
   cd all-ride-interview-fe
   ```

2. Install dependencies:
   ```bash
   yarn install
   ```

3. Set up environment variables:
   ```bash
   cp .env.example .env
   ```

4. Start the development server:
   ```bash
   yarn start
   ```

The application will be available at http://localhost:3000.

## Backend Service

### Features

- gRPC API endpoints for user management
- Asynchronous CSV processing using AWS SQS
- Event-driven architecture
- Built-in error handling and validation
- In-memory storage (expandable to persistent storage)

### Tech Stack

- Kotlin
- Ktor for HTTP/2 server
- gRPC for API communication
- AWS SQS for message queuing
- Memcached for caching
- Gradle for build management

### Architecture

The service follows several modern architectural patterns:

1. **CQRS** (Command Query Responsibility Segregation)
   - Commands: File upload handling
   - Queries: User data retrieval

2. **Event Sourcing**
   - Events tracking for file uploads and processing
   - State change tracking

3. **Outbox Pattern**
   - Atomic event publishing with state changes
   - Consistency between storage and events

### Getting Started

1. Prerequisites:
   - Java 17 or later
   - Docker for LocalStack
   - Memcached

2. Start LocalStack:
   ```bash
   docker run -d -p 4566:4566 -e SERVICES=sqs localstack/localstack
   ```

3. Initialize LocalStack:
   ```bash
   cd allride
   ./init-localstack.sh
   ```

4. Run the service:
   ```bash
   ./gradlew run
   ```

The gRPC server will be available at port 50051, and gRPC-Web endpoint at port 8090.

## API Documentation

- gRPC API documentation is available in HTML and Markdown formats in `allride/docs/`
- Generate updated documentation using:
  ```bash
  cd allride
  ./gradlew generateProto
  ```

## Testing

### Frontend Tests
```bash
cd all-ride-interview-fe
yarn test
```

### Backend Tests
```bash
cd allride
./gradlew test
```

## Development

### Prerequisites
- Docker and Docker Compose
- Git
- Make (optional, for using Makefile shortcuts)

### Local Development Without Docker
If you prefer to run components individually:

1. Start the backend services (LocalStack and Memcached):
   ```bash
   docker-compose up -d localstack memcached
   ```

2. Follow the README instructions in each submodule for local development setup.

## Architecture

The application uses a modern microservices architecture:

```
┌─────────────┐     ┌──────────┐     ┌─────────────┐
│   Frontend  │────▶│  Envoy   │────▶│   Backend   │
│   (React)   │     │  Proxy   │     │   (Kotlin)  │
└─────────────┘     └──────────┘     └─────────────┘
                                           │
                                           ▼
                                    ┌─────────────┐
                                    │ LocalStack  │
                                    │    (SQS)    │
                                    └─────────────┘
                                           │
                                           ▼
                                    ┌─────────────┐
                                    │ Memcached  │
                                    └─────────────┘
```

## Deployment

### Production Deployment
For production deployment:

1. Update environment variables in docker-compose.prod.yml
2. Build and push images:
   ```bash
   docker-compose -f docker-compose.prod.yml build
   docker-compose -f docker-compose.prod.yml push
   ```
3. Deploy using your preferred orchestration tool (Kubernetes, ECS, etc.)

### Scaling Considerations
- Frontend is stateless and can be scaled horizontally
- Backend is stateless but requires session affinity for WebSocket connections
- Use AWS SQS for message queue in production
- Consider replacing Memcached with Redis for better persistence

## Troubleshooting

### Common Issues

1. Submodule Updates
   ```bash
   git submodule update --remote
   ```

2. Docker Network Issues
   ```bash
   docker-compose down
   docker-compose up -d
   ```

3. LocalStack Connection
   ```bash
   docker-compose logs localstack
   ```

### Logs
- Frontend logs: `docker-compose logs frontend`
- Backend logs: `docker-compose logs backend`
- Envoy logs: `docker-compose logs envoy`

## Contributing

1. Update submodules:
   ```bash
   git submodule update --remote
   ```

2. Create a new branch:
   ```bash
   git checkout -b feature/your-feature
   ```

3. Commit changes and push:
   ```bash
   git push origin feature/your-feature
   ```

See CONTRIBUTING.md for detailed guidelines.

## License

This project is proprietary and confidential.
