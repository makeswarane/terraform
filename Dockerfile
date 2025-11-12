# ---------- Stage 1: Build Angular App ----------
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci

# Copy all source files
COPY . .

# Default build environment
ARG BUILD_ENV=dev

# Build Angular app based on BUILD_ENV
RUN if [ "$BUILD_ENV" = "production" ]; then \
      npm run build -- --configuration production; \
    else \
      npm run build -- --configuration dev; \
    fi

# ---------- Stage 2: Serve with Nginx ----------
FROM nginx:alpine

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy built Angular app from builder stage
ARG BUILD_ENV=dev
RUN if [ "$BUILD_ENV" = "production" ]; then \
      cp -r /app/dist/myapp /usr/share/nginx/html; \
    else \
      cp -r /app/dist/myapp-dev /usr/share/nginx/html; \
    fi

# Copy custom nginx config (optional)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
