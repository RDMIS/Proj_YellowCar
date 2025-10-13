#!/bin/bash
# ==============================================
# My Farm App - FlutterFlow + Firebase Repo Setup
# ==============================================
# Usage: bash create_myfarm_repo.sh
# Creates directory structure + key placeholder files
# Compatible with macOS / Linux

set -e

REPO_NAME="Proj_YellowCar"
mkdir -p "$REPO_NAME"
cd "$REPO_NAME"

# ---- App (FlutterFlow export) ----
mkdir -p app/lib
touch app/pubspec.yaml

# ---- Cloud Functions ----
mkdir -p functions/src
cat <<'EOF' > functions/src/index.ts
// index.ts placeholder (see Solo Builder Kit for full version)
EOF

cat <<'EOF' > functions/src/inventory.ts
// inventory.ts placeholder (see Solo Builder Kit for full version)
EOF

cat <<'EOF' > functions/package.json
{
  "name": "myfarm-functions",
  "engines": {"node": "20"},
  "scripts": {
    "build": "tsc -p .",
    "serve": "firebase emulators:start",
    "deploy": "firebase deploy --only functions",
    "lint": "eslint src --ext .ts"
  },
  "dependencies": {
    "firebase-admin": "^12.0.0",
    "firebase-functions": "^5.0.0"
  },
  "devDependencies": {
    "typescript": "^5.4.0",
    "eslint": "^9.0.0",
    "@typescript-eslint/parser": "^7.0.0",
    "@typescript-eslint/eslint-plugin": "^7.0.0"
  }
}
EOF

cat <<'EOF' > functions/tsconfig.json
{
  "compilerOptions": {
    "module": "commonjs",
    "target": "es2020",
    "lib": ["es2020"],
    "outDir": "lib",
    "rootDir": "src",
    "strict": true,
    "esModuleInterop": true,
    "resolveJsonModule": true
  },
  "include": ["src"]
}
EOF

# ---- Firebase Config ----
mkdir -p firebase
cat <<'EOF' > firebase/.firebaserc
{
  "projects": {
    "default": "myfarm-dev",
    "dev": "myfarm-dev",
    "prod": "myfarm"
  }
}
EOF

cat <<'EOF' > firebase/firebase.json
{
  "functions": {
    "source": "functions",
    "runtime": "nodejs20"
  },
  "hosting": [{
    "target": "web-app",
    "public": "app/build/web",
    "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
    "rewrites": [{"source": "**", "destination": "/index.html"}]
  }],
  "firestore": {
    "rules": "firebase/firestore.rules",
    "indexes": "firebase/firestore.indexes.json"
  },
  "storage": {
    "rules": "firebase/storage.rules"
  }
}
EOF

touch firebase/firestore.rules
touch firebase/storage.rules
touch firebase/firestore.indexes.json

# ---- Docs & Git ----
mkdir -p docs
echo "# My Farm App Docs" > docs/architecture.md
echo "# Backlog" > docs/backlog.md
echo "# Rituals Log" > docs/rituals.md

mkdir -p .gitlab/issue_templates .gitlab/merge_request_templates
cat <<'EOF' > .gitlab/issue_templates/Feature.md
### Summary
### Acceptance Criteria
- [ ]
### Notes/Design
### Out of Scope
EOF

cat <<'EOF' > .gitlab/issue_templates/Bug.md
### What happened
### Expected
### Repro Steps
1. 
### Screens/Logs
EOF

cat <<'EOF' > .gitlab/merge_request_templates/Default.md
## What
## Why
## Test Plan
- [ ] Emulators green
- [ ] Mobile smoke tested
## Checklist
- [ ] Conventional commit title
- [ ] Added/updated docs if needed
EOF

# ---- Root Files ----
cat <<'EOF' > README.md
# My Farm App (MVP)
Stack: FlutterFlow + Firebase (Auth, Firestore, Storage, Functions)
EOF

touch .gitignore .editorconfig .env.sample

cat <<'EOF' > .gitlab-ci.yml
stages: [test, build, deploy]
# CI placeholder; full content in Solo Builder Kit doc
EOF

echo "✅ Repository structure created successfully in $(pwd)"
