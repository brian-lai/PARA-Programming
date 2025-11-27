# PARA-Programming with Gemini

This guide explains how to use the PARA-Programming methodology with Google's Gemini models.

## Introduction

PARA-Programming is a structured approach to AI-assisted development that helps you maintain context, manage complexity, and collaborate effectively with your AI assistant. This guide focuses on implementing the PARA-Programming workflow using Gemini.

## The PARA-Programming Workflow

The core of PARA-Programming is a five-step workflow:

1.  **Plan:** Define the task and create a plan.
2.  **Review:** Share the plan with your AI assistant and refine it.
3.  **Execute:** Work through the plan with your AI assistant, one step at a time.
4.  **Summarize:** Create a summary of the work done.
5.  **Archive:** Archive the context for future reference.

## Getting Started

To get started with PARA-Programming with Gemini, you'll need to set up your environment.

### Global Setup

1.  Run the `setup-gemini` script to create the global `~/.gemini/GEMINI.md` file:

    ```bash
    make setup-gemini
    ```

### Project Initialization

1.  In your project's root directory, create a `GEMINI.md` file. This file will provide Gemini with project-specific context. You can use the `para-init-gemini` command to create this file:

    ```bash
    para-init-gemini
    ```

2.  Commit the `GEMINI.md` file to your project's version control.

## Using Gemini for PARA-Programming

When you start a para-programming session with Gemini, you should provide it with the content of your project's `GEMINI.md` file. This will give Gemini the context it needs to help you with your task.

You can use the `para-programming-prompt.md` template in the `gemini/templates` directory as a starting point for your prompts.
