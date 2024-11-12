FROM node:21-alpine

# Add labels for better maintainability and metadata
LABEL maintainer="Laura Diaz lauradiaz1586@gmail.com>"
LABEL description="Backend WanderLust is a MERN travel blog website 🚀 This project is aimed to help people to contribute in open source, upskill in react and master git."
LABEL version="1.0"

# Install curl first (as root)
RUN apk add --no-cache curl

# Create a non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy package files first to leverage cache
COPY package*.json ./


# install curl for healthcheck
RUN npm install && \
    npm cache clean --force

# Copy application code
COPY --chown=appuser:appgroup . .

# Switch to non-root user
USER appuser

EXPOSE 5000

CMD ["npm", "start"]
