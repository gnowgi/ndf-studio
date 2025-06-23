#!/bin/bash

# Start the NDF Studio backend server
# This script sets the correct PYTHONPATH and starts the uvicorn server

echo "Starting NDF Studio Backend..."

# Check if we're in the correct virtual environment
if [[ "$VIRTUAL_ENV" != *"ndf-studio"* ]]; then
    echo "❌ Error: Not running in the correct virtual environment!"
    echo "Please activate the virtual environment first:"
    echo "  source venv/bin/activate"
    echo ""
    echo "Then run this script again."
    exit 1
fi

echo "✅ Virtual environment check passed: $VIRTUAL_ENV"

# Check if we're in the correct directory
if [[ ! -f "backend/main.py" ]]; then
    echo "❌ Error: Not in the correct directory!"
    echo "Please run this script from the ndf-studio root directory."
    exit 1
fi

echo "✅ Directory check passed"

# Kill any existing uvicorn processes
echo "🔄 Stopping any existing backend processes..."
pkill -f uvicorn

# Start the backend server
echo "🚀 Starting backend server..."
echo "Setting PYTHONPATH to include backend directory..."

PYTHONPATH=/home/nagarjun/dev/ndf-studio/backend python -m uvicorn backend.main:app --reload --host 0.0.0.0 --port 8000 