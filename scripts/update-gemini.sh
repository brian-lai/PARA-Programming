#!/bin/bash
# Deprecated: Use `pret install-skills` instead. See README.md for details.

# This script updates the Gemini pret-a-program environment.

# Create the ~/.gemini directory if it doesn't exist
mkdir -p ~/.gemini

# Copy the GEMINI.md file to the ~/.gemini directory
cp gemini/GEMINI.md ~/.gemini/GEMINI.md

echo "Gemini pret-a-program environment updated."
