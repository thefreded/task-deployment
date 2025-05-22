# Task Manager Docker Compose

Task management system with Keycloak authentication, PostgreSQL database, and microservices architecture.

## Environment Variables

Create a `.env` file with the following variables:

```env
# Database
DB_USERNAME=your_db_user
DB_PASSWORD=your_db_password

# Keycloak Clients
KEYCLOAK_TASK_CLIENT_ID=task-client
KEYCLOAK_TASK_CLIENT_SECRET=your_task_client_secret
KEYCLOAK_FILE_CLIENT_ID=file-client
KEYCLOAK_FILE_CLIENT_SECRET=your_file_client_secret
KEYCLOAK_GATEWAY_CLIENT_ID=gateway-client
KEYCLOAK_GATEWAY_CLIENT_SECRET=your_gateway_client_secret

# Keycloak Configuration
KEYCLOAK_REALM=your_realm
KEYCLOAK_SCOPE=openid
```

## Quick Start

1. Create `.env` file with required variables
2. Run: `docker-compose up -d`
