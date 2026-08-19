import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { FolderGit2, ExternalLink, ArrowUpRight, Shield, Layers, Cpu, Code2 } from 'lucide-react';
import { projects } from '../data/portfolioData';
import ProjectModal from '../components/ProjectModal';
import { useCursor } from '../context/CursorContext';

export default function Projects() {
  const [selectedCategory, setSelectedCategory] = useState('All');
  const [selectedProject, setSelectedProject] = useState(null);
  const { setCursorText, setCursorVariant, resetCursor } = useCursor();

  const categories = ['All', 'Full-Stack & Cloud', 'Mobile & AI', 'Cybersecurity & Identity'];

  const filteredProjects =
    selectedCategory === 'All'
      ? projects
      : projects.filter((p) => p.category === selectedCategory);

  const featuredProject = projects.find((p) => p.featured) || projects[0];

  return (
    <div className="space-y-16">
      {/* Header */}
      <div className="max-w-3xl space-y-4">
        <motion.div
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-cyan-500/10 border border-cyan-500/30 text-cyan-400 font-mono text-xs tracking-wider"
        >
          <FolderGit2 className="w-3.5 h-3.5" />
          <span>PORTFOLIO SHOWCASE</span>
        </motion.div>

        <motion.h1
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="text-3xl sm:text-4xl md:text-5xl font-extrabold tracking-tight text-white"
        >
          Engineered <span className="text-gradient">Projects & Case Studies</span>
        </motion.h1>

        <motion.p
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="text-slate-300 text-base sm:text-lg leading-relaxed"
        >
          Production-ready applications and identity infrastructure engineered with multi-tenancy, clean architecture, and OAuth 2.0 security protocols.
        </motion.p>
      </div>

      {/* Featured Project Showcase Card */}
      {featuredProject && (
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          onClick={() => setSelectedProject(featuredProject)}
          onMouseEnter={() => setCursorText('VIEW')}
          onMouseLeave={resetCursor}
          className="glass-panel glass-panel-hover p-6 sm:p-8 md:p-10 rounded-3xl border border-cyan-500/40 relative cursor-pointer overflow-hidden shadow-[0_0_40px_rgba(0,242,254,0.1)] group"
        >
          <div className="flex flex-col lg:flex-row items-center justify-between gap-8">
            <div className="space-y-4 flex-1">
              <div className="flex items-center gap-3">
                <span className="px-3 py-1 text-xs font-mono font-bold text-black bg-cyan-400 rounded-full">
                  FEATURED CASE STUDY
                </span>
                <span className="text-xs font-mono text-slate-400">{featuredProject.badge}</span>
              </div>

              <h2 className="text-2xl sm:text-3xl font-extrabold text-white group-hover:text-cyan-300 transition-colors flex items-center gap-2">
                <span>{featuredProject.title}</span>
                <ArrowUpRight className="w-6 h-6 text-cyan-400 group-hover:translate-x-1 group-hover:-translate-y-1 transition-transform" />
              </h2>

              <p className="text-slate-300 text-sm sm:text-base leading-relaxed">
                {featuredProject.description}
              </p>

              <div className="flex flex-wrap gap-2 pt-2">
                {featuredProject.techTags.map((tag, i) => (
                  <span
                    key={i}
                    className="px-3 py-1 text-xs font-mono text-cyan-300 bg-cyan-950/40 border border-cyan-500/30 rounded-lg"
                  >
                    {tag}
                  </span>
                ))}
              </div>
            </div>

            {featuredProject.image && (
              <div className="w-full lg:w-96 h-56 rounded-2xl overflow-hidden border border-white/10 shrink-0 relative">
                <img
                  src={featuredProject.image}
                  alt={featuredProject.title}
                  className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                />
                <div className="absolute inset-0 bg-gradient-to-t from-[#050811] via-transparent to-transparent opacity-60" />
              </div>
            )}
          </div>
        </motion.div>
      )}

      {/* Filter Category Pills */}
      <div className="flex flex-wrap gap-2 pt-4">
        {categories.map((cat) => (
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

      {/* Projects Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {filteredProjects.map((project, index) => (
          <motion.div
            key={project.id}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: index * 0.1 }}
            onClick={() => setSelectedProject(project)}
            onMouseEnter={() => setCursorText('OPEN')}
            onMouseLeave={resetCursor}
            className="glass-panel glass-panel-hover p-6 rounded-2xl border border-white/10 cursor-pointer flex flex-col justify-between group"
          >
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <span className="text-xs font-mono text-cyan-400 font-semibold">{project.number}</span>
                <span className="text-[10px] font-mono text-slate-400 bg-slate-800/80 px-2.5 py-1 rounded-md">
                  {project.category}
                </span>
              </div>

              {project.image && (
                <div className="w-full h-40 rounded-xl overflow-hidden border border-white/10">
                  <img
                    src={project.image}
                    alt={project.title}
                    className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                  />
                </div>
              )}

              <h3 className="text-lg font-bold text-white group-hover:text-cyan-300 transition-colors flex items-center justify-between">
                <span>{project.title}</span>
                <ArrowUpRight className="w-4 h-4 text-slate-400 group-hover:text-cyan-400 group-hover:translate-x-0.5 group-hover:-translate-y-0.5 transition-all" />
              </h3>

              <p className="text-xs text-slate-300 leading-relaxed line-clamp-3">
                {project.description}
              </p>
            </div>

            <div className="mt-6 pt-4 border-t border-white/10 flex flex-wrap gap-1.5">
              {project.techTags.slice(0, 4).map((tag, i) => (
                <span
                  key={i}
                  className="px-2 py-0.5 text-[10px] font-mono text-slate-400 bg-slate-900 border border-white/5 rounded-md"
                >
                  {tag}
                </span>
              ))}
            </div>
          </motion.div>
        ))}
      </div>

      {/* Project Detail Modal */}
      {selectedProject && (
        <ProjectModal project={selectedProject} onClose={() => setSelectedProject(null)} />
      )}
    </div>
  );
}
