# 🛡️ Ashwin R — Cybersecurity Engineer & Offensive Security Researcher

An ultra-modern, dynamic, and fully modular **React + Vite** portfolio application built for **Ashwin R**, customized specifically for **Cybersecurity, Offensive Security Research, Kernel eBPF, AppSec, and Zero-Trust Engineering**.

---

## ⚡ Key Highlights & Architecture

- **React 19 + Vite + Tailwind CSS 4**: Lightning-fast, modern reactive component structure.
- **Framer Motion & AOS Animations**: Smooth parallax scroll, interactive water-fill preloader, and entrance reveals.
- **Centralized Data Management (`src/data/portfolioData.js`)**: All personal info, cyber skills, flagship projects, research advisories, certifications, and contact details are managed in one centralized configuration file.
- **Dynamic Role Typewriter**: Interactive headline cycling through *Cybersecurity Engineer*, *Offensive Security Researcher*, *Zero-Trust & AppSec Architect*, and *eBPF Specialist*.
- **Offensive & Defensive Flagship Projects**:
  - **SentinelShield**: Real-time Linux Kernel eBPF Syscall Monitor & Rootkit Detection Daemon.
  - **ShadowRecon**: Distributed Multi-Threaded OSINT & Attack Surface Exposure Engine.
  - **AegisVault**: Dynamic Zero-Trust Secrets Broker with AES-256-GCM and mTLS.
  - **ThreatIntel AI**: LLM Malware Triage & YARA Signature Synthesizer.
- **Security Research & CTF Achievements**: Published advisories on HTTP/2 Request Smuggling, Kernel eBPF tracepoints, Heap Exploitation, and Hack The Box Top 1% rank.
- **Verified Certifications**: CEH, CompTIA Security+, OSCP Candidate, AWS Certified Security – Specialty, eJPTv2, and National CyberDef Hackathon 1st Place.
- **EmailJS & Direct Encrypted Dispatch**: Functional contact form with automatic fallback to pre-filled mailto.

---

## 📁 Project Structure

```
├── public/                 # Static assets & favicon
├── src/
│   ├── assets/             # Media assets & avatars
│   ├── components/
│   │   ├── About.jsx            # Security dossier & cyber tech stack
│   │   ├── Certificates.jsx     # Verified CEH, Security+, OSCP credentials
│   │   ├── Contact.jsx          # EmailJS & encrypted transmission form
│   │   ├── ContentCreator.jsx   # Threat intel, research & CTF highlights
│   │   ├── Footer.jsx           # Cyber credentials & social navigation
│   │   ├── Hero.jsx             # Cyber telemetry HUD, dynamic typewriter & CTAs
│   │   ├── Internships.jsx      # AppSec & OSINT work experience timeline
│   │   ├── Leadership.jsx       # CTF captaincy & open source tooling
│   │   ├── Navbar.jsx           # Responsive glassmorphism navbar & mobile drawer
│   │   ├── Preloader.jsx        # Water-fill brand splash animation
│   │   ├── Projects.jsx         # Flagship cyber projects & source code links
│   │   ├── Services.jsx         # Adversarial simulation process workflow
│   │   ├── SoftSkills.jsx       # Threat modeling & crisis engineering
│   │   └── TechnicalSkills.jsx  # Categorized cyber skills with animated progress
│   ├── data/
│   │   └── portfolioData.js     # Centralized configuration & data file
│   ├── App.jsx                  # Main application component
│   ├── index.css                # Global styles & Tailwind imports
│   └── main.jsx                 # React root entry point
├── index.html                   # HTML template with metadata & Google Fonts
├── package.json                 # Project dependencies & scripts
└── vite.config.js               # Vite bundler configuration
```

---

## 🚀 Running Locally

### Development Server:
```bash
npm run dev
```
Open **[http://localhost:5173](http://localhost:5173)** in your browser.

### Production Build:
```bash
npm run build
npm run preview
```

---

## 🛠️ How to Customize

To modify your bio, projects, social links, or certifications, edit [`src/data/portfolioData.js`](src/data/portfolioData.js). All components automatically reflect updates made to this file.

---

## 📜 License

Created for personal cybersecurity portfolio and ethical research disclosure.
