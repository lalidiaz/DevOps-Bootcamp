# Use the official Golang 1.23.3 Alpine image as the base image
FROM golang:1.23.3-alpine

# Copy the current directory contents (likely containing Go source files)
# into the root directory of the container
COPY . .

# Expose port 80 to allow incoming connections to the Go application
EXPOSE 80

# When the container starts, run the 'go run dispatcher.go' command,
# which will execute the Go application
CMD ["go", "run", "dispatcher.go"]