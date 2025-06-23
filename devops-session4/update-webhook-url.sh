#!/bin/bash

echo "🔗 Getting ngrok URL..."

# Get the ngrok URL
NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | grep -o 'https://[^"]*\.ngrok\.io')

if [ -z "$NGROK_URL" ]; then
    echo "❌ Could not get ngrok URL. Make sure ngrok is running with 'ngrok http 8000'"
    exit 1
fi

WEBHOOK_URL="${NGROK_URL}/webhook"

echo "✅ Found ngrok URL: $WEBHOOK_URL"

# Update GitHub secret
echo "🔧 Updating GitHub WEBHOOK_URL secret..."
gh secret set WEBHOOK_URL --body "$WEBHOOK_URL"

if [ $? -eq 0 ]; then
    echo "✅ GitHub WEBHOOK_URL secret updated successfully!"
    echo "🔗 Webhook URL: $WEBHOOK_URL"
else
    echo "❌ Failed to update GitHub secret"
    exit 1
fi

echo ""
echo "📋 Next steps:"
echo "1. Go to your GitHub repository: https://github.com/Bardakor/DevOps"
echo "2. Go to Settings → Webhooks"
echo "3. Add a new webhook with URL: $WEBHOOK_URL"
echo "4. Set Content type to 'application/json'"
echo "5. Select 'Just the push event'"
echo "6. Make sure the webhook is active"

# Create a test feature
git checkout -b feature/test
echo "// Test CI/CD pipeline" >> backend/server.js
git add . && git commit -m "test: CI/CD pipeline"
git push origin feature/test

# Create PR to dev (will trigger CI checks)
gh pr create --base dev --title "Test Pipeline"

# After PR approval, merge to main (will trigger deployment)
git checkout main && git merge dev && git push origin main 