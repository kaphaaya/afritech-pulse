#!/bin/bash

# ─── CONFIGURATION ───────────────────────────────────────
RESOURCE_GROUP="afritech-pulse-rg"
STORAGE_ACCOUNT="afritechpulse$(date +%s)"  # Unique name using timestamp
LOCATION="westeurope"                         # Closest Azure region to Nigeria
# ─────────────────────────────────────────────────────────

echo "🌍 Deploying AfriTech Pulse to Azure..."

# Step 1: Create Resource Group
echo "📦 Creating resource group..."
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION

# Step 2: Create Storage Account
echo "🗄️ Creating storage account..."
az storage account create \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku Standard_LRS \
  --kind StorageV2

# Step 3: Enable Static Website Hosting
echo "🌐 Enabling static website hosting..."
az storage blob service-properties update \
  --account-name $STORAGE_ACCOUNT \
  --static-website \
  --index-document index.html \
  --404-document index.html

# Step 4: Upload index.html
echo "⬆️ Uploading site files..."
az storage blob upload \
  --account-name $STORAGE_ACCOUNT \
  --container-name '$web' \
  --name index.html \
  --file index.html \
  --content-type "text/html" \
  --overwrite

# Step 5: Get the live URL
echo ""
echo "✅ DEPLOYMENT COMPLETE!"
echo "🔗 Your live site URL:"
az storage account show \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --query "primaryEndpoints.web" \
  --output tsv

# Save storage account name for GitHub Actions
echo ""
echo "📋 SAVE THIS — you'll need it for GitHub Actions:"
echo "STORAGE_ACCOUNT_NAME=$STORAGE_ACCOUNT"