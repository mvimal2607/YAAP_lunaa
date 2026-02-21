#!/bin/bash

# --- CONFIGURATION ---
REPO="mvimal2607/YAAP_lunaa"
PRODUCT_DIR="out/target/product/lunaa"

# --- FIND BUILD ARTIFACTS ---

# Find the newest ZIP file
ZIP_PATH=$(ls -t ${PRODUCT_DIR}/YAAP-16-HOMEMADE-*.zip 2>/dev/null | grep -v ".sha256sum" | head -n 1)

if [ -z "$ZIP_PATH" ]; then
    echo "Error: No YAAP zip file found in $PRODUCT_DIR"
    exit 1
fi

# Define the matching SHA256 file path
SHA_PATH="${ZIP_PATH}.sha256sum"

# Define Images Directory
IMAGES_DIR="${PRODUCT_DIR}/obj/PACKAGING/target_files_intermediates/yaap_lunaa-target_files/IMAGES"

# Define specific image paths
BOOT_IMG="${IMAGES_DIR}/boot.img"
VENDOR_BOOT_IMG="${IMAGES_DIR}/vendor_boot.img"
DTBO_IMG="${IMAGES_DIR}/dtbo.img"

# --- PREPARE UPLOAD LIST ---

# Initialize array with mandatory ZIP file
UPLOAD_FILES=("$ZIP_PATH")

# Add SHA if it exists
if [ -f "$SHA_PATH" ]; then
    UPLOAD_FILES+=("$SHA_PATH")
else
    echo "Warning: SHA256 file not found at $SHA_PATH (Skipping)"
fi

# Add Boot Image if it exists
if [ -f "$BOOT_IMG" ]; then
    UPLOAD_FILES+=("$BOOT_IMG")
    echo "Found: boot.img"
else
    echo "Warning: boot.img not found (Skipping)"
fi

# Add Vendor Boot Image if it exists
if [ -f "$VENDOR_BOOT_IMG" ]; then
    UPLOAD_FILES+=("$VENDOR_BOOT_IMG")
    echo "Found: vendor_boot.img"
else
    echo "Warning: vendor_boot.img not found (Skipping)"
fi

# Add DTBO Image if it exists
if [ -f "$DTBO_IMG" ]; then
    UPLOAD_FILES+=("$DTBO_IMG")
    echo "Found: dtbo.img"
else
    echo "Warning: dtbo.img not found (Skipping)"
fi

# --- EXTRACT METADATA ---

# Extract date for the Tag (assuming format YAAP-16-HOMEMADE-lunaa-YYYYMMDD.zip)
RELEASE_DATE=$(basename "$ZIP_PATH" | grep -oP '\d{8}')
TAG_NAME="YAAP-16-${RELEASE_DATE}"
RELEASE_TITLE="YAAP for Realme GT Master Edition [RMX3360/61/63] (lunaa)"

# --- UPLOAD ---

echo ""
echo "Uploading Release: $TAG_NAME"
echo "Files to upload:"
for file in "${UPLOAD_FILES[@]}"; do
    echo "  - $(basename "$file")"
done
echo ""

gh release create "$TAG_NAME" \
    --repo "$REPO" \
    --title "$RELEASE_TITLE" \
    --notes "Synced with latest source." \
    "${UPLOAD_FILES[@]}"

echo "Upload Completed!"
