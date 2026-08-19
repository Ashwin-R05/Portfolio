import React from 'react';
import { motion } from 'framer-motion';
import { Briefcase, GraduationCap, Calendar, MapPin, CheckCircle2 } from 'lucide-react';
import { experienceTimeline } from '../data/portfolioData';

export default function Experience() {
  return (
    <div className="space-y-16">
      {/* Header */}
      <div className="max-w-3xl space-y-4">
        <motion.div
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-cyan-500/10 border border-cyan-500/30 text-cyan-400 font-mono text-xs tracking-wider"
        >
          <Briefcase className="w-3.5 h-3.5" />
          <span>EXPERIENCE & EDUCATION</span>
        </motion.div>

        <motion.h1
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="text-3xl sm:text-4xl md:text-5xl font-extrabold tracking-tight text-white"
        >
          Professional <span className="text-gradient">Milestones & Growth</span>
        </motion.h1>

        <motion.p
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="text-slate-300 text-base sm:text-lg leading-relaxed"
        >
          Detailed background spanning undergraduate B.Tech IT studies, full-stack software development, and specialized cloud security exploration.
        </motion.p>
      </div>

      {/* Illuminated Progressive Timeline */}
      <div className="relative border-l-2 border-cyan-500/30 ml-4 sm:ml-8 pl-6 sm:pl-10 space-y-12">
        {experienceTimeline.map((item, index) => (
          <motion.div
            key={item.id}
            initial={{ opacity: 0, x: -30 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5, delay: index * 0.15 }}
            className="relative group"
          >
            {/* Illuminated Node Icon */}
            <div className="absolute -left-[33px] sm:-left-[49px] top-1.5 w-6 h-6 rounded-full bg-[#050811] border-2 border-cyan-400 flex items-center justify-center text-cyan-400 shadow-[0_0_15px_rgba(0,242,254,0.6)] group-hover:scale-125 group-hover:bg-cyan-400 group-hover:text-black transition-all">
              {item.type === 'Education' ? (
                <GraduationCap className="w-3.5 h-3.5" />
              ) : (
                <Briefcase className="w-3.5 h-3.5" />
              )}
            </div>

            {/* Timeline Item Card */}
            <div className="glass-panel glass-panel-hover p-6 sm:p-8 rounded-3xl border border-white/10 space-y-6">
              {/* Card Top Metadata */}
              <div className="flex flex-wrap items-center justify-between gap-4 pb-4 border-b border-white/10">
                <div>
                  <span className="px-3 py-1 rounded-full bg-cyan-500/10 border border-cyan-500/30 text-cyan-400 font-mono text-xs font-semibold">
                    {item.category}
                  </span>
                  <h3 className="text-xl sm:text-2xl font-bold text-white mt-2 group-hover:text-cyan-300 transition-colors">
                    {item.role}
                  </h3>
                  <h4 className="text-sm font-semibold text-slate-300">{item.organization}</h4>
                </div>

                <div className="space-y-1 text-right text-xs font-mono text-slate-400">
                  <div className="flex items-center gap-1.5 justify-end">
                    <Calendar className="w-3.5 h-3.5 text-cyan-400" />
                    <span>{item.period}</span>
                  </div>
                  <div className="flex items-center gap-1.5 justify-end">
                    <MapPin className="w-3.5 h-3.5 text-slate-500" />
                    <span>{item.location}</span>
                  </div>
                </div>
              </div>

              {/* Description */}
              <p className="text-sm text-slate-300 leading-relaxed">{item.description}</p>

              {/* Highlights List */}
              <div className="space-y-2">
                <h5 className="text-xs font-mono uppercase text-cyan-400 tracking-wider">
                  Key Milestones & Technical Focus
                </h5>
                <ul className="grid grid-cols-1 sm:grid-cols-2 gap-2">
                  {item.highlights.map((highlight, i) => (
                    <li key={i} className="flex items-start gap-2 text-xs text-slate-300">
                      <CheckCircle2 className="w-3.5 h-3.5 text-cyan-400 shrink-0 mt-0.5" />
                      <span>{highlight}</span>
                    </li>
                  ))}
                </ul>
              </div>

              {/* Tech Tags */}
              <div className="flex flex-wrap gap-2 pt-2">
                {item.technologies.map((tech, i) => (
                  <span
                    key={i}
                    className="px-2.5 py-1 text-xs font-mono text-slate-300 bg-slate-900 border border-white/10 rounded-lg"
                  >
                    {tech}
                  </span>
                ))}
              </div>
            </div>
          </motion.div>
        ))}
      </div>
    </div>
  );
}
