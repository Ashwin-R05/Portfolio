import React, { useState, useEffect } from 'react';
import { personalInfo } from '../data/portfolioData';

const Navbar = () => {
  const [scrolled, setScrolled] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 60);
    window.addEventListener('scroll', onScroll);
    return () => window.removeEventListener('scroll', onScroll);
  }, []);

  const links = [
    { label: 'Work', href: '#work' },
    { label: 'About', href: '#about' },
    { label: 'Skills', href: '#skills' },
    { label: 'Contact', href: '#contact' },
  ];

  return (
    <header className={`fixed top-0 left-0 w-full z-[999] transition-all duration-500 ${scrolled ? 'bg-black/80 backdrop-blur-xl border-b border-white/[0.06]' : ''}`}>
      <div className="max-w-[1400px] mx-auto px-6 md:px-10 h-16 md:h-20 flex items-center justify-between">
        
        {/* Logo — just the name, ultra-minimal */}
        <a href="#" className="text-white text-sm md:text-base font-semibold tracking-tight">
          {personalInfo.firstName}<span className="text-white/30">.</span>
        </a>

        {/* Desktop Nav */}
        <nav className="hidden md:flex items-center gap-8">
          {links.map(l => (
            <a key={l.label} href={l.href} className="text-white/50 text-[13px] font-medium tracking-wide hover:text-white transition-colors duration-300">
              {l.label}
            </a>
          ))}
          <a 
            href={`mailto:${personalInfo.emails.primary}`}
            className="text-black bg-white text-[13px] font-semibold px-5 py-2 rounded-full hover:bg-white/90 transition-colors"
          >
            Get in touch
          </a>
        </nav>

        {/* Mobile toggle */}
        <button onClick={() => setMenuOpen(!menuOpen)} className="md:hidden text-white w-8 h-8 flex flex-col justify-center items-center gap-1.5" aria-label="Menu">
          <span className={`block w-5 h-[1.5px] bg-white transition-transform duration-300 ${menuOpen ? 'rotate-45 translate-y-[3.5px]' : ''}`} />
          <span className={`block w-5 h-[1.5px] bg-white transition-transform duration-300 ${menuOpen ? '-rotate-45 -translate-y-[3.5px]' : ''}`} />
        </button>
      </div>

      {/* Mobile menu */}
      <div className={`md:hidden overflow-hidden transition-all duration-400 ${menuOpen ? 'max-h-80' : 'max-h-0'}`}>
        <div className="px-6 pb-8 pt-2 flex flex-col gap-5 bg-black/95 backdrop-blur-xl border-b border-white/[0.06]">
          {links.map(l => (
            <a key={l.label} href={l.href} onClick={() => setMenuOpen(false)} className="text-white/60 text-lg font-medium hover:text-white transition-colors">
              {l.label}
            </a>
          ))}
          <a href={`mailto:${personalInfo.emails.primary}`} onClick={() => setMenuOpen(false)} className="text-black bg-white text-sm font-semibold px-5 py-2.5 rounded-full text-center mt-2">
            Get in touch
          </a>
        </div>
      </div>
    </header>
  );
};

export default Navbar;
