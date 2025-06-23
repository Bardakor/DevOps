# 🚀 Quick Start Guide - DevOps CI/CD Pipeline

## ✅ What's Already Done

1. ✅ **Repository Setup**: GitHub repository configured with main and dev branches
2. ✅ **CI/CD Pipeline**: GitHub Actions workflows created
3. ✅ **Application**: React frontend and Node.js backend with Docker containers
4. ✅ **GitHub Secrets**: Placeholder secrets created (need to update with real values)
5. ✅ **Webhook Server**: Local deployment server configured

## 🔧 Immediate Next Steps

### 1. Update GitHub Secrets with Real Values

```bash
# Run the helper script to update Docker Hub credentials
./update-secrets.sh
```

### 2. Start ngrok and Update Webhook URL

```bash
# Start ngrok in a new terminal
ngrok http 8000

# In another terminal, update the webhook URL
./update-webhook-url.sh
```

### 3. Set up GitHub Repository Webhook

1. Go to: https://github.com/Bardakor/DevOps/settings/hooks
2. Click "Add webhook"
3. Paste the ngrok URL from the script output
4. Set Content type to `application/json`
5. Select "Just the push event"
6. Click "Add webhook"

### 4. Start the Local Webhook Server

```bash
cd local-webhook-listening-server
npm install
node local-webhook-listening-server.js
```

### 5. Test the Application Locally

```bash
# Using Docker Compose
export DOCKER_USERNAME=your_dockerhub_username
docker-compose up -d

# Access the application
# Frontend: http://localhost:3000
# Backend: http://localhost:3001/api/health
```

## 🧪 Testing the CI/CD Pipeline

### Test Dev Branch Workflow

```bash
# Create a feature branch
git checkout -b feature/test-pipeline

# Make a small change
echo "console.log('Testing CI/CD');" >> backend/server.js

# Commit and push
git add .
git commit -m "test: Add test log for CI/CD pipeline"
git push origin feature/test-pipeline

# Create a pull request to dev branch
gh pr create --base dev --title "Test CI/CD Pipeline" --body "Testing the CI/CD pipeline"
```

### Test Production Deployment

```bash
# Merge to main to trigger production deployment
git checkout main
git merge dev
git push origin main
```

## 📊 Monitor the Pipeline

1. **GitHub Actions**: https://github.com/Bardakor/DevOps/actions
2. **Webhook Server Logs**: Check the terminal running the webhook server
3. **Application Logs**: `docker-compose logs -f`

## 🛠️ Useful Commands

### Update Individual Secrets
```bash
gh secret set DOCKER_USERNAME --body "your_actual_username"
gh secret set DOCKER_PASSWORD --body "your_actual_password"
gh secret set WEBHOOK_URL --body "https://your-ngrok-url.ngrok.io/webhook"
```

### Docker Commands
```bash
# View running containers
docker ps

# View logs
docker-compose logs -f

# Restart services
docker-compose restart

# Clean up
docker-compose down
docker system prune -a
```

### Git Commands
```bash
# Check branch status
git status

# View recent commits
git log --oneline -10

# Switch branches
git checkout dev
git checkout main
```

## 🔍 Troubleshooting

### If CI/CD fails:
1. Check GitHub Actions logs
2. Verify all secrets are set correctly
3. Ensure Docker Hub repository exists
4. Check webhook server is running

### If webhook doesn't trigger:
1. Verify ngrok is running: `http://localhost:4040`
2. Check GitHub webhook configuration
3. Ensure webhook server is listening on port 8000

### If Docker build fails:
1. Check Dockerfile syntax
2. Verify package.json dependencies
3. Run `docker-compose build` locally first

## 📞 Support

- Check the main README.md for detailed documentation
- Review GitHub Actions logs for specific error messages
- Ensure all prerequisites are installed (Node.js, Docker, ngrok)

---

🎉 **Your DevOps CI/CD Pipeline is ready!** Follow these steps and you'll have a fully automated deployment system. 