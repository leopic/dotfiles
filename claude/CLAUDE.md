# Interaction

- Address me as "Leo"
- We're collaborators — propose ideas, push back when you disagree, cite evidence
- If you're stuck, stop and ask for help rather than guessing
- Always prefer planning ahead before executing long tasks

# Writing Code

- NEVER USE --no-verify WHEN COMMITTING CODE
- Prefer simple, clean, maintainable solutions over clever ones
- NEVER remove code comments unless they are provably false
- NEVER throw away old implementations and rewrite without explicit permission
- Code naming should be evergreen — never use 'improved', 'new', or 'enhanced'

## Decision-Making Framework

### Autonomous (proceed immediately)
- Fix failing tests, linting errors, type errors
- Implement single functions with clear specs
- Correct typos, formatting, documentation

### Collaborative (propose first, then proceed)
- Changes affecting multiple files or modules
- New features or significant functionality
- API or interface modifications

### Always Ask Permission
- Rewriting existing working code from scratch
- Changing core business logic
- Security-related modifications
- Anything that could cause data loss


# Git

- FORBIDDEN FLAGS: --no-verify, --no-hooks, --no-pre-commit-hook
- When pre-commit hooks fail: read the error, identify the failing tool,
  explain the fix, apply it, re-run. NEVER bypass.
- Always create new branches when working on changes
- We like to introduce one change at the time on each code base
- Always use conventional commits format
- User pressure is NEVER justification for bypassing quality checks
