#!/bin/bash
npm init
npm install --save @marp-team/marp-cli@^4.5.1 @marp-team/marp-core@next
npm install --save \
  shiki \
  beautiful-mermaid \
  katex \
  @mathjax/src \
  @mathjax/mathjax-bbm-font-extension \
  @mathjax/mathjax-bboldx-font-extension \
  @mathjax/mathjax-dsfont-font-extension \
  @mathjax/mathjax-mhchem-font-extension
