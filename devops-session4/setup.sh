#!/bin/bash

# DevOps CI/CD Pipeline Setup Script

echo "🚀 Setting up DevOps CI/CD Pipeline..."

# Check prerequisites
echo "📋 Checking prerequisites..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 18+ first."
    exit 1
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

echo "✅ Prerequisites check passed!"

# Install dependencies
echo "📦 Installing dependencies..."

echo "Installing frontend dependencies..."
cd frontend && npm install
if [ $? -ne 0 ]; then
    echo "❌ Failed to install frontend dependencies"
    exit 1
fi

echo "Installing backend dependencies..."
cd ../backend && npm install
if [ $? -ne 0 ]; then
    echo "❌ Failed to install backend dependencies"
    exit 1
fi

echo "Installing webhook server dependencies..."
cd ../local-webhook-listening-server && npm install
if [ $? -ne 0 ]; then
    echo "❌ Failed to install webhook server dependencies"
    exit 1
fi

cd ..

# Create environment file
echo "🔧 Setting up environment configuration..."
if [ ! -f .env ]; then
    cp env.example .env
    echo "📝 Created .env file from template. Please update it with your actual values."
else
    echo "📝 .env file already exists."
fi

# Run tests
echo "🧪 Running tests..."

echo "Testing frontend..."
cd frontend && npm test -- --watchAll=false
if [ $? -ne 0 ]; then
    echo "❌ Frontend tests failed"
    exit 1
fi

echo "Testing backend..."
cd ../backend && npm test
if [ $? -ne 0 ]; then
    echo "❌ Backend tests failed"
    exit 1
fi

cd ..

# Run linting
echo "🔍 Running linting..."

echo "Linting frontend..."
cd frontend && npm run lint
if [ $? -ne 0 ]; then
    echo "❌ Frontend linting failed"
    exit 1
fi

echo "Linting backend..."
cd ../backend && npm run lint
if [ $? -ne 0 ]; then
    echo "❌ Backend linting failed"
    exit 1
fi

cd ..

echo "✅ Setup completed successfully!"
echo ""
echo "📚 Next steps:"
echo "1. Update the .env file with your actual configuration values"
echo "2. Set up GitHub Secrets in your repository"
echo "3. Configure Docker Hub repository"
echo "4. Set up ngrok for webhook tunneling"
echo "5. Update webhook server configuration with your repo details"
echo ""
echo "🚀 To start the application:"
echo "   export DOCKER_USERNAME=your_username"
echo "   docker-compose up -d"
echo ""
echo "🔗 Access the application:"
echo "   Frontend: http://localhost:3000"
echo "   Backend:  http://localhost:3001/api/health"
echo ""
echo "📖 Read the README.md for detailed instructions!" 