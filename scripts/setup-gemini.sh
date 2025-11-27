#!/bin/bash

# This script sets up the Gemini para-programming environment.

# Create the ~/.gemini directory if it doesn't exist
mkdir -p ~/.gemini

# Copy the GEMINI.md file to the ~/.gemini directory
cp gemini/GEMINI.md ~/.gemini/GEMINI.md

echo "Gemini para-programming environment setup complete."
echo "To initialize a project, run the following command in your project's root directory:"
echo "cp gemini/templates/para-programming-prompt.md GEMINI.md"
