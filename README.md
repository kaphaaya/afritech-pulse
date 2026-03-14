# 🌍 AfriTech Pulse
### Africa's Premier AI & Technology Intelligence Hub

![Status](https://img.shields.io/badge/Status-Live%20on%20Azure-00A86B?style=for-the-badge)
![Azure](https://img.shields.io/badge/Azure-Blob%20Storage-0078D4?style=for-the-badge&logo=microsoft-azure)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?style=for-the-badge&logo=github-actions)

**🔗 Live Site:** https://afritechpulse1772406317.z6.web.core.windows.net/  
**📦 GitHub:** https://github.com/kaphaaya/afritech-pulse

---

## What Is This?

AfriTech Pulse is a live AI and technology news aggregation platform built specifically for Africa. It pulls real-time global tech news and developer stories, highlights Africa and Nigeria-specific content, and presents everything in a premium editorial interface — making quality tech intelligence accessible to African professionals, developers, and enthusiasts without paywalls.

The problem it solves is real. Africa is home to one of the world's fastest-growing tech ecosystems, yet most technology news platforms are Western-centric. African developers, founders, and professionals have no single reliable hub that covers global AI developments with African relevance, highlights Nigerian and African tech stories specifically, and presents them in a professional magazine-quality interface. AfriTech Pulse fills that gap.

---

## Architecture

```
USER'S BROWSER
      │
      │  Loads index.html
      ▼
AZURE BLOB STORAGE ($web container)
      │
      │  JavaScript runs in browser
      ▼
LIVE DATA SOURCES (no API key needed)
      ├── Hacker News Firebase API  →  Top tech stories
      ├── Dev.to API (AI tag)       →  AI articles
      ├── Dev.to API (Cloud tag)    →  Cloud articles
      └── Dev.to API (Webdev tag)   →  Web dev stories

─────────────────────────────────────

GITHUB (source code)
      │
      │  Push to main branch
      ▼
GITHUB ACTIONS
      │
      └── Login to Azure → Upload index.html → Live ✅
```

### Why Static?

AfriTech Pulse is a static site — HTML, CSS, and JavaScript with no server-side processing. All news data is fetched directly in the visitor's browser from free public APIs. This makes it fast, cost-effective, secure, and infinitely scalable.

---

## Tech Stack

| Layer | Technology | Purpose |
|---|---|---|
| Frontend | HTML5, CSS3, Vanilla JavaScript | Single-file static site |
| News Data | Hacker News API + Dev.to API | Live tech and AI news — no key needed |
| Hosting | Azure Blob Storage (Static Website) | Cloud hosting |
| Provisioning | Azure CLI + Bash Script | Infrastructure setup |
| CI/CD | GitHub Actions | Auto-deploy on every push |
| Version Control | Git + GitHub | Source code management |
| Fonts | Google Fonts (Playfair Display + Inter) | Premium editorial typography |

---

## Features

- 📰 **Live News Feed** — pulls real-time AI, tech, cloud, and developer stories
- 🌍 **Africa Spotlight** — dedicated section filtering Nigeria and Africa stories
- 🔴 **Breaking News Ticker** — scrolling live headlines at the top
- 🗂️ **Category Filters** — AI, Africa, Web3, Startups, Cloud
- 📊 **Stats Dashboard** — live count of stories and sources loaded
- 🔄 **Auto-refresh** — updates every 30 minutes automatically
- 📱 **Responsive Design** — works on mobile and desktop
- ⚡ **Skeleton Loading** — professional loading states while fetching

---

## Project Structure

```
afritech-pulse/
│
├── index.html                # Complete static site — HTML, CSS, JavaScript
├── deploy.sh                 # Azure CLI provisioning script
├── README.md                 # This file
│
└── .github/
    └── workflows/
        └── deploy.yml        # GitHub Actions CI/CD pipeline
```

---

## How to Deploy

### Prerequisites
- Azure account (free tier works)
- Azure CLI installed
- GitHub account

### Step 1: Clone
```bash
git clone https://github.com/kaphaaya/afritech-pulse.git
cd afritech-pulse
```

### Step 2: Login to Azure
```bash
az login
```

### Step 3: Run the provisioning script
```bash
chmod +x deploy.sh
./deploy.sh
```

This automatically creates a Resource Group, creates a Storage Account, enables Static Website hosting, uploads index.html, and outputs your live URL.

### Step 4: Set up GitHub Actions secrets

Go to **GitHub repo → Settings → Secrets and variables → Actions** and add:

| Secret | Value |
|---|---|
| `AZURE_CREDENTIALS` | JSON output from `az ad sp create-for-rbac` |
| `STORAGE_ACCOUNT_NAME` | Your Azure storage account name |

Every push to `main` now auto-deploys to Azure. ✅

---

## CI/CD Pipeline

```
git push origin main
        │
        ▼
GitHub Actions triggered
        │
        ├── Checkout code
        ├── Login to Azure (using AZURE_CREDENTIALS secret)
        └── Upload index.html to $web container → Live ✅
```

---

## Azure CLI Provisioning Script

The `deploy.sh` script handles all infrastructure:

```bash
# Create resource group
az group create --name afritech-pulse-rg --location westeurope

# Create storage account
az storage account create --name $STORAGE_ACCOUNT --sku Standard_LRS --kind StorageV2

# Enable static website hosting
az storage blob service-properties update --static-website --index-document index.html

# Upload site
az storage blob upload --container-name '$web' --name index.html --file index.html
```

West Europe was chosen as the closest Azure region to Nigeria for lowest latency.

---

## Challenges & Solutions

| Challenge | Solution |
|---|---|
| NewsAPI free tier blocks browser requests (426 error) | Switched to Hacker News Firebase API and Dev.to API — completely free, no CORS issues, no API key required |
| rss2json.com returning 422 on all feeds | Abandoned RSS approach entirely in favour of direct JSON APIs |
| Git divergent branch on first push | Used `git pull --rebase` to reconcile histories |
| GitHub Actions secret had prefix in value | Corrected secret to store only the raw storage account name |
| Azure storage permissions error with --auth-mode login | Used account key auth fallback which succeeded |

---

## Does It Meet the Brief?

| Requirement | Status |
|---|---|
| Static website deployed to Azure Blob Storage | ✅ |
| Azure CLI provisioning script | ✅ `deploy.sh` |
| Files uploaded via CLI | ✅ |
| GitHub Actions auto-deploy on push | ✅ `.github/workflows/deploy.yml` |
| Unique static website | ✅ Live AI news platform for Africa |
| Site accessible via public URL on port 80 | ✅ https://afritechpulse1772406317.z6.web.core.windows.net/ |
| Documentation with screenshots | ✅ |
| Clear folder structure | ✅ |

---

## About

Built by **Brown (Kafayat Aziz)** — Cloud Engineering Student, AWS Solutions Architect candidate, Web3 developer in training. Based in Nigeria. Building things that matter for Africa.

> *AfriTech Pulse — Built for Africa. Powered by the Cloud.*
