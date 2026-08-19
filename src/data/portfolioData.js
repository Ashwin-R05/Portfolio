// ============================================================
// portfolioData.js — Centralized configuration for Ashwin R's Portfolio
// Modernized for Dynamic React + Vite Portfolio
// ============================================================

export const personalInfo = {
  name: "Ashwin R",
  firstName: "Ashwin",
  brandName: "ASHWIN",
  title: "Full-Stack Developer & Cloud Security Enthusiast",
  tagline: "Building Secure Digital Experiences • Web, Mobile & Cloud Security",
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

export const socialLinks = [
  { name: "GitHub", url: "https://github.com/Ashwin-R05", icon: "Github" },
  { name: "LinkedIn", url: "https://linkedin.com/in/ashwin-r05", icon: "Linkedin" },
  { name: "Instagram", url: "https://instagram.com/ashwin.r05", icon: "Instagram" },
  { name: "Email", url: "mailto:ashwinindira05@gmail.com", icon: "Mail" },
];

export const heroContent = {
  greeting: "Hello, I'm Ashwin",
  title: "Building Secure Digital Experiences",
  subtitle:
    "B.Tech Information Technology student focused on cybersecurity, cloud security, full-stack software development, and creative digital experiences.",
  roles: [
    "Full-Stack Web & Mobile Engineer",
    "Cloud Security & DevSecOps Explorer",
    "Cybersecurity & Authentication Specialist",
    "Clean Architecture Advocate"
  ],
  ctaPrimary: { text: "View Projects", href: "/projects" },
  ctaSecondary: { text: "Contact Me", href: "/contact" },
  ctaResume: { text: "Download Resume", href: "/Ashwin_R_Resume.pdf" },
  stats: [
    { label: "Tech Stack Modules", value: "15+" },
    { label: "Target Platforms Shipped", value: "6" },
    { label: "Security & Cloud Domains", value: "4+" },
    { label: "Security & Dev Practice", value: "100%" }
  ]
};

export const aboutContent = {
  heading: "Architecting Modern Applications with Security at the Core",
  introduction:
    "I'm a pre-final year Information Technology student who bridges the gap between creative frontend/mobile software engineering and deep cloud security infrastructure.",
  paragraphs: [
    "My engineering journey began with foundational programming in Python, Java, and Dart, quickly evolving into full-stack application development using Flutter, React, Node.js, Express, and MongoDB/MySQL. I believe that modern user interfaces should be responsive, fast, and aesthetically delightful.",
    "Parallel to application engineering, my core curiosity drives me deep into Cloud Security and DevSecOps. I spend significant time practicing on Linux systems (Fedora & Kali), analyzing network packets using Wireshark, hardening REST APIs, and implementing robust identity frameworks like OAuth 2.0, JWT with refresh rotation, and PKCE flow.",
    "My goal is to design resilient, production-ready software systems where beauty in design meets uncompromising cybersecurity principles."
  ],
  timeline: [
    { year: "Phase 1", title: "Core Programming", description: "Foundational mastery in Python, Java, Dart, and object-oriented paradigms." },
    { year: "Phase 2", title: "Cross-Platform & Mobile", description: "Building multi-platform native apps with Flutter and Clean Architecture." },
    { year: "Phase 3", title: "Full-Stack Web Engineering", description: "Architecting backend microservices with Node.js, Express, MongoDB, and React." },
    { year: "Phase 4", title: "Networking & Linux Administration", description: "Deep dive into TCP/IP, DNS, ports, Fedora, and Kali Linux environment tuning." },
    { year: "Phase 5", title: "Identity & Cloud Security", description: "Engineering OAuth 2.0, PKCE, JWT, Docker containerization, and AWS security." },
    { year: "Phase 6", title: "DevSecOps & Red/Blue Practice", description: "OWASP Top 10 mitigation, TryHackMe labs, Wireshark packet analysis, and CI/CD security automation." },
  ]
};

// Skill ecosystem with filtering categories
export const skillsData = [
  {
    category: "Programming",
    icon: "Code2",
    description: "Core languages used for application logic, scripting, and system engineering.",
    skills: [
      { name: "Python", level: 85, icon: "Terminal", experience: "Advanced", projects: 4, description: "Scripting, automation, data handling, and algorithm design." },
      { name: "Java", level: 80, icon: "Cpu", experience: "Intermediate-Advanced", projects: 3, description: "OOP concepts, backend application structure, and identity logic." },
      { name: "Dart", level: 88, icon: "Smartphone", experience: "Advanced", projects: 5, description: "Cross-platform mobile development with Clean Architecture." },
      { name: "JavaScript", level: 88, icon: "FileCode", experience: "Advanced", projects: 6, description: "Modern ES6+, async programming, React, and Node.js ecosystems." },
    ]
  },
  {
    category: "Development",
    icon: "Layers",
    description: "Frameworks, client UI libraries, and version control tools.",
    skills: [
      { name: "React", level: 85, icon: "Layout", experience: "Advanced", projects: 5, description: "Component architecture, Framer Motion animations, state management, and SPA routing." },
      { name: "Flutter", level: 90, icon: "Smartphone", experience: "Expert", projects: 6, description: "Cross-platform engineering for Android, iOS, Web, Windows, Linux, and macOS." },
      { name: "Node.js & Express", level: 84, icon: "Server", experience: "Advanced", projects: 5, description: "RESTful API creation, middleware, authentication pipelines, and microservices." },
      { name: "Git & GitHub", level: 88, icon: "GitBranch", experience: "Advanced", projects: 10, description: "Branching strategies, pull request reviews, and GitHub Actions automated CI/CD." },
    ]
  },
  {
    category: "Cloud & DevSecOps",
    icon: "Cloud",
    description: "Cloud platforms, containerization, and automated delivery pipelines.",
    skills: [
      { name: "AWS Cloud", level: 75, icon: "CloudRain", experience: "Intermediate", projects: 3, description: "EC2 instance hosting, S3 bucket policy management, IAM roles, and VPC configuration." },
      { name: "Docker", level: 80, icon: "Box", experience: "Intermediate-Advanced", projects: 4, description: "Containerization, multi-stage builds, compose files, and isolated environment deployment." },
      { name: "Cloud Security", level: 78, icon: "ShieldCheck", experience: "Intermediate", projects: 3, description: "Securing cloud workloads, strict IAM access controls, and encrypted data transit." },
    ]
  },
  {
    category: "Cybersecurity & Linux",
    icon: "Shield",
    description: "Operating system administration, network forensics, and web defense.",
    skills: [
      { name: "Linux (Fedora & Kali)", level: 85, icon: "Terminal", experience: "Advanced", projects: 6, description: "Shell scripting, system administration, kernel permissions, and security toolchains." },
      { name: "Networking", level: 82, icon: "Network", experience: "Advanced", projects: 4, description: "TCP/IP layer analysis, DNS configuration, port scanning, and HTTP/S protocols." },
      { name: "OAuth 2.0 / JWT / PKCE", level: 86, icon: "KeyRound", experience: "Advanced", projects: 3, description: "Auth code flow, token interception prevention, refresh token rotation, and identity providers." },
      { name: "Wireshark & Nmap", level: 75, icon: "Activity", experience: "Intermediate", projects: 3, description: "Packet capture analysis, network reconnaissance, and protocol troubleshooting." },
      { name: "OWASP Top 10", level: 80, icon: "Lock", experience: "Intermediate-Advanced", projects: 4, description: "Mitigating SQL injection, XSS, CSRF, insecure deserialization, and broken access controls." },
    ]
  },
  {
    category: "Databases & Tools",
    icon: "Database",
    description: "Persistence layers, relational databases, and design platforms.",
    skills: [
      { name: "MongoDB", level: 80, icon: "Database", experience: "Advanced", projects: 4, description: "NoSQL document modeling, indexing, aggregation pipelines, and multi-tenant schema isolation." },
      { name: "MySQL / SQLite", level: 78, icon: "Server", experience: "Intermediate-Advanced", projects: 4, description: "Relational schema design, ACID transactions, relational joins, and prepared queries." },
      { name: "Figma & UI/UX", level: 82, icon: "Figma", experience: "Intermediate-Advanced", projects: 5, description: "Prototyping futuristic tech interfaces, responsive grid layouts, and visual systems." },
    ]
  }
];

// Featured & All Projects
export const projects = [
  {
    id: "task-flow",
    featured: true,
    number: "01",
    badge: "⚡ Full-Stack Platform",
    category: "Full-Stack & Cloud",
    title: "Task_Flow — Multi-Tenant Distributed Task Platform",
    subtitle: "Multi-Tenant Distributed Task Management Platform",
    description:
      "A full-stack multi-tenant task management platform engineered with Node.js, Express, MongoDB, and Docker. Enforces strict data isolation using shared-database patterns, JWT authentication, role-based access control (RBAC), and automated CI/CD deployments via GitHub Actions.",
    overview:
      "Task_Flow was architected to solve multi-tenancy challenges in modern SaaS applications. It ensures strict tenant-level data segregation while providing high-performance task management capabilities.",
    problem:
      "Teams and enterprises need isolated task management without risk of cross-tenant data exposure or complicated manual infrastructure setup.",
    solution:
      "Engineered a dynamic tenant context middleware that dynamically scopes database queries per tenant header, combined with cryptographically signed JWT tokens carrying organization scopes.",
    architecture:
      "Node.js/Express API Gateway -> Tenant Resolution Middleware -> Mongo DB Scoped Collections -> Dockerized Services -> GitHub Actions Automated Deployments.",
    features: [
      "Multi-tenant architecture with secure data isolation using shared-database pattern",
      "JWT-based authentication & role-based access control (RBAC) with bcrypt password hashing",
      "RESTful API design with comprehensive input validation and error handling",
      "Containerized full stack with Docker; automated CI/CD deployments via GitHub Actions",
      "Task CRUD with filtering, sorting, and organizational workspace assignment"
    ],
    challenges: [
      "Preventing cross-tenant memory leaks in multi-tenant connection pools.",
      "Ensuring sub-100ms API response times while validating RBAC permissions on every route."
    ],
    results: [
      "Achieved 100% tenant isolation verification in test suites.",
      "Automated complete build-test-deploy pipeline down to under 2 minutes."
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
    image: "https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=1200&q=80"
  },
  {
    id: "summarizit",
    featured: false,
    number: "02",
    badge: "🤖 AI Cross-Platform App",
    category: "Mobile & AI",
    title: "Summarizit — Cross-Platform AI Summarization App",
    subtitle: "Cross-Platform AI Summarization Application",
    description:
      "An AI-powered text summarization application built with Dart & Flutter using Clean Architecture to separate data, domain, and presentation layers. Ships across 6 target platforms (Android, iOS, Web, Windows, Linux, macOS) from a single codebase with dynamic UI animations.",
    overview:
      "Summarizit streamlines reading long-form content by processing lengthy articles, PDFs, and notes into concise, actionable summaries powered by large language model APIs.",
    problem:
      "Information overload makes long documents and articles tedious to digest on mobile and desktop devices.",
    solution:
      "Built a seamless cross-platform Flutter application with state management decoupled using Clean Architecture, allowing real-time streaming summaries and offline local storage.",
    architecture:
      "Flutter UI Layer -> Domain Entities & Use Cases -> Data Repositories -> External AI REST API & Local SQLite Cache.",
    features: [
      "Designed using Clean Architecture to separate data, domain, and presentation layers",
      "AI-powered text summarization via external REST API integration",
      "Responsive Flutter UI with dynamic animations across mobile and web",
      "Ships to 6 platforms (Android, iOS, Web, Windows, Linux, macOS) from a single codebase"
    ],
    challenges: [
      "Handling dynamic UI rendering for varied screen ratios across desktop and mobile.",
      "Optimizing async stream responses from the AI backend to prevent frame drops."
    ],
    results: [
      "Unified codebase deployment across 6 operating systems.",
      "Smooth 60 FPS UI performance verified on both low-end mobile and high-dpi desktop screens."
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
    image: "https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?auto=format&fit=crop&w=1200&q=80"
  },
  {
    id: "authforge",
    featured: true,
    number: "03",
    badge: "🔐 Auth Infrastructure",
    category: "Cybersecurity & Identity",
    title: "AuthForge — Centralized OAuth 2.0 / OIDC Identity Provider",
    subtitle: "Centralized OAuth 2.0 / OpenID Connect Identity Provider",
    description:
      "A security-focused OAuth 2.0 and OpenID Connect identity provider engineered for campus microservice ecosystems. Implements full authorization code flow with PKCE to prevent code interception, alongside JWT refresh token rotation to mitigate token replay attacks.",
    overview:
      "AuthForge serves as a single sign-on identity backbone. It protects user credentials while providing standardized OIDC tokens to client microservices across the network.",
    problem:
      "Campus ecosystems require centralized identity management to authenticate users across multiple services while handling authorization securely without exposing passwords.",
    solution:
      "Engineered an RFC 7636 compliant authorization server implementing Proof Key for Code Exchange (PKCE), cryptographically signed RS256 JWT tokens, and token revocation lists.",
    architecture:
      "OAuth Client -> PKCE Challenge/Verifier -> Auth Server Grant Endpoint -> Signed RS256 Token Issuer -> Token Introspection API.",
    features: [
      "Centralized OAuth 2.0 & OpenID Connect identity provider for campus services",
      "Implemented full authorization code flow with PKCE to prevent code interception",
      "JWT access control with refresh token rotation addressing token replay vectors",
      "Built with security-first design patterns for reliable, scalable auth infrastructure"
    ],
    challenges: [
      "Preventing authorization code reuse and replay vectors.",
      "Implementing safe cryptographic key storage and automated RSA key rotation."
    ],
    results: [
      "Zero plain-text credential leaks across simulated attack vectors.",
      "Successfully validated against OWASP authentication guidelines."
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
    image: "https://images.unsplash.com/photo-1563986768609-322da13575f3?auto=format&fit=crop&w=1200&q=80"
  }
];

// Timeline for Experience & Education
export const experienceTimeline = [
  {
    id: "exp-1",
    type: "Experience",
    category: "Full-Stack Web & Mobile",
    organization: "Core Software Engineering",
    role: "Full-Stack Web & Mobile Engineering",
    period: "2023 - Present",
    location: "Trichy, Tamil Nadu, India",
    description:
      "Engineered production-grade applications using clean architecture and modern JavaScript/Dart frameworks.",
    highlights: [
      "Architected production-ready Flutter web & mobile applications with Clean Architecture",
      "Built scalable RESTful backend services with Node.js & Express API routing",
      "Designed relational & NoSQL schemas in MongoDB, MySQL, and SQLite",
      "Enforced component-driven state management and dynamic UI design systems"
    ],
    technologies: ["Flutter", "Dart", "Node.js", "Express", "React", "MongoDB", "MySQL", "Git"]
  },
  {
    id: "exp-2",
    type: "Experience",
    category: "Cloud Security & DevSecOps",
    organization: "Cloud Security & DevSecOps Exploration",
    role: "Cloud Security & Authentication Specialist",
    period: "2024 - Present",
    location: "Trichy, Tamil Nadu, India",
    description:
      "Focusing on identity protocols, network security forensics, and cloud infrastructure hardening.",
    highlights: [
      "Implemented OAuth 2.0, OpenID Connect, JWT, and PKCE auth flows from scratch",
      "Practiced Linux system administration across Fedora & Kali Linux distributions",
      "Analyzed core networking protocols (TCP/IP, DNS, HTTP/S, ports) via Wireshark and Nmap",
      "Tested OWASP Top 10 vulnerabilities & practiced hands-on labs on TryHackMe"
    ],
    technologies: ["OAuth 2.0", "PKCE", "JWT", "Linux", "AWS", "Docker", "Wireshark", "TryHackMe"]
  },
  {
    id: "edu-1",
    type: "Education",
    category: "Undergraduate Degree",
    organization: "B.Tech Information Technology",
    role: "Pre-Final Year IT Student",
    period: "2022 - 2026 (Expected)",
    location: "Trichy, Tamil Nadu, India",
    description:
      "Pursuing a degree in Information Technology with specialized coursework in Data Structures, Algorithms, Computer Networks, Database Management Systems, Operating Systems, and Information Security.",
    highlights: [
      "Student ID / Credential: DEV-SEC-2026-AR05",
      "Focus areas: Web Technologies, Distributed Systems, Software Engineering, Network Security",
      "Active participant in technical hackathons, coding challenges, and security workshops"
    ],
    technologies: ["Data Structures", "Computer Networks", "DBMS", "Operating Systems", "Cybersecurity"]
  }
];

// Certifications & Achievements
export const certificationsList = [
  {
    id: "cert-1",
    title: "B.Tech Information Technology (Pre-Final Year)",
    organization: "Undergraduate IT Degree",
    date: "2022 - 2026",
    badge: "Degree",
    icon: "GraduationCap",
    credentialId: "DEV-SEC-2026-AR05",
    description: "Core specialization in Software Engineering, Computer Networks, and Data Structures.",
    skills: ["Data Structures", "Computer Networks", "DBMS", "Software Engineering"],
    verifyUrl: "https://github.com/Ashwin-R05"
  },
  {
    id: "cert-2",
    title: "Full-Stack Web & Mobile Engineering",
    organization: "Software Architecture & Frontend/Backend Expertise",
    date: "2024",
    badge: "Engineering",
    icon: "Code",
    credentialId: "FS-DEV-AR05",
    description: "Mastery in building end-to-end web and cross-platform apps using Flutter, React, and Node.js.",
    skills: ["Flutter", "React", "Node.js", "Express", "REST APIs"],
    verifyUrl: "https://github.com/Ashwin-R05"
  },
  {
    id: "cert-3",
    title: "OAuth 2.0, JWT & PKCE Auth Systems",
    organization: "Identity & Security Engineering",
    date: "2024",
    badge: "Security",
    icon: "ShieldAlert",
    credentialId: "AUTH-SEC-AR05",
    description: "Practical implementation of RFC 7636 PKCE flow, JWT refresh token rotation, and identity providers.",
    skills: ["OAuth 2.0", "PKCE", "JWT", "Identity Management"],
    verifyUrl: "https://github.com/Ashwin-R05"
  },
  {
    id: "cert-4",
    title: "Linux Systems (Fedora & Kali Linux)",
    organization: "Sysadmin & Security Shell Practice",
    date: "2024",
    badge: "System Admin",
    icon: "Terminal",
    credentialId: "LNX-SYS-AR05",
    description: "Daily hands-on practice with Linux CLI, bash scripting, file permissions, and security tools.",
    skills: ["Linux CLI", "Fedora", "Kali Linux", "Bash Scripting"],
    verifyUrl: "https://github.com/Ashwin-R05"
  },
  {
    id: "cert-5",
    title: "Cloud Security & DevSecOps Practitioner",
    organization: "AWS, Docker & CI/CD Pipelines",
    date: "2024",
    badge: "Cloud",
    icon: "Cloud",
    credentialId: "CLOUD-SEC-AR05",
    description: "Containerization with Docker, automated deployment via GitHub Actions, and AWS infrastructure hardening.",
    skills: ["AWS", "Docker", "GitHub Actions", "CI/CD"],
    verifyUrl: "https://github.com/Ashwin-R05"
  },
  {
    id: "cert-6",
    title: "TryHackMe & OWASP Security Explorer",
    organization: "Networking & Web Defense Practice",
    date: "2024 - Present",
    badge: "Cybersecurity",
    icon: "Lock",
    credentialId: "THM-OWASP-AR05",
    description: "Hands-on vulnerability assessments, packet analysis with Wireshark, and OWASP Top 10 mitigation.",
    skills: ["Wireshark", "TryHackMe", "OWASP Top 10", "Nmap"],
    verifyUrl: "https://github.com/Ashwin-R05"
  }
];

export const footerContent = {
  brandName: "ASHWIN R",
  tagline: "Full-Stack Developer & Cloud Security Enthusiast • Trichy, Tamil Nadu, India",
  credential: "B.Tech IT · ID: DEV-SEC-2026-AR05",
  copyright: `© ${new Date().getFullYear()} Ashwin R. Designed & Built with Precision.`,
};

export const emailjsConfig = {
  serviceId: import.meta.env.VITE_EMAILJS_SERVICE_ID || "YOUR_EMAILJS_SERVICE_ID",
  templateId: import.meta.env.VITE_EMAILJS_TEMPLATE_ID || "YOUR_EMAILJS_TEMPLATE_ID",
  publicKey: import.meta.env.VITE_EMAILJS_PUBLIC_KEY || "YOUR_EMAILJS_PUBLIC_KEY",
};
