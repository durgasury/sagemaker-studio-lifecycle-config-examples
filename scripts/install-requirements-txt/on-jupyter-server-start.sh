# This script installs a requirements file if exists, on KernelGateway starts.
#!/bin/bash

set -eux
FILE=requirements.txt
if test -f "$FILE"; then
    echo "Found requirements file. Installing packages.."
    pip install -r requirements.txt
    echo "Packages installed. Starting default app."
else
    echo "No requirements file found. Starting default app."
fi
