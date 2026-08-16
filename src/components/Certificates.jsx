import React from 'react';
import { certificates } from '../data/portfolioData';

const Certifications = () => {
  // Double the array for seamless infinite scroll
  const doubled = [...certificates.featured, ...certificates.featured];

  return (
    <section className="bg-black py-24 md:py-36 border-t border-white/[0.06] overflow-hidden">
      <div className="max-w-[1400px] mx-auto px-6 md:px-10">

        {/* Section label */}
        <div className="flex items-center gap-4 mb-16 md:mb-24">
          <span className="text-white/20 text-xs font-mono tracking-widest uppercase">05</span>
          <div className="flex-1 h-[1px] bg-white/[0.06]" />
          <span className="text-white/20 text-xs font-mono tracking-widest uppercase">Certifications</span>
        </div>
      </div>

      {/* Infinite horizontal marquee ticker */}
      <div className="relative">
        {/* Fade masks on left and right edges */}
        <div className="absolute left-0 top-0 bottom-0 w-20 md:w-40 bg-gradient-to-r from-black to-transparent z-10 pointer-events-none" />
        <div className="absolute right-0 top-0 bottom-0 w-20 md:w-40 bg-gradient-to-l from-black to-transparent z-10 pointer-events-none" />

        <div className="flex animate-marquee w-max">
          {doubled.map((cert, i) => (
            <div
              key={`${cert.name}-${i}`}
              className="shrink-0 mx-3 md:mx-4 border border-white/[0.06] rounded-2xl px-6 py-5 md:px-8 md:py-6 flex items-center gap-4 hover:border-white/20 transition-colors duration-300 group cursor-default min-w-[280px] md:min-w-[340px]"
            >
              <span className="text-2xl shrink-0">{cert.icon}</span>
              <div>
                <h4 className="text-white text-sm font-semibold leading-snug mb-0.5">{cert.name}</h4>
                <p className="text-white/25 text-xs font-mono">{cert.issuer}</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="max-w-[1400px] mx-auto px-6 md:px-10 mt-12 flex justify-center">
        <a
          href={certificates.viewAllUrl}
          target="_blank"
          rel="noopener noreferrer"
          className="text-white/30 text-[13px] font-medium hover:text-white transition-colors inline-flex items-center gap-2"
        >
          Verify on LinkedIn
          <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" d="M7 17L17 7M17 7H7M17 7v10" />
          </svg>
        </a>
      </div>
    </section>
  );
};

export default Certifications;
