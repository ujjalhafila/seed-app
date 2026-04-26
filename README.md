# Seed — Process Intelligence

A complete AI-powered process intelligence platform for product development teams.

## Live app
Deployed at: https://seed-app.vercel.app

## Stack
- Pure static HTML (no build step)
- Auth: Supabase (Google + GitHub OAuth)
- AI: Anthropic Claude API (claude-sonnet-4)
- Hosting: Vercel
- Connectors: GitHub, Notion, Jira, Linear, Figma

## Local development
Just open `index.html` in a browser. No build needed.

## Configure auth
1. Create project at supabase.com
2. Enable Google + GitHub OAuth providers  
3. Open the app → click "Configure Supabase" at login screen
4. Paste your Supabase URL + anon key
