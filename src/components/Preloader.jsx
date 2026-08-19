import React, { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Shield, Terminal } from 'lucide-react';
import { personalInfo } from '../data/portfolioData';

export default function Preloader() {
  const [progress, setProgress] = useState(0);
  const [isLoading, setIsLoading] = useState(() => {
    return !sessionStorage.getItem('hasSeenPreloader');
  });

  useEffect(() => {
    if (!isLoading) return;

    const interval = setInterval(() => {
      setProgress((prev) => {
        if (prev >= 100) {
          clearInterval(interval);
          setTimeout(() => {
            setIsLoading(false);
            sessionStorage.setItem('hasSeenPreloader', 'true');
          }, 400);
          return 100;
        }
        const diff = Math.floor(Math.random() * 15) + 5;
        return Math.min(prev + diff, 100);
      });
    }, 100);

    return () => clearInterval(interval);
  }, [isLoading]);

  return (
    <AnimatePresence>
      {isLoading && (
        <motion.div
          key="preloader"
          initial={{ opacity: 1 }}
          exit={{ opacity: 0, scale: 1.05 }}
          transition={{ duration: 0.5, ease: [0.16, 1, 0.3, 1] }}
          className="fixed inset-0 z-50 flex flex-col items-center justify-center bg-[#050811] text-white select-none overflow-hidden"
        >
          <div className="relative flex flex-col items-center max-w-sm px-6 text-center">
            {/* Glowing Animated Shield Icon */}
            <motion.div
              initial={{ scale: 0.8, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ duration: 0.5 }}
              className="relative flex items-center justify-center w-20 h-20 mb-8 rounded-2xl bg-cyan-500/10 border border-cyan-500/30 shadow-[0_0_40px_rgba(0,242,254,0.25)]"
            >
              <Shield className="w-10 h-10 text-cyan-400 animate-pulse" />
              <div className="absolute inset-0 rounded-2xl border border-cyan-400/40 animate-ping opacity-20" />
            </motion.div>

            {/* Monogram / Brand Title */}
            <motion.div
              initial={{ y: 20, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ delay: 0.2, duration: 0.5 }}
              className="mb-2 font-mono text-xl font-bold tracking-widest uppercase"
            >
              <span>{personalInfo.brandName}</span>
              <span className="text-cyan-400">.DEV</span>
            </motion.div>

            <p className="text-xs font-mono text-slate-400 mb-8 tracking-wider uppercase">
              Initializing Secure Cyber & Cloud Environment...
            </p>

            {/* Progress Bar Container */}
            <div className="w-full h-1.5 bg-slate-800/80 rounded-full overflow-hidden border border-white/5 mb-4">
              <motion.div
                className="h-full bg-gradient-to-r from-cyan-400 via-teal-400 to-violet-500 rounded-full shadow-[0_0_10px_rgba(0,242,254,0.8)]"
                initial={{ width: '0%' }}
                animate={{ width: `${progress}%` }}
                transition={{ ease: 'easeOut' }}
              />
            </div>

            {/* Counter Text */}
            <div className="flex items-center justify-between w-full font-mono text-xs text-slate-400">
              <span className="flex items-center gap-1">
                <Terminal className="w-3 h-3 text-cyan-400" />
                <span>SYSTEM_LOAD</span>
              </span>
              <span className="text-cyan-400 font-bold">{progress.toString().padStart(3, '0')} %</span>
            </div>
          </div>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
