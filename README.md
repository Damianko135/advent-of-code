# Advent of Code Solutions

A repository containing solutions to [Advent of Code](https://adventofcode.com) challenges across multiple years (2015-2025).

## Repository Structure

This repository is organized by year and day:
```
├── 2015/
│   ├── day1/
│   ├── day2/
│   └── ...
├── 2016/
├── 2017/
├── 2018/
├── 2019/
├── 2020/
├── 2021/
├── 2022/
├── 2023/
├── 2024/
└── 2025/
```

Each day typically contains shell scripts for solving both part 1 and part 2 of that day's challenge.

## CI/CD Pipeline

This repository includes a comprehensive CI/CD pipeline that ensures code quality through automated checks:

### Workflow: Lint and Code Quality (`lint.yml`)

The workflow runs on:
- Push events to `main` and `develop` branches
- Pull requests to `main` and `develop` branches

#### Checks Performed:

1. **ShellCheck** - Analyzes shell scripts for errors and best practices
   - Runs with style warnings enabled
   - Reports potential issues in shell script syntax and usage

2. **Shebang Validation** - Ensures all shell scripts have proper shebangs
   - Verifies all `.sh` files start with `#!/bin/bash` or similar

3. **File Validation** - Checks for file quality issues
   - Detects trailing whitespace
   - Flags tabs in shell scripts (spaces are preferred)
   - Validates line endings (LF only, no CRLF)

4. **Markdown Linting** - Validates markdown files
   - Checks markdown syntax and formatting
   - Uses `markdownlint-cli`

5. **Security Scanning** - Looks for common security issues
   - Checks for hardcoded credentials (warnings only)
   - Identifies use of `eval` (warnings only)
   - Non-blocking checks to catch potential issues

6. **CI Status** - Aggregates results from all checks
   - Ensures all required checks pass before allowing merges

## Setup

### Local Development

To set up the repository locally:

```bash
git clone https://github.com/Damianko135/advent-of-code.git
cd advent-of-code
```

### Testing Workflows Locally

You can test the CI workflows locally using [Act](https://github.com/nektos/act):

```bash
# Install act (if not already installed)
# On Linux: https://github.com/nektos/act#installation
# On macOS: brew install act
# On Windows: choco install act-cli

# Run all workflows
sudo act --rm

# Run a specific job
sudo act --rm -j shellcheck

# List all available jobs
act -l
```

## Contributing

When contributing to this repository, ensure:

1. All shell scripts have proper shebangs (`#!/bin/bash`)
2. No trailing whitespace in files
3. Use spaces instead of tabs in shell scripts
4. Use LF line endings (not CRLF)
5. Valid markdown formatting

The CI pipeline will automatically check these when you submit a pull request.

## Advent of Code

[Advent of Code](https://adventofcode.com) is an Advent calendar of small programming puzzles by Eric Wastl.
Each puzzle takes about 15 minutes to understand and solve, and participants can use any programming language.

## License

This repository contains personal solutions to Advent of Code challenges.
