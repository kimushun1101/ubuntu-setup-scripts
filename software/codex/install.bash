#!/bin/bash -eu
echo -e "\033[32mInstall : OpenAI Codex CLI\033[m"
# Codex CLI requires Node.js / npm. Install nodejs via nvm or nodesource first if needed.
if ! command -v npm &> /dev/null; then
  echo -e "\033[31mnpm not found. Please install Node.js first (e.g., via nvm or nodesource).\033[m"
  exit 1
fi
npm install -g @openai/codex
