# Quickstart: PARA-Programming with Gemini

This guide provides a 5-minute setup for using the PARA-Programming methodology with Gemini.

## 1. Install the PARA-Programming Scripts

Clone the `para-programming` repository and run the setup script for Gemini:

```bash
git clone https://github.com/your-username/para-programming.git
cd para-programming
make setup-gemini
```

This will create the global `~/.gemini/GEMINI.md` file, which contains the core PARA-Programming workflow.

## 2. Initialize Your Project

In your project's root directory, run the `para-init-gemini` command to create a `GEMINI.md` file:

```bash
para-init-gemini
```

This file will provide Gemini with project-specific context.

## 3. Start a Para-Programming Session

When you start a para-programming session with Gemini, provide it with the content of your project's `GEMINI.md` file. You can use the `para-programming-prompt.md` template in the `gemini/templates` directory as a starting point for your prompts.

That's it! You're now ready to start using the PARA-Programming methodology with Gemini.
