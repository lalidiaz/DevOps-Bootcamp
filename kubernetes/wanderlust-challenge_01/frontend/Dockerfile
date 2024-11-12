# First stage: Build the app
FROM node:21-alpine AS builder

# Add labels for better maintainability and metadata
LABEL maintainer="Laura Diaz lauradiaz1586@gmail.com>"
LABEL description="Frontend WanderLust is a MERN travel blog website 🚀 This project is aimed to help people to contribute in open source, upskill in react and master git."
LABEL version="1.0"

WORKDIR /app

COPY package*.json ./

RUN npm install

# Copy the rest of the application code and build it
COPY . .

# Pass VITE_API_PATH environment variable during the build
ARG VITE_API_PATH
ENV VITE_API_PATH=$VITE_API_PATH

# Build the Vite app
RUN npm run build


# Second stage: Nginx server to serve static files
FROM nginx:alpine

# Copy the custom nginx.conf file from your project
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# Copy built files from the builder stage to Nginx's static directory
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]