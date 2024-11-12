# Use the official PostgreSQL 15 Alpine image as the base image
FROM postgres:15-alpine

# Copy the SQL script file named 'words.sql' into the '/docker-entrypoint-initdb.d/'
# directory of the container. This directory is where PostgreSQL will look for
# any SQL scripts to run when the container is first initialized.
COPY words.sql /docker-entrypoint-initdb.d/
