# DevOps CI/CD Pipeline with Local Deployment

This project demonstrates a complete DevOps CI/CD pipeline with local deployment using GitHub Actions, Docker, and webhook-based deployment.

## Project Structure

```
devops-session4/
├── frontend/                    # React frontend application
│   ├── src/
│   ├── public/
│   ├── Dockerfile
│   ├── nginx.conf
│   └── package.json
├── backend/                     # Node.js Express backend
│   ├── __tests__/
│   ├── server.js
│   ├── Dockerfile
│   └── package.json
├── local-webhook-listening-server/  # Local deployment server
│   ├── local-webhook-listening-server.js
│   └── package.json
├── .github/workflows/           # GitHub Actions workflows
│   ├── dev-merge-request.yml
│   └── main-deployment.yml
├── docker-compose.yml
└── README.md
```

## Features

### Application Setup
- **Frontend**: React application with modern UI
- **Backend**: Node.js Express API with health checks
- **Dockerized**: Both services containerized with multi-stage builds
- **Docker Compose**: Orchestration with networking and health checks

### CI/CD Pipeline

#### On Pull Request to `dev` branch:
- ✅ **Linting**: ESLint validation for both frontend and backend
- ✅ **Security Audit**: npm audit for dependency vulnerabilities
- ✅ **Security Analysis**: Snyk static code security analysis
- ✅ **Testing**: Comprehensive test suite execution
- ✅ **Docker Build**: Build and validate Docker images
- ✅ **Merge Gate**: All checks must pass before merge approval

#### On Push to `main` branch:
- 🚀 **Production Build**: Build production-ready Docker images
- 🔐 **Secrets Management**: Copy secrets from GitHub Secrets Manager
- 📦 **Registry Push**: Push images to Docker Hub with tags `:frontend` and `:backend`
- 🔄 **Deployment Trigger**: Webhook triggers local deployment

### Local Deployment

The deployment system uses:
- **GitHub Webhook**: Triggers POST to ngrok tunnel URL
- **Node.js Express Server**: Listens on localhost for deployment requests
- **Automated Process**:
  1. Brings down current running application
  2. Pulls latest images from Docker Hub
  3. Restarts application with new images

## Setup Instructions

### 1. Prerequisites

- Node.js 18+
- Docker and Docker Compose
- GitHub account
- Docker Hub account
- ngrok (for webhook tunneling)
- Snyk account (optional, for security scanning)

### 2. Environment Setup

1. Copy the environment example:
   ```bash
   cp env.example .env
   ```

2. Update the variables in `.env` with your actual values.

### 3. GitHub Secrets Configuration

Configure the following secrets in your GitHub repository:

| Secret Name | Description |
|-------------|-------------|
| `DOCKER_USERNAME` | Your Docker Hub username |
| `DOCKER_PASSWORD` | Your Docker Hub password/token |
| `WEBHOOK_URL` | Your ngrok tunnel URL (e.g., `https://abc123.ngrok.io/webhook`) |
| `SNYK_TOKEN` | Your Snyk authentication token |
| `REACT_APP_API_URL` | Frontend API URL for production |
| `DATABASE_URL` | Database connection string |
| `JWT_SECRET` | JWT signing secret |
| `API_KEY` | API key for external services |

### 4. Local Development

1. **Install dependencies**:
   ```bash
   # Frontend
   cd frontend && npm install
   
   # Backend
   cd ../backend && npm install
   
   # Webhook server
   cd ../local-webhook-listening-server && npm install
   ```

2. **Run locally**:
   ```bash
   # Using Docker Compose
   export DOCKER_USERNAME=your_username
   docker-compose up -d
   
   # Or run individually
   cd frontend && npm start  # Port 3000
   cd backend && npm start   # Port 3001
   ```

3. **Run tests**:
   ```bash
   # Frontend tests
   cd frontend && npm test
   
   # Backend tests
   cd backend && npm test
   ```

4. **Linting**:
   ```bash
   cd frontend && npm run lint
   cd backend && npm run lint
   ```

### 5. Webhook Server Setup

1. **Update webhook server configuration**:
   - Edit `local-webhook-listening-server/local-webhook-listening-server.js`
   - Set `repoDir` to your target deployment directory
   - Set `repoUrl` to your GitHub repository URL

2. **Start ngrok tunnel**:
   ```bash
   ngrok http 8000
   ```

3. **Start webhook server**:
   ```bash
   cd local-webhook-listening-server
   node local-webhook-listening-server.js
   ```

4. **Configure GitHub webhook**:
   - Go to your repository Settings → Webhooks
   - Add webhook URL: `https://your-ngrok-url.ngrok.io/webhook`
   - Set content type to `application/json`
   - Select "Just the push event"

### 6. Docker Hub Setup

1. Create a repository on Docker Hub
2. The pipeline will push images with tags:
   - `your-username/your-repo:frontend`
   - `your-username/your-repo:backend`

## Usage

### Development Workflow

1. **Feature Development**:
   ```bash
   git checkout -b feature/new-feature
   # Make changes
   git push origin feature/new-feature
   ```

2. **Create Pull Request** to `dev` branch
   - CI pipeline runs automatically
   - All checks must pass for merge approval

3. **Merge to main**:
   ```bash
   git checkout main
   git merge dev
   git push origin main
   ```

4. **Automatic Deployment**:
   - Production pipeline builds and pushes Docker images
   - Webhook triggers local deployment
   - Application updates automatically

### Monitoring

- **Application Health**: Visit `http://localhost:3000` for frontend
- **API Health**: Visit `http://localhost:3001/api/health` for backend status
- **Logs**: Use `docker-compose logs -f` to monitor application logs

## Security Features

- **Dependency Scanning**: npm audit checks for known vulnerabilities
- **Static Analysis**: Snyk scans for security issues in code and dependencies
- **Secret Management**: GitHub Secrets for sensitive configuration
- **Container Security**: Non-root user in Docker containers
- **Health Checks**: Docker health checks for service monitoring

## Troubleshooting

### Common Issues

1. **Docker Build Fails**:
   - Check Dockerfile syntax
   - Ensure all dependencies are properly specified
   - Verify build context

2. **Webhook Not Triggering**:
   - Verify ngrok tunnel is active
   - Check webhook URL in GitHub settings
   - Ensure webhook server is running on port 8000

3. **Tests Failing**:
   - Run tests locally first
   - Check test setup and dependencies
   - Verify test environment configuration

4. **Pipeline Failures**:
   - Check GitHub Actions logs
   - Verify all secrets are configured
   - Ensure code passes local linting and tests

### Useful Commands

```bash
# View running containers
docker ps

# View logs
docker-compose logs -f

# Rebuild and restart
docker-compose down
docker-compose up --build -d

# Clean up Docker
docker system prune -a

# Check webhook server logs
cd local-webhook-listening-server
node local-webhook-listening-server.js
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Ensure all tests pass
5. Submit a pull request

## License

This project is for educational purposes as part of the DevOps course at EFREI. 