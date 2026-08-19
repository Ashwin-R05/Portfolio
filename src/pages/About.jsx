import React from 'react';
import { motion } from 'framer-motion';
import { Shield, Terminal, Cpu, Award, Milestone, User } from 'lucide-react';
import { aboutContent, personalInfo } from '../data/portfolioData';

export default function About() {
  return (
    <div className="space-y-16">
      {/* Title & Introduction */}
      <div className="max-w-3xl space-y-4">
        <motion.div
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-cyan-500/10 border border-cyan-500/30 text-cyan-400 font-mono text-xs tracking-wider"
        >
          <User className="w-3.5 h-3.5" />
          <span>ABOUT MY JOURNEY</span>
        </motion.div>

        <motion.h1
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="text-3xl sm:text-4xl md:text-5xl font-extrabold tracking-tight text-white leading-tight"
        >
          {aboutContent.heading}
        </motion.h1>

        <motion.p
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="text-slate-300 text-base sm:text-lg leading-relaxed font-light"
        >
          {aboutContent.introduction}
        </motion.p>
      </div>

      {/* Narrative Bio Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {aboutContent.paragraphs.map((para, index) => (
          <motion.div
            key={index}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 + index * 0.1 }}
            className="glass-panel glass-panel-hover p-6 sm:p-8 rounded-3xl border border-white/10 flex flex-col justify-between"
          >
            <div className="space-y-4">
              <div className="w-10 h-10 rounded-xl bg-cyan-500/10 border border-cyan-500/30 flex items-center justify-center text-cyan-400">
                {index === 0 ? <Cpu className="w-5 h-5" /> : index === 1 ? <Shield className="w-5 h-5" /> : <Terminal className="w-5 h-5" />}
              </div>
              <p className="text-slate-300 text-sm leading-relaxed">{para}</p>
            </div>
            <div className="pt-6 mt-6 border-t border-white/10 flex items-center justify-between text-xs font-mono text-slate-500">
              <span>SECTION 0{index + 1}</span>
              <span className="text-cyan-400">CORE FOCUS</span>
            </div>
          </motion.div>
        ))}
      </div>

      {/* Interactive Timeline Section */}
      <div className="space-y-8 pt-8 border-t border-white/10">
        <div className="space-y-2">
          <h2 className="text-2xl sm:text-3xl font-extrabold text-white flex items-center gap-3">
            <Milestone className="w-6 h-6 text-cyan-400" />
            <span>Development & Cybersecurity Evolution</span>
          </h2>
          <p className="text-slate-400 text-sm">
            Progressive trajectory from foundational programming to full-stack engineering and cloud security practice.
          </p>
        </div>

        <div className="relative border-l-2 border-cyan-500/20 ml-4 sm:ml-8 pl-6 sm:pl-10 space-y-10">
          {aboutContent.timeline.map((item, index) => (
            <motion.div
              key={index}
              initial={{ opacity: 0, x: -20 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              transition={{ delay: index * 0.1 }}
              className="relative group"
            >
              {/* Illuminated Timeline Node */}
              <div className="absolute -left-[31px] sm:-left-[47px] top-1 w-5 h-5 rounded-full bg-[#050811] border-2 border-cyan-400 group-hover:scale-125 group-hover:bg-cyan-400 transition-all shadow-[0_0_10px_rgba(0,242,254,0.5)]" />

              <div className="glass-panel p-5 sm:p-6 rounded-2xl border border-white/10 group-hover:border-cyan-500/40 transition-all">
                <span className="px-3 py-1 rounded-full bg-cyan-500/10 border border-cyan-500/30 text-cyan-400 font-mono text-xs font-semibold">
                  {item.year}
                </span>
                <h3 className="text-lg font-bold text-white mt-3 mb-1 group-hover:text-cyan-300 transition-colors">
                  {item.title}
                </h3>
                <p className="text-slate-300 text-sm leading-relaxed">{item.description}</p>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </div>
  );
}
