import React from 'react';
import { NavLink } from 'react-router-dom';
import { Shield, Mail, ArrowUp, Globe, Share2 } from 'lucide-react';
import { footerContent, personalInfo, socialLinks } from '../data/portfolioData';

export default function Footer() {
  const scrollToTop = () => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  return (
    <footer className="relative border-t border-white/10 bg-[#050811] text-slate-400 font-sans pt-12 pb-8 overflow-hidden">
      {/* Animated Gradient Line Top Border */}
      <div className="absolute top-0 left-0 right-0 h-[1px] bg-gradient-to-r from-transparent via-cyan-400 to-transparent opacity-60" />

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 space-y-8">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          {/* Brand Col */}
          <div className="md:col-span-2 space-y-3">
            <NavLink to="/" className="inline-flex items-center gap-2 font-mono font-bold text-white text-lg">
              <Shield className="w-5 h-5 text-cyan-400" />
              <span>{footerContent.brandName}</span>
            </NavLink>
            <p className="text-xs text-slate-400 max-w-sm leading-relaxed">
              {footerContent.tagline}
            </p>
            <p className="text-[11px] font-mono text-cyan-400/80">
              {footerContent.credential}
            </p>
          </div>

          {/* Nav Links */}
          <div className="space-y-2 text-xs font-mono">
            <span className="text-white font-bold uppercase tracking-wider block mb-3">Navigation</span>
            <ul className="space-y-1.5">
              <li><NavLink to="/" className="hover:text-cyan-400 transition-colors">Home</NavLink></li>
              <li><NavLink to="/about" className="hover:text-cyan-400 transition-colors">About</NavLink></li>
              <li><NavLink to="/projects" className="hover:text-cyan-400 transition-colors">Projects</NavLink></li>
              <li><NavLink to="/skills" className="hover:text-cyan-400 transition-colors">Skills</NavLink></li>
              <li><NavLink to="/experience" className="hover:text-cyan-400 transition-colors">Experience</NavLink></li>
              <li><NavLink to="/certifications" className="hover:text-cyan-400 transition-colors">Certifications</NavLink></li>
              <li><NavLink to="/contact" className="hover:text-cyan-400 transition-colors">Contact</NavLink></li>
            </ul>
          </div>

          {/* Social Links */}
          <div className="space-y-2 text-xs font-mono">
            <span className="text-white font-bold uppercase tracking-wider block mb-3">Connect</span>
            <div className="flex flex-wrap gap-2">
              {socialLinks.map((link) => (
                <a
                  key={link.name}
                  href={link.url}
                  target="_blank"
                  rel="noreferrer"
                  className="p-2.5 rounded-lg bg-slate-900 border border-white/10 text-slate-300 hover:text-cyan-400 hover:border-cyan-400 transition-all flex items-center justify-center"
                  aria-label={link.name}
                >
                  {link.name === 'Email' ? <Mail className="w-4 h-4" /> : <Globe className="w-4 h-4" />}
                </a>
              ))}
            </div>
          </div>
        </div>

        {/* Bottom Bar */}
        <div className="pt-6 border-t border-white/10 flex flex-col sm:flex-row items-center justify-between gap-4 text-xs font-mono">
          <p className="text-slate-500">{footerContent.copyright}</p>

          <button
            onClick={scrollToTop}
            className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-slate-900 border border-white/10 text-slate-300 hover:text-cyan-400 hover:border-cyan-400/50 transition-all"
          >
            <span>Back to top</span>
            <ArrowUp className="w-3.5 h-3.5" />
          </button>
        </div>
      </div>
    </footer>
  );
}
