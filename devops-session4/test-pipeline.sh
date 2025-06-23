#!/bin/bash

echo "🧪 Testing DevOps CI/CD Pipeline"
echo "================================"

echo ""
echo "🔍 Checking application status..."

# Check backend
echo -n "Backend API: "
if curl -s http://localhost:3001/api/health > /dev/null; then
    echo "✅ Running"
    curl -s http://localhost:3001/api/health | jq -r '.message'
else
    echo "❌ Not responding"
fi

# Check frontend
echo -n "Frontend: "
if curl -s http://localhost:3000 > /dev/null; then
    echo "✅ Running"
else
    echo "❌ Not responding"
fi

# Check webhook server
echo -n "Webhook Server: "
if curl -s http://localhost:8000/webhook -X POST -H "Content-Type: application/json" -d '{"test": true}' > /dev/null; then
    echo "✅ Running"
else
    echo "❌ Not responding"
fi

# Check ngrok
echo -n "ngrok Tunnel: "
if curl -s http://localhost:4040/api/tunnels | grep -q "ngrok-free.app"; then
    NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | grep -o 'https://[^"]*\.ngrok-free\.app')
    echo "✅ Running - $NGROK_URL"
else
    echo "❌ Not running"
fi

echo ""
echo "🔗 Application URLs:"
echo "Frontend: http://localhost:3000"
echo "Backend: http://localhost:3001/api/health"
echo "ngrok Web UI: http://localhost:4040"

echo ""
echo "📋 Next Steps to Complete Setup:"
echo "1. Set up GitHub webhook at: https://github.com/Bardakor/DevOps/settings/hooks"
echo "   - Payload URL: https://11ec-90-90-97-173.ngrok-free.app/webhook"
echo "   - Content type: application/json"
echo "   - Events: Just the push event"
echo ""
echo "2. Test the CI/CD pipeline:"
echo "   git checkout -b feature/test"
echo "   echo '// Test change' >> backend/server.js"
echo "   git add . && git commit -m 'test: CI/CD pipeline'"
echo "   git push origin feature/test"
echo "   gh pr create --base dev --title 'Test Pipeline'"
echo ""
echo "3. After PR is approved and merged to dev, merge to main:"
echo "   git checkout main && git merge dev && git push origin main"
echo ""
echo "🎉 Your DevOps CI/CD Pipeline is ready!" 