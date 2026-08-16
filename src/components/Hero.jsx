import React, { useEffect, useState } from 'react';
import { motion } from 'framer-motion';
import { heroContent, personalInfo, socialLinks } from '../data/portfolioData';

const Hero = () => {
  const [roleIdx, setRoleIdx] = useState(0);
  const roles = heroContent.roles || [];

  useEffect(() => {
    const timer = setInterval(() => {
      setRoleIdx(prev => (prev + 1) % roles.length);
    }, 3000);
    return () => clearInterval(timer);
  }, [roles.length]);

  return (
    <section className="relative min-h-screen flex flex-col justify-end bg-black px-6 md:px-10 pb-12 md:pb-16 pt-32 overflow-hidden">
      
      {/* Background — two thin crossing lines */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-0 left-1/3 w-[1px] h-full bg-white/[0.04]" />
        <div className="absolute top-0 right-1/4 w-[1px] h-full bg-white/[0.04]" />
      </div>

      <div className="max-w-[1400px] mx-auto w-full relative z-10">
        {/* Top meta line */}
        <motion.div 
          initial={{ opacity: 0, y: 20 }} 
          animate={{ opacity: 1, y: 0 }} 
          transition={{ delay: 1.8, duration: 0.6 }}
          className="flex flex-wrap items-center gap-x-6 gap-y-2 mb-8 md:mb-12"
        >
          <span className="text-white/30 text-xs font-mono tracking-widest uppercase">Based in India</span>
          <span className="text-white/10">—</span>
          <span className="text-white/30 text-xs font-mono tracking-widest uppercase">Open to Global Remote</span>
          <span className="text-white/10">—</span>
          <span className="text-white/30 text-xs font-mono tracking-widest uppercase">Available for Engagements</span>
        </motion.div>

        {/* Main headline — massive stacked typography */}
        <div className="mb-8 md:mb-12">
          <motion.h1 
            initial={{ opacity: 0, y: 50 }} 
            animate={{ opacity: 1, y: 0 }} 
            transition={{ delay: 2.0, duration: 0.8, ease: [0.16, 1, 0.3, 1] }}
            className="text-[clamp(2.5rem,10vw,8rem)] font-bold leading-[0.9] tracking-[-0.04em] text-white"
          >
            Cybersecurity
          </motion.h1>
          <motion.h1 
            initial={{ opacity: 0, y: 50 }} 
            animate={{ opacity: 1, y: 0 }} 
            transition={{ delay: 2.15, duration: 0.8, ease: [0.16, 1, 0.3, 1] }}
            className="text-[clamp(2.5rem,10vw,8rem)] font-bold leading-[0.9] tracking-[-0.04em] text-white/20"
          >
            Engineer<span className="text-white">.</span>
          </motion.h1>
        </div>

        {/* Bottom row — description left, role-cycle + links right */}
        <motion.div 
          initial={{ opacity: 0 }} 
          animate={{ opacity: 1 }} 
          transition={{ delay: 2.4, duration: 0.7 }}
          className="flex flex-col md:flex-row md:items-end justify-between gap-8 border-t border-white/[0.08] pt-8"
        >
          {/* Left: description */}
          <p className="text-white/40 text-sm md:text-[15px] leading-relaxed max-w-lg">
            {heroContent.subtitle}
          </p>

          {/* Right: role cycle + action links */}
          <div className="flex flex-col items-start md:items-end gap-5 shrink-0">
            {/* Animated role */}
            <div className="h-6 overflow-hidden">
              <motion.span
                key={roleIdx}
                initial={{ y: 24, opacity: 0 }}
                animate={{ y: 0, opacity: 1 }}
                exit={{ y: -24, opacity: 0 }}
                transition={{ duration: 0.5 }}
                className="block text-white/60 text-sm font-mono"
              >
                {roles[roleIdx]}
              </motion.span>
            </div>

            <div className="flex items-center gap-4">
              <a href="#work" className="text-black bg-white text-[13px] font-semibold px-6 py-2.5 rounded-full hover:bg-white/90 transition-colors">
                View Work
              </a>
              <a href={socialLinks.github} target="_blank" rel="noopener noreferrer" className="text-white/40 text-[13px] font-medium hover:text-white transition-colors">
                GitHub ↗
              </a>
              <a href={socialLinks.linkedin} target="_blank" rel="noopener noreferrer" className="text-white/40 text-[13px] font-medium hover:text-white transition-colors">
                LinkedIn ↗
              </a>
            </div>
          </div>
        </motion.div>
      </div>
    </section>
  );
};

export default Hero;
