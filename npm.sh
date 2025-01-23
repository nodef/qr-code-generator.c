#!/usr/bin/env bash
if [[ "$1" != "publish" ]]; then
  echo "This script is only for publishing to npm."
  exit 1
fi
mv Readme.markdown Readme.markdown.log
cp c/Readme.markdown README.md
npm publish
rm README.md
mv Readme.markdown.log Readme.markdown
