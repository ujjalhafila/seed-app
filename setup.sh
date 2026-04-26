#!/bin/bash
# Run this once from your local machine to set up the GitHub repo + Vercel deployment
# Usage: GH_TOKEN=your_token bash setup.sh

set -e
GH_TOKEN=${GH_TOKEN:-}
GH_USER="ujjalhafila"
REPO_NAME="seed-app"
VERCEL_PROJECT_ID="prj_GEcv48HXlM7tompHwg1gmM1Su7N0"
VERCEL_TEAM_ID="team_1RdvhvtUeCQ4gGSQcMefn7yC"

echo "🌱 Seed — GitHub + Vercel setup"
echo ""

# Step 1: Create GitHub repo
echo "1/4 Creating GitHub repository..."
curl -s -X POST   -H "Authorization: token $GH_TOKEN"   -H "Accept: application/vnd.github.v3+json"   -H "Content-Type: application/json"   https://api.github.com/user/repos   -d "{
    \"name\": \"$REPO_NAME\",
    \"description\": \"Seed — Process Intelligence Platform\",
    \"private\": false,
    \"auto_init\": false
  }" | python3 -c "import sys,json; d=json.load(sys.stdin); print('✓ Repo:', d.get('html_url', d.get('message','error')))"

# Step 2: Push code
echo "2/4 Pushing code to GitHub..."
cd "$(dirname $0)"
git init -q
git add -A
git -c user.email="ujjalhafila@gmail.com" -c user.name="Ujjal" commit -qm "feat: Seed v1 — complete process intelligence platform"
git branch -M main
git remote add origin "https://x-access-token:${GH_TOKEN}@github.com/${GH_USER}/${REPO_NAME}.git" 2>/dev/null ||   git remote set-url origin "https://x-access-token:${GH_TOKEN}@github.com/${GH_USER}/${REPO_NAME}.git"
git push -u origin main --force
echo "✓ Code pushed to github.com/${GH_USER}/${REPO_NAME}"

# Step 3: Connect repo to Vercel project via Vercel API
echo "3/4 Connecting GitHub repo to Vercel..."
VERCEL_TOKEN=$(cat ~/.local/share/com.vercel.cli/auth.json 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('token',''))" 2>/dev/null)
if [ -z "$VERCEL_TOKEN" ]; then
  echo "   (Run 'vercel login' first if git connection fails)"
fi
vercel link --project $REPO_NAME --yes 2>/dev/null || true

# Step 4: Deploy to production
echo "4/4 Deploying to Vercel..."
npx vercel deploy --prod --yes
echo ""
echo "✅ Seed is live!"
echo "   GitHub: https://github.com/${GH_USER}/${REPO_NAME}"
echo "   Vercel: https://seed-app.vercel.app"
echo ""
echo "Next: configure Supabase auth at supabase.com"
