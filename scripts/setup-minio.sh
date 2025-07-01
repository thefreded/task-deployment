#!/bin/sh
set -e

echo "Starting MinIO setup..."

# Wait for MinIO to be ready using environment variables from docker-compose
echo "Waiting for MinIO to be ready..."
until mc alias set myminio http://minio:9000 ${MINIO_ROOT_USER} ${MINIO_ROOT_PASSWORD}; do
  echo "MinIO not ready yet, retrying in 5 seconds..."
  sleep 5
done

echo "MinIO is ready. Configuring..."

# Create bucket
echo "Creating bucket 'task-files'..."
mc mb myminio/task-files --ignore-existing

# Create user policy for JWT-based access
echo "Creating user policy..."
if [ -f /policies/user-policy.json ]; then
  mc admin policy create myminio user-jwt-policy /policies/user-policy.json
else
  echo "Warning: /policies/user-policy.json not found"
fi

# Set bucket policy to allow authenticated access
echo "Setting bucket policy..."
if [ -f /policies/bucket-policy.json ]; then
  mc anonymous set-json /policies/bucket-policy.json myminio/task-files
else
  echo "Warning: /policies/bucket-policy.json not found"
fi

# Configure OpenID Connect with Keycloak
echo "Configuring OpenID Connect..."
mc admin config set myminio identity_openid \
  config_url="${KEYCLOAK_URL}/${KEYCLOAK_REALM}/.well-known/openid-configuration" \
  client_id="${KEYCLOAK_MINIO_CLIENT_ID}" \
  client_secret="${KEYCLOAK_MINIO_SECRET}" \
  claim_name="preferred_username" \
  claim_userinfo="on" \
  scopes="openid,profile,email"

echo "OIDC configuration applied successfully"

# Apply policy to all JWT users
echo "Setting default policy for JWT users..."
mc admin policy attach myminio user-jwt-policy --user="jwt:*"

# Restart MinIO to apply config
echo "Restarting MinIO service to apply configuration..."
mc admin service restart myminio

# Wait a moment for restart
sleep 10

# Verify configuration
echo "Verifying OIDC configuration..."
mc admin config get myminio identity_openid

echo "MinIO setup completed successfully!"