import React from 'react';
import { NavLink } from 'react-router-dom';
import { motion } from 'framer-motion';
import { Shield, ArrowRight, Download, Terminal, Cpu, Lock, Cloud, Code, Network, Globe } from 'lucide-react';
import { heroContent, personalInfo } from '../data/portfolioData';
import { useCursor } from '../context/CursorContext';

export default function Home() {
  const { setCursorText, setCursorVariant, resetCursor } = useCursor();

  return (
    <div className="space-y-24">
      {/* Hero Entrance Section */}
      <section className="relative min-h-[80vh] flex flex-col lg:flex-row items-center justify-between gap-12 pt-8">
        {/* Hero Left Content */}
        <div className="flex-1 space-y-6 text-left">
          {/* Small Introduction Badge */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
            className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-cyan-500/10 border border-cyan-500/30 text-cyan-400 font-mono text-xs tracking-wider"
          >
            <span className="w-2 h-2 rounded-full bg-cyan-400 animate-ping" />
            <span>{heroContent.greeting}</span>
          </motion.div>

          {/* Main Title Heading */}
          <motion.h1
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.1 }}
            className="text-4xl sm:text-5xl lg:text-6xl font-extrabold tracking-tight text-white leading-none"
          >
            Building <span className="text-gradient">Secure Digital</span> Experiences
          </motion.h1>

          {/* Supporting Description */}
          <motion.p
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.2 }}
            className="text-slate-300 text-base sm:text-lg max-w-2xl leading-relaxed"
          >
            {heroContent.subtitle}
          </motion.p>

          {/* Action CTA Buttons */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.3 }}
            className="flex flex-wrap items-center gap-4 pt-4"
          >
            <NavLink
              to="/projects"
              onMouseEnter={() => setCursorText('EXPLORE')}
              onMouseLeave={resetCursor}
              className="inline-flex items-center gap-2 px-6 py-3 text-sm font-mono font-semibold text-black bg-cyan-400 rounded-xl hover:bg-cyan-300 shadow-[0_0_25px_rgba(0,242,254,0.4)] transition-all transform hover:-translate-y-0.5"
            >
              <span>View Projects</span>
              <ArrowRight className="w-4 h-4" />
            </NavLink>

            <NavLink
              to="/contact"
              onMouseEnter={() => setCursorVariant('button')}
              onMouseLeave={resetCursor}
              className="inline-flex items-center gap-2 px-6 py-3 text-sm font-mono font-semibold text-white bg-slate-900/80 hover:bg-slate-800 border border-white/10 rounded-xl hover:border-cyan-400/50 transition-all"
            >
              <span>Contact Me</span>
            </NavLink>

            <a
              href={personalInfo.resumeUrl}
              download
              onMouseEnter={() => setCursorVariant('button')}
              onMouseLeave={resetCursor}
              className="inline-flex items-center gap-2 px-5 py-3 text-sm font-mono text-slate-300 hover:text-cyan-400 transition-colors"
            >
              <Download className="w-4 h-4" />
              <span>Resume</span>
            </a>
          </motion.div>
        </div>

        {/* Hero Right Visual: Interactive Cyber & Cloud Node Terminal */}
        <motion.div
          initial={{ opacity: 0, scale: 0.9 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.7, delay: 0.2 }}
          className="flex-1 w-full max-w-lg lg:max-w-none"
        >
          <div className="relative glass-panel rounded-3xl p-6 sm:p-8 border border-cyan-500/30 shadow-[0_0_50px_rgba(0,242,254,0.12)] overflow-hidden">
            {/* Terminal Top Bar */}
            <div className="flex items-center justify-between pb-4 mb-6 border-b border-white/10">
              <div className="flex items-center gap-2">
                <div className="w-3 h-3 rounded-full bg-red-500/80" />
                <div className="w-3 h-3 rounded-full bg-yellow-500/80" />
                <div className="w-3 h-3 rounded-full bg-green-500/80" />
              </div>
              <div className="flex items-center gap-2 text-xs font-mono text-slate-400">
                <Terminal className="w-3.5 h-3.5 text-cyan-400" />
                <span>ashwin@dev-sec-node:~</span>
              </div>
            </div>

            {/* Terminal Body Node Visual */}
            <div className="grid grid-cols-2 gap-4 font-mono text-xs">
              <div className="p-4 rounded-2xl bg-slate-900/80 border border-white/5 hover:border-cyan-500/40 transition-all group">
                <div className="flex items-center justify-between mb-2">
                  <Lock className="w-5 h-5 text-cyan-400 group-hover:scale-110 transition-transform" />
                  <span className="text-[10px] text-cyan-400">ACTIVE</span>
                </div>
                <h4 className="font-bold text-white mb-1">Cybersecurity</h4>
                <p className="text-[11px] text-slate-400">OAuth 2.0, PKCE, OWASP Top 10</p>
              </div>

              <div className="p-4 rounded-2xl bg-slate-900/80 border border-white/5 hover:border-cyan-500/40 transition-all group">
                <div className="flex items-center justify-between mb-2">
                  <Cloud className="w-5 h-5 text-teal-400 group-hover:scale-110 transition-transform" />
                  <span className="text-[10px] text-teal-400">AWS / DOCKER</span>
                </div>
                <h4 className="font-bold text-white mb-1">Cloud Security</h4>
                <p className="text-[11px] text-slate-400">CI/CD, Containers, IAM</p>
              </div>

              <div className="p-4 rounded-2xl bg-slate-900/80 border border-white/5 hover:border-cyan-500/40 transition-all group">
                <div className="flex items-center justify-between mb-2">
                  <Code className="w-5 h-5 text-violet-400 group-hover:scale-110 transition-transform" />
                  <span className="text-[10px] text-violet-400">REACT / FLUTTER</span>
                </div>
                <h4 className="font-bold text-white mb-1">Full-Stack Dev</h4>
                <p className="text-[11px] text-slate-400">Node.js, Express, MongoDB</p>
              </div>

              <div className="p-4 rounded-2xl bg-slate-900/80 border border-white/5 hover:border-cyan-500/40 transition-all group">
                <div className="flex items-center justify-between mb-2">
                  <Network className="w-5 h-5 text-emerald-400 group-hover:scale-110 transition-transform" />
                  <span className="text-[10px] text-emerald-400">FEDORA / KALI</span>
                </div>
                <h4 className="font-bold text-white mb-1">Linux Systems</h4>
                <p className="text-[11px] text-slate-400">Wireshark, TCP/IP, DNS</p>
              </div>
            </div>

            {/* Code Snippet Status */}
            <div className="mt-6 p-3 rounded-xl bg-black/60 border border-white/5 font-mono text-[11px] text-slate-400 flex items-center justify-between">
              <span className="text-cyan-400">✓ ALL_SYSTEMS_OPERATIONAL</span>
              <span className="text-slate-500">ID: DEV-SEC-2026-AR05</span>
            </div>
          </div>
        </motion.div>
      </section>

      {/* Hero Quick Stats Section */}
      <section className="grid grid-cols-2 md:grid-cols-4 gap-4 sm:gap-6">
        {heroContent.stats.map((stat, index) => (
          <motion.div
            key={index}
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5, delay: index * 0.1 }}
            className="glass-panel glass-panel-hover p-6 rounded-2xl text-center border border-white/10"
          >
            <h3 className="text-3xl sm:text-4xl font-extrabold text-gradient-cyan mb-1">
              {stat.value}
            </h3>
            <p className="text-xs font-mono text-slate-400 uppercase tracking-wider">{stat.label}</p>
          </motion.div>
        ))}
      </section>
    </div>
  );
}
