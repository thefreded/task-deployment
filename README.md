# Task Manager Docker Compose

Task management system with Keycloak authentication, PostgreSQL database, and microservices architecture.

## Environment Variables

Create a `.env` file with the following variables:

```env
# Database configurations for task and file service
DB_TASK_USERNAME=your_task_db_user
DB_TASK_PASSWORD=your_task_db_password
DB_TASK_URL=your_task_db_url
DB_FILE_USERNAME=your_file_db_user
DB_FILE_PASSWORD=your_file_db_password
DB_FILE_URL=your_file_db_url


# Keycloak Clients
KEYCLOAK_TASK_CLIENT_ID=task-client
KEYCLOAK_TASK_CLIENT_SECRET=your_task_client_secret
KEYCLOAK_FILE_CLIENT_ID=file-client
KEYCLOAK_FILE_CLIENT_SECRET=your_file_client_secret
KEYCLOAK_GATEWAY_CLIENT_ID=gateway-client
KEYCLOAK_GATEWAY_CLIENT_SECRET=your_gateway_client_secret

# Keycloak Configuration
KEYCLOAK_REALM=your_realm
KEYCLOAK_SCOPE=your_scope
```

## Quick Start

1. Create `.env` file with required variables
2. Run: `docker-compose up -d`
