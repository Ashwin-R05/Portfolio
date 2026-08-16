import React, { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';

const Preloader = () => {
  const [count, setCount] = useState(0);
  const [done, setDone] = useState(false);

  useEffect(() => {
    const interval = setInterval(() => {
      setCount(prev => {
        if (prev >= 100) {
          clearInterval(interval);
          setTimeout(() => setDone(true), 400);
          return 100;
        }
        // Accelerate towards the end
        const step = prev < 60 ? 2 : prev < 90 ? 3 : 5;
        return Math.min(prev + step, 100);
      });
    }, 30);
    return () => clearInterval(interval);
  }, []);

  return (
    <AnimatePresence>
      {!done && (
        <motion.div
          key="loader"
          exit={{ clipPath: 'inset(0 0 100% 0)' }}
          transition={{ duration: 0.8, ease: [0.77, 0, 0.175, 1] }}
          className="fixed inset-0 z-[9999] bg-black flex flex-col justify-end p-8 md:p-14"
        >
          <div className="flex items-end justify-between">
            <span className="text-[18vw] md:text-[12vw] font-bold leading-none text-white/90 tabular-nums tracking-tighter" style={{ fontFeatureSettings: "'tnum'" }}>
              {String(count).padStart(3, '0')}
            </span>
            <span className="text-xs md:text-sm text-white/40 font-mono tracking-widest uppercase pb-4 md:pb-6">
              Loading
            </span>
          </div>
          <div className="w-full h-[1px] bg-white/10 mt-4">
            <motion.div className="h-full bg-white" style={{ width: `${count}%` }} />
          </div>
        </motion.div>
      )}
    </AnimatePresence>
  );
};

export default Preloader;
