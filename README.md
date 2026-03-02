# 🌍 AfriTech Pulse
### Africa's Premier AI & Technology Intelligence Hub

![Status](https://img.shields.io/badge/Status-Live%20on%20Azure-00A86B?style=for-the-badge)
![Azure](https://img.shields.io/badge/Azure-Blob%20Storage-0078D4?style=for-the-badge&logo=microsoft-azure)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?style=for-the-badge&logo=github-actions)

**🔗 Live Site:** https://afritechpulse1772406317.z6.web.core.windows.net/

---

## What Is This?

AfriTech Pulse is a live AI and technology news platform I built and deployed to Microsoft Azure. It pulls real-time news from across the world — filtered specifically around artificial intelligence, tech startups, Web3, cloud computing, and most importantly, what's happening in Africa and Nigeria.

I built this because the problem is real. Africa has one of the fastest-growing tech ecosystems in the world, but most news platforms don't reflect that. Nigerian developers, founders, and tech professionals deserve a dedicated space where global AI news meets African context — without paywalls, without noise. That's AfriTech Pulse.

---

## What It Does

When you open AfriTech Pulse, it immediately fetches live news from NewsAPI and displays it in a clean, magazine-style layout. Here's what you get:

- A **breaking news ticker** scrolling the latest headlines at the top of the page
- A **hero section** showing the top story of the moment with supporting stories beside it
- An **Africa & Nigeria Spotlight** — a dedicated section that filters specifically for African tech stories
- A **full news grid** showing the latest stories across all categories
- **Category filters** so you can switch between AI, Africa, Web3, Startups, and Cloud
- A **live stats bar** showing how many stories and sources are loaded
- **Auto-refresh every 30 minutes** so the content stays current without reloading

Everything runs in the browser. No backend server. Just one HTML file doing a lot of work.

---

## Why I Built It This Way

I wanted this to be a static site — meaning it's just HTML, CSS, and JavaScript with no server running behind it. The news data gets fetched directly in the user's browser through the NewsAPI. This approach makes it fast, cheap to host, and easy to deploy.

For hosting, I chose **Azure Blob Storage** with static website hosting enabled. It serves the file directly to anyone who visits the URL — no compute costs, no server to manage. For a news aggregator like this, it's the perfect fit.

The design was intentional too. I went with a dark editorial style — think premium magazine meets tech publication. Gold and green as the main colours, Playfair Display for headings, Inter for body text. I wanted it to feel like something Nigerians could be proud of.

---

## The Tech Stack

| What | Why |
|------|-----|
| HTML, CSS, JavaScript | Single-file static site — everything in one place |
| NewsAPI.org | Free API with 80,000+ sources for real-time news |
| Azure Blob Storage | Static website hosting on the cloud |
| Azure CLI | Provisioned all infrastructure from the terminal |
| GitHub Actions | Automatic deployment every time I push new code |
| Google Fonts | Playfair Display + Inter for the editorial look |

---

## How the Deployment Works

I provisioned everything using the **Azure CLI** — no clicking around in the Azure portal. I wrote a `deploy.sh` bash script that does the following automatically:

1. Creates a **Resource Group** called `afritech-pulse-rg` in West Europe
2. Creates a **Storage Account** with a unique name generated from a timestamp
3. Enables **Static Website Hosting** on that storage account
4. Uploads `index.html` to the `$web` container
5. Prints out the live URL at the end

I chose **West Europe** as the region because it has the lowest latency to Nigeria compared to other Azure regions — roughly 50-80ms versus 180ms+ for US regions.

Running the script looks like this:

```bash
chmod +x deploy.sh
./deploy.sh
```

And at the end, it outputs a live public URL. That's the site up and running.

---

## CI/CD with GitHub Actions

After the initial deployment, I set up a **GitHub Actions pipeline** so that every time I push new code to the `main` branch, Azure automatically gets the latest version. No manual uploading needed.

The pipeline does four things in order:

1. Checks out the latest code from the repository
2. Logs into Azure using stored credentials
3. Uploads the updated `index.html` to Azure Blob Storage
4. Confirms the deployment is complete

The credentials are stored as **GitHub Secrets** so they're never exposed in the code:

- `AZURE_CREDENTIALS` — the full JSON service principal from Azure
- `STORAGE_ACCOUNT_NAME` — the name of my storage account

To get the Azure credentials I ran:

```bash
az ad sp create-for-rbac \
  --name "afritech-github-actions" \
  --role contributor \
  --scopes /subscriptions/$(az account show --query id -o tsv) \
  --sdk-auth
```

That outputs a JSON block which I pasted directly into the GitHub secret. From that point on, every push triggers a live deployment automatically.

---

## The Architecture

```
USER'S BROWSER
     │
     │  Opens the site
     ▼
AZURE BLOB STORAGE ($web container)
     │
     │  Serves index.html
     ▼
BROWSER RUNS JAVASCRIPT
     │
     │  Calls NewsAPI in real time
     ▼
NEWSAPI.ORG
     │
     │  Returns live JSON news data
     ▼
PAGE RENDERS WITH LIVE STORIES

─────────────────────────────────

GITHUB (source code)
     │
     │  Push to main branch
     ▼
GITHUB ACTIONS PIPELINE
     │
     │  Logs into Azure, uploads new index.html
     ▼
AZURE BLOB STORAGE UPDATED AUTOMATICALLY
```

---

## Project Structure

```
afritech-pulse/
│
├── index.html                 # The entire site — HTML, CSS, and JavaScript
├── deploy.sh                  # Azure CLI script to provision and deploy
├── README.md                  # This file
│
└── .github/
    └── workflows/
        └── deploy.yml         # GitHub Actions CI/CD pipeline
```

---

## Challenges I Ran Into

**Git conflicts on first push** — GitHub had a README I didn't have locally, which caused a divergent branch error. I fixed it by setting `git config pull.rebase false` and pulling with `--allow-unrelated-histories` before pushing again.

**GitHub Actions secret format** — The first time the pipeline ran, it failed because my `STORAGE_ACCOUNT_NAME` secret had been saved as `storage_account_name=afritechpulse...` instead of just the account name. Once I corrected the secret value, the deployment worked perfectly.

**Storage account name uniqueness** — Azure requires globally unique storage account names. I handled this in the deploy script by appending a Unix timestamp: `afritechpulse$(date +%s)`.

---

## Screenshots

### Live Site (3)
*[Screenshot of live AfriTech Pulse site]*

### GitHub Actions — Successful Deployment
*[Screenshot of green workflow in Actions tab]*

### Azure Portal — Storage Account
*[Screenshot of storage account in Azure portal]*

### GitHub Repository
*[Screenshot of repo structure on GitHub]*

---

## Does It Meet the Brief?

| Requirement | Done |
|-------------|------|
| Static website deployed to Azure Blob Storage | ✅ |
| Azure CLI provisioning script | ✅ `deploy.sh` |
| Files uploaded via CLI | ✅ |
| Unique static website | ✅ Live AI news platform |
| GitHub Actions auto-deploy on push | ✅ `.github/workflows/deploy.yml` |
| Public URL accessible | ✅ https://afritechpulse1772406317.z6.web.core.windows.net/ |
| Documentation with screenshots | ✅ |

---

## About

Built by **AZIZ KAFAYAT** — Cloud Engineering Student, AWS Solutions Architect candidate, and Web3 developer in training. Based in Nigeria. Building things that matter for Africa.

*AfriTech Pulse — Built for Africa. Deployed on Azure.*
