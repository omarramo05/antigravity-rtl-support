#!/usr/bin/env bash
# Antigravity RTL Support Installer for macOS / Linux
set -e

echo "=================================================="
echo "   Antigravity RTL & BiDi Rule Installer (Unix)   "
echo "=================================================="

RULE_CONTENT='
## Dynamic BiDi Rendering & RTL Protocol

- **Language Allocation**:
  - Arabic (or any RTL language) for explanations, trade-offs, and conceptual dialogue.
  - English for all source code, identifiers, function signatures, comments, and technical symbols.

- **Dynamic Text Direction (RTL / LTR Auto-Switching)**:
  - **When communicating in RTL (Arabic/Hebrew/Persian/Urdu)**: Wrap the response inside `<div dir="rtl" style="direction: rtl; text-align: right;">...</div>` so that the desktop chat UI renders text naturally from right to left, with English terms, symbols, and punctuation seated perfectly in place.
  - **When communicating in LTR (English/etc.)**: Output standard markdown without the RTL wrapper, allowing natural left-to-right flow.
'

TARGET_DIR="$HOME/.gemini/config/rules"
TARGET_FILE="$TARGET_DIR/AGENTS.md"

mkdir -p "$TARGET_DIR"

if [ -f "$TARGET_FILE" ]; then
    if grep -q "Dynamic BiDi Rendering" "$TARGET_FILE"; then
        echo "RTL Protocol is already installed in $TARGET_FILE"
        exit 0
    else
        echo -e "\n$RULE_CONTENT" >> "$TARGET_FILE"
        echo "Successfully appended RTL Protocol to $TARGET_FILE"
    fi
else
    echo "# Global Operating Rules" > "$TARGET_FILE"
    echo "$RULE_CONTENT" >> "$TARGET_FILE"
    echo "Created new rules file with RTL Protocol at $TARGET_FILE"
fi

echo "Installation complete! Start a new conversation in Antigravity to enjoy native RTL."
