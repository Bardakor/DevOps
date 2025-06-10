# Multi-Stage Docker Build React App

A production-ready React application demonstrating multi-stage Docker builds for optimal deployment.

## 🚀 Features

- **Multi-stage Docker build** separating build and production environments
- **Optimized React app** with modern UI and animations
- **Small production image** (~77MB with Nginx Alpine)
- **Secure deployment** without development dependencies
- **Fast deployments** with efficient layer caching

## 📦 What You Get

### Build Stage
- Node.js 18 Alpine for building
- All development dependencies
- React build process

### Production Stage  
- Nginx Alpine for serving
- Only production assets
- No node_modules or dev tools

## 🛠️ Build & Run

```bash
# Build the multi-stage image
docker build -t my-react-app .

# Run on port 8000
docker run -d -p 8000:80 my-react-app

# View in browser
open http://localhost:8000
```

## 📊 Benefits Demonstrated

- **Image Size**: ~77MB (vs 500MB+ with dev dependencies)
- **Security**: No development tools in production
- **Performance**: Nginx serving static files efficiently
- **Caching**: Optimized Docker layer caching

## 🏗️ Project Structure

```
devops-sesssion2/
├── Dockerfile          # Multi-stage build configuration
├── package.json         # React dependencies
├── .dockerignore       # Ignore unnecessary files
├── multistep-builds.md # Documentation
├── public/             # Static assets
└── src/                # React source code
```

## 🔍 Docker Stages

1. **Builder Stage**: Downloads dependencies, builds React app
2. **Production Stage**: Copies built files to Nginx, serves on port 80

Perfect example of Docker best practices for React applications! 🐳⚛️
