# CI/CD and Branch Protection Setup

## Overview
This repository has been configured with automated CI/CD checks to ensure code quality and prevent issues from being merged to the main branch.

## What Gets Checked

### 1. **ShellCheck Linting**
   - Checks for common shell script errors
   - Identifies potentially unsafe practices
   - Validates shell syntax

### 2. **Bash Syntax Validation**
   - Ensures all shell scripts have valid bash syntax
   - Prevents scripts with parse errors from being committed

### 3. **File Validation**
   - Detects trailing whitespace
   - Checks for proper line endings (LF, not CRLF)
   - Identifies tabs in shell scripts (prefers spaces)

### 4. **Markdown Linting**
   - Validates README.md and other documentation
   - Ensures consistent formatting

### 5. **Security Scanning**
   - Checks for hardcoded credentials
   - Warns about dangerous patterns (e.g., `eval`)

## GitHub Branch Protection Rules

To enforce these checks, follow these steps:

1. Go to your repository on GitHub
2. Click **Settings** → **Branches**
3. Under "Branch protection rules", click **Add rule**
4. Configure as follows:

   - **Branch name pattern**: `main`
   
   - **Require a pull request before merging**: ✓
     - **Require approvals**: 1 (optional)
     - **Require review from code owners**: ✓ (create `.github/CODEOWNERS` if needed)
   
   - **Require status checks to pass before merging**: ✓
     - Check the following required status checks:
       - `ShellCheck`
       - `Bash Syntax Check`
       - `File Validation`
       - `Markdown Lint`
       - `CI Status`
   
   - **Require branches to be up to date before merging**: ✓
   
   - **Require code reviews before merging**: ✓
   
   - **Restrict who can push to matching branches**: (Optional, for team workflows)

## Local Pre-commit Hook Setup

To run checks locally before committing:

```bash
chmod +x .github/hooks/pre-commit
cp .github/hooks/pre-commit .git/hooks/pre-commit
```

Now your commits will be validated before they're created.

## Workflow Triggers

The CI/CD pipeline runs automatically on:
- **Push events** to `main` and `develop` branches
- **Pull request events** targeting `main` and `develop` branches

## Example: Creating a Pull Request

1. Create a feature branch: `git checkout -b feature/my-feature`
2. Make your changes
3. Push to GitHub: `git push origin feature/my-feature`
4. Create a Pull Request
5. The CI/CD checks will run automatically
6. If all checks pass, the PR can be merged
7. If checks fail, you'll see detailed error messages

## Disabling Checks (Not Recommended)

If you need to bypass these checks (not recommended):
- For the pre-commit hook: `git commit --no-verify`
- For GitHub checks: You'd need to modify branch protection rules

## Troubleshooting

### ShellCheck Errors
Common issues and fixes:
- **SC2086**: Variable is unquoted → Use `"$variable"` instead of `$variable`
- **SC2181**: Check exit code after using `$?` → Use `if ! command; then` instead
- See [ShellCheck wiki](https://www.shellcheck.net/) for all error codes

### Trailing Whitespace
Remove all trailing whitespace:
```bash
find . -name "*.sh" -exec sed -i 's/[[:space:]]*$//' {} \;
```

### Line Ending Issues
Convert CRLF to LF:
```bash
find . -name "*.sh" -exec dos2unix {} \;
# or
find . -name "*.sh" -exec sed -i 's/\r$//' {} \;
```

## Next Steps

1. Commit and push these changes
2. Set up branch protection rules in GitHub
3. Test by creating a pull request with intentional errors to verify checks work
4. Update team members on the new requirements
