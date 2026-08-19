import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { Code2, Layers, Cloud, Shield, Database, Terminal, Cpu, ExternalLink, CheckCircle2 } from 'lucide-react';
import { skillsData } from '../data/portfolioData';
import { useCursor } from '../context/CursorContext';

const iconMap = {
  Code2: Code2,
  Layers: Layers,
  Cloud: Cloud,
  Shield: Shield,
  Database: Database,
  Terminal: Terminal,
};

export default function Skills() {
  const [selectedCategory, setSelectedCategory] = useState('All');
  const [hoveredSkill, setHoveredSkill] = useState(null);
  const { setCursorVariant, resetCursor } = useCursor();

  const categories = ['All', ...skillsData.map((s) => s.category)];

  const allSkills = skillsData.flatMap((cat) =>
    cat.skills.map((skill) => ({ ...skill, category: cat.category }))
  );

  const displayedSkills =
    selectedCategory === 'All'
      ? allSkills
      : allSkills.filter((s) => s.category === selectedCategory);

  return (
    <div className="space-y-12">
      {/* Page Title Header */}
      <div className="max-w-3xl space-y-4">
        <motion.div
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-cyan-500/10 border border-cyan-500/30 text-cyan-400 font-mono text-xs tracking-wider"
        >
          <Cpu className="w-3.5 h-3.5" />
          <span>TECHNICAL ECOSYSTEM</span>
        </motion.div>

        <motion.h1
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="text-3xl sm:text-4xl md:text-5xl font-extrabold tracking-tight text-white"
        >
          Skills & Technical <span className="text-gradient">Capabilities</span>
        </motion.h1>

        <motion.p
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="text-slate-300 text-base sm:text-lg leading-relaxed"
        >
          Interactive capability breakdown across Software Development, Cloud Security, Networking, and Infrastructure Engineering.
        </motion.p>
      </div>

      {/* Category Filter Pills */}
      <div className="flex flex-wrap gap-2 pt-2">
        {categories.map((cat, i) => (
          <button
            key={cat}
            onClick={() => setSelectedCategory(cat)}
            onMouseEnter={() => setCursorVariant('button')}
            onMouseLeave={resetCursor}
            className={`px-4 py-2 rounded-xl text-xs font-mono font-medium transition-all ${
              selectedCategory === cat
                ? 'bg-cyan-400 text-black font-bold shadow-[0_0_15px_rgba(0,242,254,0.4)]'
                : 'bg-slate-900/60 text-slate-400 border border-white/10 hover:border-cyan-400/40 hover:text-white'
            }`}
          >
            {cat}
          </button>
        ))}
      </div>

      {/* Skill Ecosystem Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        {displayedSkills.map((skill, index) => (
          <motion.div
            key={skill.name}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: index * 0.05 }}
            onMouseEnter={() => setHoveredSkill(skill.name)}
            onMouseLeave={() => setHoveredSkill(null)}
            className="glass-panel glass-panel-hover p-6 rounded-2xl border border-white/10 relative group flex flex-col justify-between"
          >
            <div className="space-y-4">
              {/* Category & Badge */}
              <div className="flex items-center justify-between">
                <span className="text-[10px] font-mono uppercase tracking-wider text-cyan-400 bg-cyan-500/10 px-2.5 py-1 rounded-md border border-cyan-500/20">
                  {skill.category}
                </span>
                <span className="text-xs font-mono text-slate-400">{skill.experience}</span>
              </div>

              {/* Title & Description */}
              <div>
                <h3 className="text-lg font-bold text-white group-hover:text-cyan-300 transition-colors mb-2">
                  {skill.name}
                </h3>
                <p className="text-xs text-slate-300 leading-relaxed">{skill.description}</p>
              </div>
            </div>

            {/* Proficiency Meter */}
            <div className="mt-6 pt-4 border-t border-white/10 space-y-2">
              <div className="flex items-center justify-between text-xs font-mono">
                <span className="text-slate-400">Proficiency</span>
                <span className="text-cyan-400 font-bold">{skill.level}%</span>
              </div>
              <div className="w-full h-1.5 bg-slate-800 rounded-full overflow-hidden">
                <motion.div
                  className="h-full bg-gradient-to-r from-cyan-400 to-teal-400"
                  initial={{ width: 0 }}
                  animate={{ width: `${skill.level}%` }}
                  transition={{ duration: 1, delay: index * 0.05 }}
                />
              </div>
            </div>
          </motion.div>
        ))}
      </div>
    </div>
  );
}
