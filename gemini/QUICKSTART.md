# Quickstart: Pret-a-Program with Gemini

This guide provides a 5-minute setup for using the Pret-a-Program methodology with Gemini.

## 1. Install the Pret-a-Program Scripts

Clone the `pret-a-program` repository and run the setup script for Gemini:

```bash
git clone https://github.com/your-username/pret-a-program.git
cd pret-a-program
make setup-gemini
```

This will create the global `~/.gemini/GEMINI.md` file, which contains the core Pret-a-Program workflow.

## 2. Initialize Your Project

In your project's root directory, run the `para-init-gemini` command to create a `GEMINI.md` file:

```bash
para-init-gemini
```

This file will provide Gemini with project-specific context.

## 3. Start a Para-Programming Session

When you start a pret-a-program session with Gemini, provide it with the content of your project's `GEMINI.md` file. You can use the `pret-a-program-prompt.md` template in the `gemini/templates` directory as a starting point for your prompts.

That's it! You're now ready to start using the Pret-a-Program methodology with Gemini.
