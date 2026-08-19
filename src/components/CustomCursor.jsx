import React, { useEffect, useState } from 'react';
import { motion } from 'framer-motion';
import { useCursor } from '../context/CursorContext';

export default function CustomCursor() {
  const [mousePosition, setMousePosition] = useState({ x: -100, y: -100 });
  const [isHovered, setIsHovered] = useState(false);
  const [isMobile, setIsMobile] = useState(false);
  const { cursorText, cursorVariant } = useCursor();

  useEffect(() => {
    const checkMobile = () => {
      setIsMobile(window.innerWidth < 768 || 'ontouchstart' in window);
    };
    checkMobile();
    window.addEventListener('resize', checkMobile);

    const onMouseMove = (e) => {
      setMousePosition({ x: e.clientX, y: e.clientY });
    };

    window.addEventListener('mousemove', onMouseMove);
    return () => {
      window.removeEventListener('resize', checkMobile);
      window.removeEventListener('mousemove', onMouseMove);
    };
  }, []);

  if (isMobile) return null;

  const variants = {
    default: {
      x: mousePosition.x - 16,
      y: mousePosition.y - 16,
      height: 32,
      width: 32,
      backgroundColor: 'transparent',
      border: '1.5px solid rgba(0, 242, 254, 0.6)',
      transition: { type: 'spring', damping: 25, stiffness: 350, mass: 0.2 },
    },
    hover: {
      x: mousePosition.x - 28,
      y: mousePosition.y - 28,
      height: 56,
      width: 56,
      backgroundColor: 'rgba(0, 242, 254, 0.15)',
      border: '1.5px solid rgba(0, 242, 254, 0.9)',
      transition: { type: 'spring', damping: 20, stiffness: 300 },
    },
    button: {
      x: mousePosition.x - 24,
      y: mousePosition.y - 24,
      height: 48,
      width: 48,
      backgroundColor: 'rgba(79, 172, 254, 0.2)',
      border: '2px solid #00f2fe',
      transition: { type: 'spring', damping: 20, stiffness: 300 },
    },
    text: {
      x: mousePosition.x - 32,
      y: mousePosition.y - 32,
      height: 64,
      width: 64,
      backgroundColor: 'rgba(0, 242, 254, 0.9)',
      border: 'none',
      transition: { type: 'spring', damping: 20, stiffness: 300 },
    }
  };

  const currentVariant = cursorText ? 'text' : (cursorVariant !== 'default' ? cursorVariant : 'default');

  return (
    <>
      {/* Small Precision Dot */}
      <motion.div
        className="fixed top-0 left-0 w-2 h-2 bg-cyan-400 rounded-full pointer-events-none z-50 mix-blend-difference"
        animate={{
          x: mousePosition.x - 4,
          y: mousePosition.y - 4,
        }}
        transition={{ type: 'spring', damping: 30, stiffness: 600, mass: 0.1 }}
      />

      {/* Outer Ring / Cursor Bubble */}
      <motion.div
        className="fixed top-0 left-0 rounded-full pointer-events-none z-50 flex items-center justify-center text-center overflow-hidden shadow-[0_0_15px_rgba(0,242,254,0.3)]"
        variants={variants}
        animate={currentVariant}
      >
        {cursorText && (
          <motion.span
            initial={{ opacity: 0, scale: 0.6 }}
            animate={{ opacity: 1, scale: 1 }}
            className="text-[10px] font-mono font-bold tracking-widest text-black uppercase px-1"
          >
            {cursorText}
          </motion.span>
        )}
      </motion.div>
    </>
  );
}
