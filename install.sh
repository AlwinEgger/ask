#!/bin/bash

# install.sh - Install ask CLI tool system-wide

set -euo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "Installing 'ask' CLI tool..."

# Check if script exists
if [ ! -f "ask" ]; then
    echo "Error: 'ask' script not found in current directory" >&2
    exit 1
fi

# Make executable
chmod +x ask

# Install to /usr/local/bin
echo "Installing to /usr/local/bin/ask (requires sudo)..."
sudo cp ask /usr/local/bin/

echo -e "${GREEN}✓ Installation complete!${NC}"
echo

# Check opencode config
CONFIG_FILE="${OPENCODE_CONFIG:-$HOME/.config/opencode/opencode.json}"
if [ -f "$CONFIG_FILE" ]; then
    if jq -e '.provider.infomaniak' "$CONFIG_FILE" >/dev/null 2>&1; then
        echo -e "${GREEN}✓ Infomaniak provider found in opencode config${NC}"
    else
        echo -e "${YELLOW}⚠ Warning: Infomaniak provider not found in $CONFIG_FILE${NC}"
        echo "  Ensure your opencode config includes the Infomaniak provider."
    fi
else
    echo -e "${YELLOW}⚠ Warning: opencode config not found at $CONFIG_FILE${NC}"
    echo "  Set OPENCODE_CONFIG or create ~/.config/opencode/opencode.json"
fi

echo
echo -e "${GREEN}Usage:${NC}"
echo "  ask 'What is 2+2?'"
echo "  ask -g 'Explain quantum computing'"
echo "  ask --help"
echo
echo "Configuration:"
echo "  Reads API credentials from ~/.config/opencode/opencode.json"
echo "  Set OPENCODE_CONFIG to use a different config file."
