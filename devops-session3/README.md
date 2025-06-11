# GitHub Pipeline Demo

This is a simple Node.js project created to demonstrate GitHub Actions pipeline.

## Features

- Simple Express.js server
- Basic test suite
- GitHub Actions CI/CD pipeline

## Usage

```bash
# Install dependencies (if any were needed)
npm install

# Run the application
npm start

# Run tests
npm test

# Run linting
npm run lint
```

## API Endpoints

- `GET /` - Returns a hello world message
- `GET /health` - Returns health status

## GitHub Actions

This project includes a GitHub Actions workflow that:
- Runs on push and pull requests
- Tests the application
- Runs linting
- Builds the project

The workflow file is located at `.github/workflows/ci.yml`.
🚀 Pipeline triggered on Wed Jun 11 18:04:42 CEST 2025
