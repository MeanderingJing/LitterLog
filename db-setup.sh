#!/bin/bash

#####################################################################
# Script Name: db-setup.sh
# Description: This script installs Postgres and creates a new database
#              with a user and password specified in the provided .env file.
# Usage:       ./db-setup.sh
# Date:        [3/14/2023]
# Author:      [Emma Li]
#####################################################################

# Define usage information
#
# Usage: ./db-setup.sh
#
# Arguments:
# None
#
# Environment Variables:
# - DB_NAME: the name of the new database to be created
# - DB_USER: the username for the new database user
# - DB_PASSWORD: the password for the new database user
# - PG_VERSION: the version of Postgres to be installed
#
# Example usage:
#   DB_NAME=mydb DB_USER=myuser DB_PASSWORD=mypassword PG_VERSION=13 ./db-setup.sh

# Check if .env file exists
if [[ ! -f .env ]]; then
    echo "Error: .env file not found"
    exit 1
fi

# Load environment variables from .env file
# Tell the shell to automatically export all variables to the environment of any subsequent commands or subshells
set -o allexport
source .env
# Disable the automatic exporting of variables
set +o allexport

# Install Postgres if not already installed
echo "Installing Postgres..."
if command -v psql &> /dev/null; then
    echo "Postgres is already installed"
else
    sudo apt-get update
    sudo apt-get install postgresql-$PG_VERSION postgresql-contrib
    # Check if installation was successful
    if [ $? -eq 0 ]; then
        echo "PostgreSQL installed successfully."
    else
        echo "Error: PostgreSQL installation failed."
        exit 1
    fi
fi


# Check if user exists
echo "Checking if postgres user exists..."
if sudo -u postgres psql -c "SELECT * FROM pg_roles" | grep -qw $DB_USER; then
#alternative: if sudo -u postgres psql -c "SELECT 1 FROM pg_roles WHERE rolname='$DB_USER'" | grep -q 1; then 
    echo "User $DB_USER already exists"
else
    echo "Creating user $DB_USER..."
    sudo -u postgres psql -c "CREATE USER $DB_USER WITH ENCRYPTED PASSWORD '$DB_PASSWORD';" 
fi

# Check if database exists
echo "Checking if database exists..."
if sudo -u postgres psql -lqt | cut -d \| -f 1 | grep -qw $DB_NAME; then
    echo "Database $DB_NAME already exists"
else
    echo "Creating database $DB_NAME..."
    sudo -u postgres psql -c "CREATE DATABASE $DB_NAME OWNER $DB_USER;" 
fi

# Grant privileges to user
echo "Granting privileges to user..."
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;" 

# Check if user and database were created successfully
if sudo -u postgres psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='$DB_USER'" | grep -q 1 && sudo -u postgres psql -lqt | cut -d \| -f 1  | grep -qw $DB_NAME; then
    echo "Database and user created successfully"
else
    echo "Error: Failed to create database and user"
    exit 1
fi


# This script tested to work 20230602