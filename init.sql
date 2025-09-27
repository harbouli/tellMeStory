-- Initial database setup for TellMeStory application
-- This script is executed when the PostgreSQL container starts

-- Create database (already created by POSTGRES_DB environment variable)
-- CREATE DATABASE tellmestory;

-- Create user (already created by POSTGRES_USER environment variable)
-- CREATE USER tellmestory_user WITH ENCRYPTED PASSWORD 'tellmestory_password';

-- Grant privileges (user already has privileges through POSTGRES_USER)
-- GRANT ALL PRIVILEGES ON DATABASE tellmestory TO tellmestory_user;

-- Set timezone
SET timezone = 'UTC';

-- Create extensions if needed
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Tables will be created automatically by Hibernate/JPA