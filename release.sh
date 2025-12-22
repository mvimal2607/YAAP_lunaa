#!/bin/bash

# --- CONFIGURATION ---
REPO="mvimal2607/YAAP_lunaa"
PRODUCT_DIR="out/target/product/lunaa"

# Find the newest ZIP file
ZIP_PATH=$(ls -t ${PRODUCT_DIR}/YAAP-16-HOMEMADE-*.zip 2>/dev/null | grep -v ".sha256sum" | head -n 1)

if [ -z "$ZIP_PATH" ]; then
    echo "Error: No YAAP zip file found in $PRODUCT_DIR"
    exit 1
fi

# Define the matching SHA256 file path
SHA_PATH="${ZIP_PATH}.sha256sum"

if [ ! -f "$SHA_PATH" ]; then
    echo "Warning: SHA256 file not found at $SHA_PATH"
fi

# Extract date for the Tag (assuming format YAAP-16-HOMEMADE-lunaa-YYYYMMDD.zip)
RELEASE_DATE=$(basename "$ZIP_PATH" | grep -oP '\d{8}')
TAG_NAME="YAAP-16-${RELEASE_DATE}"
RELEASE_TITLE="YAAP for Realme GT Master Edition [RMX3360/61/63] (lunaa)"

# --- UPLOAD ---
echo "Uploading Release: $TAG_NAME"
echo "ZIP: $(basename "$ZIP_PATH")"
echo "SHA: $(basename "$SHA_PATH")"

gh release create "$TAG_NAME" \
    --repo "$REPO" \
    --title "$RELEASE_TITLE" \
    --notes "Synced with latest source." \
    "$ZIP_PATH" \
    "$SHA_PATH"

echo "Upload Completed!"
