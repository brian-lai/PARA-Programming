# Homebrew Distribution

This directory contains the Homebrew formula for Pret-a-Program.

## Installation

### Via Homebrew Tap

```bash
brew tap brian-lai/pret-a-program
brew install pret-a-program
```

### Direct Formula

```bash
brew install brian-lai/pret-a-program
```

## How It Works

The formula installs:
- `pret` binary to `$(brew --prefix)/bin/`
- Library files to `$(brew --prefix)/libexec/pret-a-program/`
- Templates to `$(brew --prefix)/share/pret-a-program/templates/`
- Skills to `$(brew --prefix)/share/pret-a-program/skills/`
- Bash/Zsh completions to standard Homebrew completion directories

Path resolution in the `pret` script is updated by `inreplace` during installation so the CLI finds its library and template files.

## Publishing a Release

1. Tag a release: `git tag v2.0.0 && git push --tags`
2. Create a GitHub release from the tag
3. Get the tarball SHA256: `curl -sL https://github.com/brian-lai/pret-a-program/archive/refs/tags/v2.0.0.tar.gz | shasum -a 256`
4. Update the `sha256` in `Formula/pret-a-program.rb`
5. Copy the formula to the tap repository: `brian-lai/homebrew-pret-a-program`

## Tap Repository

The Homebrew tap is a separate repository: [brian-lai/homebrew-pret-a-program](https://github.com/brian-lai/homebrew-pret-a-program)

This must be created manually on GitHub. The formula file here serves as the source.
