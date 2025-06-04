# AllRide User Management System

A full-stack application for bulk user management with a React frontend and a Kotlin backend.

## Project Structure

The project consists of two main components:

- `all-ride-interview-fe/`: React frontend application
- `allride/`: Kotlin backend service

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

## Future Improvements

1. **Backend**
   - Add persistent database storage
   - Implement monitoring and metrics
   - Add authentication and authorization
   - Implement rate limiting
   - Add caching for queries
   - Add batch processing for large files

2. **Frontend**
   - Add user management features (edit, delete)
   - Implement real-time updates
   - Add data export functionality
   - Enhance error reporting
   - Add user activity logging

## Contributing

Please read our contributing guidelines before submitting pull requests.

## License

This project is proprietary and confidential.
