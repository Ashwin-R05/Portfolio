import React from 'react';
import { motion } from 'framer-motion';

export default function AnimatedBackground() {
  return (
    <div className="fixed inset-0 pointer-events-none z-0 overflow-hidden bg-[#050811]">
      {/* Subtle Grid overlay */}
      <div className="absolute inset-0 bg-grid-pattern opacity-15" />

      {/* Ambient Gradient Blob 1 - Top Left Electric Cyan */}
      <motion.div
        className="absolute top-[-10%] left-[-10%] w-[50vw] h-[50vw] rounded-full bg-cyan-500/10 blur-[120px]"
        animate={{
          x: [0, 50, -30, 0],
          y: [0, -40, 30, 0],
          scale: [1, 1.15, 0.95, 1],
        }}
        transition={{
          duration: 18,
          repeat: Infinity,
          ease: 'easeInOut',
        }}
      />

      {/* Ambient Gradient Blob 2 - Bottom Right Violet */}
      <motion.div
        className="absolute bottom-[-10%] right-[-10%] w-[55vw] h-[55vw] rounded-full bg-violet-600/10 blur-[150px]"
        animate={{
          x: [0, -60, 40, 0],
          y: [0, 50, -30, 0],
          scale: [1, 1.2, 0.9, 1],
        }}
        transition={{
          duration: 22,
          repeat: Infinity,
          ease: 'easeInOut',
        }}
      />

      {/* Ambient Gradient Blob 3 - Center Glow Teal */}
      <motion.div
        className="absolute top-[35%] left-[25%] w-[40vw] h-[40vw] rounded-full bg-teal-500/05 blur-[130px]"
        animate={{
          x: [0, 40, -40, 0],
          y: [0, 30, -50, 0],
          scale: [0.9, 1.1, 1, 0.9],
        }}
        transition={{
          duration: 25,
          repeat: Infinity,
          ease: 'easeInOut',
        }}
      />

      {/* Floating Particle Dots */}
      {[...Array(15)].map((_, index) => (
        <motion.div
          key={index}
          className="absolute rounded-full bg-cyan-400/20"
          style={{
            top: `${(index * 7 + 12) % 90}%`,
            left: `${(index * 13 + 5) % 95}%`,
            width: index % 2 === 0 ? '3px' : '2px',
            height: index % 2 === 0 ? '3px' : '2px',
          }}
          animate={{
            y: [0, -40, 0],
            opacity: [0.2, 0.7, 0.2],
          }}
          transition={{
            duration: 4 + (index % 5) * 2,
            repeat: Infinity,
            ease: 'easeInOut',
            delay: index * 0.4,
          }}
        />
      ))}
    </div>
  );
}
