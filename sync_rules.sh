#!/bin/bash
# clear existing remote rules to avoid stale ones
rm .cursor/rules/remote-*.mdc 2>/dev/null

# Read URLs from json and download them
# Requires 'jq' installed, or use a python script equivalent
jq -r '.rules[]' .cursor/rules-manifest.json | while read url; do
    filename=$(basename "$url")
    curl -s "$url" -o ".cursor/rules/remote-$filename"
    echo "Synced: $filename"
done
