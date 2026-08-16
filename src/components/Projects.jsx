import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { projects, socialLinks } from '../data/portfolioData';

const Projects = () => {
  const [activeIdx, setActiveIdx] = useState(0);
  const active = projects[activeIdx];

  return (
    <section id="work" className="bg-black px-6 md:px-10 py-24 md:py-36 border-t border-white/[0.06]">
      <div className="max-w-[1400px] mx-auto">

        {/* Section label */}
        <div className="flex items-center gap-4 mb-16 md:mb-24">
          <span className="text-white/20 text-xs font-mono tracking-widest uppercase">02</span>
          <div className="flex-1 h-[1px] bg-white/[0.06]" />
          <span className="text-white/20 text-xs font-mono tracking-widest uppercase">Featured Engineering Projects</span>
        </div>

        {/* Two-column layout: project list left, detail right */}
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 lg:gap-0">
          
          {/* Left: Clickable project list */}
          <div className="lg:col-span-5 lg:pr-12 lg:border-r border-white/[0.06]">
            {projects.map((proj, idx) => (
              <button
                key={proj.id}
                onClick={() => setActiveIdx(idx)}
                className={`w-full text-left py-6 border-b border-white/[0.06] group transition-all duration-300 ${
                  idx === activeIdx ? 'opacity-100' : 'opacity-40 hover:opacity-70'
                }`}
              >
                <div className="flex items-baseline justify-between mb-2">
                  <span className="text-white/20 text-xs font-mono">{proj.number}</span>
                  <svg className={`w-4 h-4 text-white/20 transition-transform duration-300 ${idx === activeIdx ? 'rotate-45' : ''}`} fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M12 4v16m8-8H4" />
                  </svg>
                </div>
                <h3 className="text-white text-lg md:text-xl font-semibold tracking-tight leading-snug">
                  {proj.title.split('—')[0].trim()}
                </h3>
                <p className="text-white/30 text-xs mt-1 font-mono">
                  {proj.subtitle}
                </p>
              </button>
            ))}

            <a 
              href={socialLinks.github} 
              target="_blank" 
              rel="noopener noreferrer"
              className="inline-flex items-center gap-2 mt-8 text-white/30 text-[13px] font-medium hover:text-white transition-colors"
            >
              All repositories on GitHub (Ashwin-R05)
              <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" d="M7 17L17 7M17 7H7M17 7v10" />
              </svg>
            </a>
          </div>

          {/* Right: Active project detail */}
          <div className="lg:col-span-7 lg:pl-12 flex flex-col justify-center min-h-[440px]">
            <AnimatePresence mode="wait">
              <motion.div
                key={active.id}
                initial={{ opacity: 0, y: 15 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: -15 }}
                transition={{ duration: 0.4, ease: [0.16, 1, 0.3, 1] }}
              >
                <span className="text-white/20 text-xs font-mono tracking-widest uppercase block mb-4">
                  {active.badge?.replace(/[^\w\s&—–-]/g, '').trim()}
                </span>

                <h2 className="text-2xl md:text-3xl font-bold text-white tracking-tight leading-snug mb-4">
                  {active.title}
                </h2>

                <p className="text-white/40 text-[14px] leading-relaxed mb-6 max-w-xl">
                  {active.description}
                </p>

                {/* Key Features List */}
                {active.features && (
                  <div className="mb-6 space-y-2">
                    <span className="text-white/20 text-xs font-mono uppercase tracking-wider block mb-2">Key Highlights:</span>
                    <ul className="space-y-1.5 pl-4 list-disc marker:text-white/30 text-white/50 text-xs leading-relaxed">
                      {active.features.map((feat, i) => (
                        <li key={i}>{feat}</li>
                      ))}
                    </ul>
                  </div>
                )}

                <div className="flex flex-wrap gap-2 mb-8">
                  {active.techTags.map(tag => (
                    <span key={tag} className="px-3.5 py-1.5 text-xs text-white/50 font-mono border border-white/[0.08] rounded-full">
                      {tag}
                    </span>
                  ))}
                </div>

                <div className="flex items-center gap-4">
                  {active.links.github && (
                    <a href={active.links.github} target="_blank" rel="noopener noreferrer" className="text-black bg-white text-[13px] font-semibold px-6 py-2.5 rounded-full hover:bg-white/90 transition-colors inline-flex items-center gap-2">
                      <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path fillRule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z" clipRule="evenodd" /></svg>
                      Repository Source Code ↗
                    </a>
                  )}
                </div>
              </motion.div>
            </AnimatePresence>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Projects;
