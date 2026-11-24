
# Stage 1: Build the React application
FROM node:22-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy dependency files
COPY frontend/package*.json ./

# Install project dependencies
RUN npm install

# Copy application source code
COPY frontend/ ./

# Generate production build
RUN npm run build


# Stage 2: Serve the application using Nginx
FROM nginx:alpine

# Copy production files from the builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose the HTTP port
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
