# Multi-Step Docker Build for Optimized React App

*2025-06-10*

This guide explains how to build a multi-stage Docker image for a React app to ensure a small, production-ready container.

## Why Multi-Step?

Multi-step builds separate the build environment from the production image:
- Reduces image size
- Avoids leaking development tools into production

## 📁 Project Structure

```
my-react-app/
├── Dockerfile
├── package.json
├── package-lock.json
└── public/
└── src/
```

## Dockerfile (Multi-Stage Build)

```dockerfile
# Stage 1: Build the React app
FROM node:24.2.0 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Serve the build using a lightweight image
FROM nginx:alpine AS production
COPY --from=builder /app/build /usr/share/nginx/html

# Optional: custom nginx config
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

## Build and Run

```bash
docker build -t my-react-app .
docker run -p 8000:80 my-react-app
```

## Benefits

- **Smaller final image**: ~20–30MB with Nginx
- **Security**: No node_modules or dev dependencies in final image
- **Faster deployments**: Smaller images = faster pull times

## Optional Optimizations

- Use `--no-cache` in npm ci
- Customize Nginx config for caching
- Use `.dockerignore` to exclude unnecessary files

## .dockerignore Example

```
node_modules
build
.dockerignore
Dockerfile
README.md
```
