#!/bin/bash

echo "🔐 GitHub Secrets Update Helper"
echo "================================"
echo ""
echo "This script will help you update GitHub secrets with your actual values."
echo "Press Ctrl+C to cancel at any time."
echo ""

read -p "Enter your Docker Hub username: " DOCKER_USERNAME
read -s -p "Enter your Docker Hub password/token: " DOCKER_PASSWORD
echo ""

read -p "Enter your Snyk token (optional, press Enter to skip): " SNYK_TOKEN

echo ""
echo "🔧 Updating GitHub secrets..."

# Update Docker Hub credentials
gh secret set DOCKER_USERNAME --body "$DOCKER_USERNAME"
echo "✅ Updated DOCKER_USERNAME"

gh secret set DOCKER_PASSWORD --body "$DOCKER_PASSWORD"
echo "✅ Updated DOCKER_PASSWORD"

# Update Snyk token if provided
if [ -n "$SNYK_TOKEN" ]; then
    gh secret set SNYK_TOKEN --body "$SNYK_TOKEN"
    echo "✅ Updated SNYK_TOKEN"
fi

echo ""
echo "✅ Secrets updated successfully!"
echo ""
echo "📋 Remember to also:"
echo "1. Update the webhook URL using: ./update-webhook-url.sh"
echo "2. Update other secrets as needed (DATABASE_URL, JWT_SECRET, API_KEY)"
echo "3. Set up your Docker Hub repository" 