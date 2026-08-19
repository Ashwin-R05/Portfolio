import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { X, ExternalLink, Shield, Cpu, Layers, CheckCircle2, AlertCircle, Code2 } from 'lucide-react';
import { useCursor } from '../context/CursorContext';

export default function ProjectModal({ project, onClose }) {
  const { setCursorVariant, resetCursor } = useCursor();

  if (!project) return null;

  return (
    <AnimatePresence>
      <div className="fixed inset-0 z-50 flex items-center justify-center p-4 sm:p-6 md:p-10 overflow-y-auto bg-black/80 backdrop-blur-md">
        {/* Backdrop click listener */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          onClick={onClose}
          className="fixed inset-0"
        />

        {/* Modal Window */}
        <motion.div
          initial={{ opacity: 0, scale: 0.95, y: 20 }}
          animate={{ opacity: 1, scale: 1, y: 0 }}
          exit={{ opacity: 0, scale: 0.95, y: 20 }}
          transition={{ type: 'spring', damping: 25, stiffness: 300 }}
          className="relative z-10 w-full max-w-4xl max-h-[90vh] overflow-y-auto glass-panel border border-cyan-500/30 rounded-3xl p-6 sm:p-8 md:p-10 text-white shadow-[0_0_50px_rgba(0,242,254,0.15)] scrollbar-thin"
        >
          {/* Close Button */}
          <button
            onClick={onClose}
            onMouseEnter={() => setCursorVariant('button')}
            onMouseLeave={resetCursor}
            className="absolute top-6 right-6 p-2 rounded-full bg-slate-800/80 border border-white/10 text-slate-300 hover:text-white hover:border-cyan-400 hover:bg-slate-700 transition-all focus:outline-none"
            aria-label="Close modal"
          >
            <X className="w-5 h-5" />
          </button>

          {/* Badge & Number Header */}
          <div className="flex items-center gap-3 mb-4">
            <span className="px-3 py-1 text-xs font-mono font-semibold text-cyan-400 bg-cyan-500/10 border border-cyan-500/30 rounded-full">
              {project.badge}
            </span>
            <span className="text-xs font-mono text-slate-400">{project.category}</span>
          </div>

          {/* Title */}
          <h2 className="text-2xl sm:text-3xl md:text-4xl font-extrabold tracking-tight mb-4 text-gradient">
            {project.title}
          </h2>

          {/* Image Banner */}
          {project.image && (
            <div className="relative w-full h-52 sm:h-72 rounded-2xl overflow-hidden mb-8 border border-white/10">
              <img
                src={project.image}
                alt={project.title}
                className="w-full h-full object-cover"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-[#050811] via-transparent to-transparent opacity-80" />
            </div>
          )}

          {/* Overview & Description */}
          <div className="space-y-6 text-slate-300 text-sm sm:text-base leading-relaxed mb-8">
            <div>
              <h3 className="text-sm font-mono uppercase text-cyan-400 tracking-wider mb-2 flex items-center gap-2">
                <Shield className="w-4 h-4" /> Overview
              </h3>
              <p>{project.overview || project.description}</p>
            </div>

            {project.problem && (
              <div className="p-4 rounded-xl bg-red-950/20 border border-red-500/20">
                <h4 className="text-xs font-mono uppercase text-red-400 tracking-wider mb-1 flex items-center gap-2">
                  <AlertCircle className="w-4 h-4" /> Problem Statement
                </h4>
                <p className="text-sm text-slate-300">{project.problem}</p>
              </div>
            )}

            {project.solution && (
              <div className="p-4 rounded-xl bg-cyan-950/20 border border-cyan-500/20">
                <h4 className="text-xs font-mono uppercase text-cyan-400 tracking-wider mb-1 flex items-center gap-2">
                  <CheckCircle2 className="w-4 h-4" /> Engineered Solution
                </h4>
                <p className="text-sm text-slate-300">{project.solution}</p>
              </div>
            )}

            {/* Features List */}
            {project.features && (
              <div>
                <h3 className="text-sm font-mono uppercase text-cyan-400 tracking-wider mb-3 flex items-center gap-2">
                  <Layers className="w-4 h-4" /> Key Architectural Features
                </h3>
                <ul className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                  {project.features.map((feature, i) => (
                    <li key={i} className="flex items-start gap-2 text-xs sm:text-sm text-slate-300">
                      <span className="text-cyan-400 mt-1">▹</span>
                      <span>{feature}</span>
                    </li>
                  ))}
                </ul>
              </div>
            )}

            {/* Tech Tags */}
            <div>
              <h3 className="text-sm font-mono uppercase text-slate-400 tracking-wider mb-3 flex items-center gap-2">
                <Cpu className="w-4 h-4" /> Tech Stack & Tools
              </h3>
              <div className="flex flex-wrap gap-2">
                {project.techTags.map((tag, i) => (
                  <span
                    key={i}
                    className="px-3 py-1 text-xs font-mono text-slate-300 bg-slate-800/80 border border-white/10 rounded-lg"
                  >
                    {tag}
                  </span>
                ))}
              </div>
            </div>
          </div>

          {/* Footer Action Buttons */}
          <div className="flex flex-wrap items-center justify-between gap-4 pt-6 border-t border-white/10">
            <div className="flex items-center gap-3">
              {project.links.github && (
                <a
                  href={project.links.github}
                  target="_blank"
                  rel="noreferrer"
                  onMouseEnter={() => setCursorVariant('button')}
                  onMouseLeave={resetCursor}
                  className="inline-flex items-center gap-2 px-5 py-2.5 text-xs font-mono font-semibold text-white bg-slate-800 hover:bg-slate-700 border border-white/20 rounded-xl transition-all"
                >
                  <Code2 className="w-4 h-4 text-cyan-400" />
                  <span>View Source Code</span>
                </a>
              )}
              {project.links.demo && (
                <a
                  href={project.links.demo}
                  target="_blank"
                  rel="noreferrer"
                  onMouseEnter={() => setCursorVariant('button')}
                  onMouseLeave={resetCursor}
                  className="inline-flex items-center gap-2 px-5 py-2.5 text-xs font-mono font-semibold text-black bg-cyan-400 hover:bg-cyan-300 rounded-xl shadow-[0_0_20px_rgba(0,242,254,0.3)] transition-all"
                >
                  <ExternalLink className="w-4 h-4" />
                  <span>Live Demo</span>
                </a>
              )}
            </div>

            <button
              onClick={onClose}
              className="text-xs font-mono text-slate-400 hover:text-white transition-colors"
            >
              Close Window [ESC]
            </button>
          </div>
        </motion.div>
      </div>
    </AnimatePresence>
  );
}
