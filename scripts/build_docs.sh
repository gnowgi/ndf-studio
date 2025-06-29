#!/bin/bash

# Build and optionally serve NDF Studio documentation

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Building NDF Studio Documentation...${NC}"

# Change to project root
cd "$(dirname "$0")/.."

# Activate virtual environment
source venv/bin/activate

# Build documentation
cd docs
echo -e "${YELLOW}Building documentation...${NC}"
mkdocs build

echo -e "${GREEN}✅ Documentation built successfully!${NC}"
echo -e "${YELLOW}📁 Output directory: docs/site/${NC}"

# Check if --serve flag is provided
if [[ "$1" == "--serve" ]]; then
    echo -e "${YELLOW}🚀 Starting documentation server...${NC}"
    echo -e "${GREEN}📖 Documentation available at: http://127.0.0.1:8001/nodeBook/${NC}"
    echo -e "${YELLOW}Press Ctrl+C to stop the server${NC}"
    mkdocs serve --dev-addr=127.0.0.1:8001
fi

echo -e "${GREEN}✨ Documentation build complete!${NC}" 