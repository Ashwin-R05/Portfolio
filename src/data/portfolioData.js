// ============================================================
// portfolioData.js — Centralized configuration for Ashwin R's Portfolio
// Data extracted directly from Ashwin R's official repository (Ashwin-R05/Portfolio)
// ============================================================

export const personalInfo = {
  name: "Ashwin R",
  firstName: "Ashwin",
  brandName: "Ashwin",
  title: "Full-Stack Developer | Aspiring Cloud Security Enthusiast",
  tagline: "Full-Stack Web & Mobile • Scalable Architecture • Cloud Security & DevSecOps Explorer",
  email: "ashwinindira05@gmail.com",
  location: "Trichy, Tamil Nadu, India",
  education: "B.Tech Information Technology (Pre-final year)",
  idNumber: "DEV-SEC-2026-AR05",
  linkedin: "https://linkedin.com/in/ashwin-r05",
  github: "https://github.com/Ashwin-R05",
  instagram: "https://instagram.com/ashwin.r05",
  emails: {
    primary: "ashwinindira05@gmail.com",
  },
  summary:
    "Pre-final year B.Tech Information Technology student combining a strong foundation in Full-Stack Web & Mobile Development with an active focus on Cloud Security and DevSecOps. Architecting production-ready applications with Flutter, Node.js, Express, React, and MongoDB/MySQL, while practicing Linux (Fedora & Kali), networking (TCP/IP, DNS), and OAuth 2.0 / JWT / PKCE auth security.",
  bioLines: [
    "I am a pre-final year B.Tech Information Technology student combining a strong foundation in Full-Stack Web & Mobile Development with an active focus on Cloud Security and DevSecOps.",
    "Core Engineering: Hands-on experience architecting production-ready applications with Flutter, Node.js, Express, React, and MongoDB/MySQL, focusing on clean architecture, responsive UI/UX, and robust RESTful API design.",
    "Security & Cloud Domain Transition: Daily practice in Linux (Fedora & Kali), core networking fundamentals (TCP/IP, DNS, ports), and hands-on experience designing OAuth 2.0, JWT, and PKCE authentication systems. Actively practicing on TryHackMe, Wireshark, and OWASP Top 10 to bridge software development with cloud security engineering."
  ],
  resumeUrl: "/Ashwin_R_Resume.pdf",
};

export const socialLinks = {
  github: "https://github.com/Ashwin-R05",
  linkedin: "https://linkedin.com/in/ashwin-r05",
  instagram: "https://instagram.com/ashwin.r05",
  email: "mailto:ashwinindira05@gmail.com",
};

export const heroContent = {
  greeting: "Hi, I'm Ashwin R",
  titleHighlight: "Full-Stack Developer & Cloud Security Enthusiast",
  subtitle:
    "Full-Stack Web & Mobile • Scalable Architecture • Cloud Security & DevSecOps Explorer. Building production-grade applications with Flutter, Node.js, Express & React while mastering OAuth 2.0, Linux Kernel & OWASP Top 10.",
  roles: [
    "Full-Stack Developer & Software Engineer",
    "Building Scalable Web & Mobile Applications",
    "Aspiring Cloud Security Enthusiast",
    "Practicing Linux, Networking & OWASP Top 10",
    "Exploring DevSecOps & Cloud Security"
  ],
  ctaPrimary: { text: "Explore Projects", href: "#work" },
  ctaSecondary: {
    text: "Get In Touch",
    href: "mailto:ashwinindira05@gmail.com?subject=Opportunity%20%E2%80%93%20Portfolio&body=Hello%20Ashwin,%0D%0A%0D%0AI%20came%20across%20your%20portfolio%20and%20would%20like%20to%20connect%20with%20you.%0D%0A%0D%0ABest%20Regards,",
  },
  ctaResume: { text: "Download Resume", href: "/Ashwin_R_Resume.pdf" },
};

export const aboutContent = {
  heading: "About Me",
  bio: personalInfo.summary,
  techStack: [
    "Flutter & Dart",
    "Node.js & Express",
    "React & JavaScript",
    "MongoDB & MySQL",
    "OAuth 2.0 & JWT Security",
    "Linux (Fedora & Kali)",
    "AWS & Docker",
    "Networking (TCP/IP, DNS)",
    "OWASP Top 10"
  ],
};

// Technical Skills Data
export const technicalSkills = {
  categories: [
    {
      title: "Languages & Operating Systems",
      skills: [
        { name: "JavaScript", level: 85 },
        { name: "Java", level: 80 },
        { name: "Dart", level: 85 },
        { name: "Python", level: 75 },
        { name: "Linux (Fedora & Kali)", level: 80 }
      ]
    },
    {
      title: "Frameworks & Web Engineering",
      skills: [
        { name: "Flutter (Cross-Platform)", level: 88 },
        { name: "Node.js & Express", level: 82 },
        { name: "React", level: 75 },
        { name: "OAuth 2.0 & JWT Auth", level: 80 },
        { name: "RESTful API Design", level: 85 }
      ]
    },
    {
      title: "Databases & Storage",
      skills: [
        { name: "MongoDB", level: 78 },
        { name: "MySQL", level: 72 },
        { name: "SQLite", level: 75 }
      ]
    },
    {
      title: "Cloud, Tools & Security",
      skills: [
        { name: "AWS Cloud", level: 68 },
        { name: "Docker & CI/CD", level: 75 },
        { name: "Git & GitHub", level: 85 },
        { name: "Recon & Security Tools (Wireshark, Nmap, TryHackMe)", level: 70 }
      ]
    }
  ]
};

// Selected Projects Data
export const projects = [
  {
    id: "task-flow",
    number: "01",
    badge: "⚡ Full-Stack Platform",
    title: "Task_Flow — Multi-Tenant Distributed Task Platform",
    subtitle: "Multi-Tenant Distributed Task Management Platform",
    description:
      "A full-stack multi-tenant task management platform engineered with Node.js, Express, MongoDB, and Docker. Enforces strict data isolation using shared-database patterns, JWT authentication, role-based access control (RBAC), and automated CI/CD deployments via GitHub Actions.",
    problemStatement:
      "Teams and enterprises need isolated task management without risk of cross-tenant data exposure.",
    features: [
      "Multi-tenant architecture with secure data isolation using shared-database pattern",
      "JWT-based authentication & role-based access control (RBAC) with bcrypt password hashing",
      "RESTful API design with comprehensive input validation and error handling",
      "Containerized full stack with Docker; automated CI/CD deployments via GitHub Actions",
      "Task CRUD with filtering, sorting, and organizational workspace assignment"
    ],
    techTags: [
      "Node.js",
      "Express",
      "MongoDB",
      "JWT",
      "RBAC",
      "Docker",
      "GitHub Actions",
      "REST API"
    ],
    links: {
      github: "https://github.com/Ashwin-R05/Task_Flow",
      demo: null,
    },
  },
  {
    id: "summarizit",
    number: "02",
    badge: "🤖 AI Cross-Platform App",
    title: "Summarizit — Cross-Platform AI Summarization App",
    subtitle: "Cross-Platform AI Summarization Application",
    description:
      "An AI-powered text summarization application built with Dart & Flutter using Clean Architecture to separate data, domain, and presentation layers. Ships across 6 target platforms (Android, iOS, Web, Windows, Linux, macOS) from a single codebase with dynamic UI animations.",
    problemStatement:
      "Information overload makes long documents and articles tedious to digest.",
    features: [
      "Designed using Clean Architecture to separate data, domain, and presentation layers",
      "AI-powered text summarization via external REST API integration",
      "Responsive Flutter UI with dynamic animations across mobile and web",
      "Ships to 6 platforms (Android, iOS, Web, Windows, Linux, macOS) from a single codebase"
    ],
    techTags: [
      "Dart",
      "Flutter",
      "Clean Architecture",
      "REST API",
      "Cross-Platform",
      "AI Summarization"
    ],
    links: {
      github: "https://github.com/Ashwin-R05/summarizit",
      demo: null,
    },
  },
  {
    id: "authforge",
    number: "03",
    badge: "🔐 Auth Infrastructure",
    title: "AuthForge — Centralized OAuth 2.0 / OIDC Identity Provider",
    subtitle: "Centralized OAuth 2.0 / OpenID Connect Identity Provider",
    description:
      "A security-focused OAuth 2.0 and OpenID Connect identity provider engineered for campus microservice ecosystems. Implements full authorization code flow with PKCE to prevent code interception, alongside JWT refresh token rotation to mitigate token replay attacks.",
    problemStatement:
      "Campus ecosystems require centralized identity management to authenticate users across multiple services while handling authorization securely.",
    features: [
      "Centralized OAuth 2.0 & OpenID Connect identity provider for campus services",
      "Implemented full authorization code flow with PKCE to prevent code interception",
      "JWT access control with refresh token rotation addressing token replay vectors",
      "Built with security-first design patterns for reliable, scalable auth infrastructure"
    ],
    techTags: [
      "Java",
      "Node.js",
      "OAuth 2.0",
      "PKCE",
      "JWT",
      "SQLite",
      "Distributed Systems",
      "Identity Security"
    ],
    links: {
      github: "https://github.com/Ashwin-R05",
      demo: null,
    },
  },
];

// Experience / Focus Areas Data
export const internshipsList = [
  {
    organization: "Core Software Engineering",
    role: "Full-Stack Web & Mobile Engineering",
    duration: "2023 - Present",
    skills: [
      "Architecting production-ready Flutter web & mobile applications",
      "Building scalable RESTful backend services with Node.js & Express",
      "Designing relational & NoSQL schemas in MongoDB, MySQL, and SQLite",
      "Enforcing Clean Architecture and component-driven state management"
    ],
    tech: ["Flutter", "Dart", "Node.js", "Express", "React", "MongoDB", "MySQL", "Git"]
  },
  {
    organization: "Cloud Security & DevSecOps",
    role: "Cloud Security & Authentication Exploration",
    duration: "2024 - Present",
    skills: [
      "Implementing OAuth 2.0, OpenID Connect, JWT, and PKCE auth flows",
      "Practicing Linux system administration across Fedora & Kali Linux",
      "Analyzing core networking protocols (TCP/IP, DNS, HTTP/S, ports)",
      "Testing OWASP Top 10 vulnerabilities & practicing on TryHackMe & Wireshark"
    ],
    tech: ["OAuth 2.0", "PKCE", "JWT", "Linux", "AWS", "Docker", "Wireshark", "TryHackMe"]
  }
];

// Certifications Data
export const certificates = {
  featured: [
    {
      name: "B.Tech Information Technology (Pre-Final Year)",
      issuer: "Undergraduate IT Degree",
      icon: "🎓",
    },
    {
      name: "Full-Stack Web & Mobile Engineering",
      issuer: "Flutter, Node.js & React Expertise",
      icon: "💻",
    },
    {
      name: "OAuth 2.0, JWT & PKCE Auth Systems",
      issuer: "Identity & Security Engineering",
      icon: "🔐",
    },
    {
      name: "Linux Systems (Fedora & Kali Linux)",
      issuer: "Sysadmin & Security Shell Practice",
      icon: "🐧",
    },
    {
      name: "Cloud Security & DevSecOps Practitioner",
      issuer: "AWS, Docker & CI/CD Pipelines",
      icon: "☁️",
    },
    {
      name: "TryHackMe & OWASP Security Explorer",
      issuer: "Networking & Web Defense Practice",
      icon: "🛡️",
    },
  ],
  viewAllUrl: "https://github.com/Ashwin-R05",
};

export const education = {
  degree: "B.Tech Information Technology",
  institution: "Undergraduate IT Student (Pre-final Year)",
  location: "Trichy, Tamil Nadu, India",
  idNumber: "DEV-SEC-2026-AR05",
};

export const footerContent = {
  taglines: [
    "Ashwin R — Full-Stack Developer | Aspiring Cloud Security Enthusiast",
    "Full-Stack Web & Mobile · Scalable Architecture · Cloud Security & DevSecOps",
    "Building Production-Ready Applications & Exploring Security Engineering",
  ],
  credential: "B.Tech IT · Trichy, Tamil Nadu, India · ID: DEV-SEC-2026-AR05",
  copyright: `© ${new Date().getFullYear()} Ashwin R. All rights reserved.`,
};

export const emailjsConfig = {
  serviceId: import.meta.env.VITE_EMAILJS_SERVICE_ID || "YOUR_EMAILJS_SERVICE_ID",
  templateId: import.meta.env.VITE_EMAILJS_TEMPLATE_ID || "YOUR_EMAILJS_TEMPLATE_ID",
  publicKey: import.meta.env.VITE_EMAILJS_PUBLIC_KEY || "YOUR_EMAILJS_PUBLIC_KEY",
};
