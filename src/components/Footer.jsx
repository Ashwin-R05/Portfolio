import React from 'react';
import { personalInfo, socialLinks } from '../data/portfolioData';

const Footer = () => {
  return (
    <footer className="bg-black px-6 md:px-10 py-12 border-t border-white/[0.06] text-white/40 text-xs font-mono">
      <div className="max-w-[1400px] mx-auto flex flex-col md:flex-row items-center justify-between gap-6">
        <div>
          © {new Date().getFullYear()} {personalInfo.name}. All rights reserved.
        </div>

        <div className="flex items-center gap-6">
          <a href={socialLinks.github} target="_blank" rel="noopener noreferrer" className="hover:text-white transition-colors">
            GitHub
          </a>
          <a href={socialLinks.linkedin} target="_blank" rel="noopener noreferrer" className="hover:text-white transition-colors">
            LinkedIn
          </a>
          <a href={socialLinks.hackthebox} target="_blank" rel="noopener noreferrer" className="hover:text-white transition-colors">
            HackTheBox
          </a>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
