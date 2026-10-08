#!/bin/bash

npx marp Slides.md --theme ./stellar-bloom-marp.css -o Slides.html
npx marp Slides.md --theme ./stellar-bloom-marp.css --pdf -o Slides.pdf
npx marp Slides.md --theme ./stellar-bloom-marp.css --pptx -o Slides.pptx
