# GitHub Workflow

This document outlines the standard workflow for contributing to this project.

## Branch Structure
- `main`: Production branch (protected)
- `develop`: Main development branch
- `feature/*`: New features
- `fix/*`: Bug fixes
- `docs/*`: Documentation updates

## Development Workflow

1. Create a new branch from develop:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/your-feature
   ```

2. Make your changes and commit:
   - Use conventional commit messages
   - Follow the commit template

3. Push your branch and create a PR:
   ```bash
   git push origin feature/your-feature
   gh pr create --web
   ```

4. Review Process:
   - CI checks must pass
   - Code review required
   - Keep PRs focused and concise

## Using GitHub CLI

Common commands:
- `gh pr create`: Create a PR
- `gh pr checkout`: Check out a PR
- `gh pr review`: Review a PR
- `gh pr view`: View PR in browser

## Commit Message Format

```
<type>: <subject>

[optional body]

[optional footer]
```

Types:
- feat: New feature
- fix: Bug fix
- docs: Documentation
- style: Formatting
- refactor: Code restructuring
- test: Adding tests
- chore: Maintenance

