#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <path-to-markdown-file>"
    exit 1
fi

SLIDES="$1"
BASE="${SLIDES%.md}"

npx marp "$SLIDES" --theme ./stellar-bloom-marp.css -o "${BASE}.html"
npx marp "$SLIDES" --theme ./stellar-bloom-marp.css --pdf -o "${BASE}.pdf"
npx marp "$SLIDES" --theme ./stellar-bloom-marp.css --pptx -o "${BASE}.pptx"
