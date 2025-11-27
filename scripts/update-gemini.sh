#!/bin/bash

# This script updates the Gemini para-programming environment.

# Create the ~/.gemini directory if it doesn't exist
mkdir -p ~/.gemini

# Copy the GEMINI.md file to the ~/.gemini directory
cp gemini/GEMINI.md ~/.gemini/GEMINI.md

echo "Gemini para-programming environment updated."
