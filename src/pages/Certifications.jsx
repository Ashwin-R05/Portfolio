import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Award, GraduationCap, Code, ShieldAlert, Terminal, Cloud, Lock, ExternalLink, X, CheckCircle2 } from 'lucide-react';
import { certificationsList } from '../data/portfolioData';
import { useCursor } from '../context/CursorContext';

const iconMap = {
  GraduationCap: GraduationCap,
  Code: Code,
  ShieldAlert: ShieldAlert,
  Terminal: Terminal,
  Cloud: Cloud,
  Lock: Lock,
};

export default function Certifications() {
  const [selectedCert, setSelectedCert] = useState(null);
  const { setCursorText, setCursorVariant, resetCursor } = useCursor();

  return (
    <div className="space-y-16">
      {/* Header */}
      <div className="max-w-3xl space-y-4">
        <motion.div
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-cyan-500/10 border border-cyan-500/30 text-cyan-400 font-mono text-xs tracking-wider"
        >
          <Award className="w-3.5 h-3.5" />
          <span>VERIFIED CREDENTIALS</span>
        </motion.div>

        <motion.h1
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="text-3xl sm:text-4xl md:text-5xl font-extrabold tracking-tight text-white"
        >
          Certifications & <span className="text-gradient">Technical Badges</span>
        </motion.h1>

        <motion.p
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="text-slate-300 text-base sm:text-lg leading-relaxed"
        >
          Academic credentials, domain specializations in OAuth 2.0 & Linux systems, and cloud security verification.
        </motion.p>
      </div>

      {/* Certifications Gallery Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {certificationsList.map((cert, index) => {
          const IconComponent = iconMap[cert.icon] || Award;
          return (
            <motion.div
              key={cert.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
              onClick={() => setSelectedCert(cert)}
              onMouseEnter={() => setCursorText('VIEW')}
              onMouseLeave={resetCursor}
              className="glass-panel glass-panel-hover p-6 rounded-3xl border border-white/10 cursor-pointer flex flex-col justify-between group transition-all duration-300 hover:-translate-y-1"
            >
              <div className="space-y-4">
                <div className="flex items-center justify-between">
                  <div className="w-10 h-10 rounded-2xl bg-cyan-500/10 border border-cyan-500/30 flex items-center justify-center text-cyan-400 group-hover:scale-110 group-hover:shadow-[0_0_15px_rgba(0,242,254,0.4)] transition-all">
                    <IconComponent className="w-5 h-5" />
                  </div>
                  <span className="text-[10px] font-mono uppercase text-cyan-400 bg-cyan-950/40 px-2.5 py-1 rounded-md border border-cyan-500/20">
                    {cert.badge}
                  </span>
                </div>

                <div>
                  <h3 className="text-lg font-bold text-white group-hover:text-cyan-300 transition-colors mb-1">
                    {cert.title}
                  </h3>
                  <p className="text-xs font-mono text-slate-400">{cert.organization}</p>
                </div>

                <p className="text-xs text-slate-300 leading-relaxed">{cert.description}</p>
              </div>

              <div className="mt-6 pt-4 border-t border-white/10 flex items-center justify-between text-xs font-mono text-slate-400">
                <span>{cert.date}</span>
                <span className="text-cyan-400 group-hover:underline flex items-center gap-1">
                  Preview <ExternalLink className="w-3 h-3" />
                </span>
              </div>
            </motion.div>
          );
        })}
      </div>

      {/* Certificate Modal */}
      <AnimatePresence>
        {selectedCert && (
          <div className="fixed inset-0 z-50 flex items-center justify-center p-4 sm:p-6 bg-black/80 backdrop-blur-md">
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              onClick={() => setSelectedCert(null)}
              className="fixed inset-0"
            />

            <motion.div
              initial={{ opacity: 0, scale: 0.95, y: 20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.95, y: 20 }}
              className="relative z-10 w-full max-w-lg glass-panel border border-cyan-500/40 rounded-3xl p-6 sm:p-8 text-white shadow-[0_0_50px_rgba(0,242,254,0.2)]"
            >
              <button
                onClick={() => setSelectedCert(null)}
                className="absolute top-6 right-6 p-2 rounded-full bg-slate-800 text-slate-300 hover:text-white"
              >
                <X className="w-5 h-5" />
              </button>

              <div className="flex items-center gap-3 mb-4">
                <span className="px-3 py-1 text-xs font-mono text-cyan-400 bg-cyan-500/10 border border-cyan-500/30 rounded-full">
                  {selectedCert.badge}
                </span>
                <span className="text-xs font-mono text-slate-400">{selectedCert.date}</span>
              </div>

              <h3 className="text-2xl font-bold mb-2 text-gradient">{selectedCert.title}</h3>
              <p className="text-sm font-semibold text-slate-300 mb-4">{selectedCert.organization}</p>

              <p className="text-xs text-slate-300 leading-relaxed mb-6">{selectedCert.description}</p>

              <div className="p-4 rounded-xl bg-slate-900/80 border border-white/10 mb-6 space-y-2">
                <div className="text-xs font-mono text-slate-400 flex items-center justify-between">
                  <span>Credential ID:</span>
                  <span className="text-cyan-400">{selectedCert.credentialId}</span>
                </div>
              </div>

              <div className="flex justify-end gap-3 pt-4 border-t border-white/10">
                <a
                  href={selectedCert.verifyUrl}
                  target="_blank"
                  rel="noreferrer"
                  className="inline-flex items-center gap-2 px-5 py-2.5 text-xs font-mono font-semibold text-black bg-cyan-400 rounded-xl hover:bg-cyan-300"
                >
                  <ExternalLink className="w-4 h-4" />
                  <span>Verify Credential</span>
                </a>
              </div>
            </motion.div>
          </div>
        )}
      </AnimatePresence>
    </div>
  );
}
