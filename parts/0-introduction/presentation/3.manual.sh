#!/usr/bin/env bash

# Clone repositories
git submodule update --init --recursive

# Tag repositories with git run
gr +@demo frontend backend && gr +@frontend frontend && gr +@backend backend

# Install dependencies
gr @demo yarn

# Build application
gr @frontend yarn run build
