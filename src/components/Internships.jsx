import React from 'react';
import { internshipsList } from '../data/portfolioData';

const Experience = () => {
  return (
    <section className="bg-black px-6 md:px-10 py-24 md:py-36 border-t border-white/[0.06]">
      <div className="max-w-[1400px] mx-auto">

        {/* Section label */}
        <div className="flex items-center gap-4 mb-16 md:mb-24">
          <span className="text-white/20 text-xs font-mono tracking-widest uppercase">04</span>
          <div className="flex-1 h-[1px] bg-white/[0.06]" />
          <span className="text-white/20 text-xs font-mono tracking-widest uppercase">Experience</span>
        </div>

        {/* Experience rows — simple, clean, horizontal */}
        <div className="space-y-0">
          {internshipsList.map((exp, idx) => (
            <div 
              key={exp.organization}
              className="group py-8 md:py-10 border-b border-white/[0.06] first:border-t grid grid-cols-1 md:grid-cols-12 gap-4 md:gap-8 items-start hover:bg-white/[0.01] transition-colors duration-300 -mx-4 px-4 rounded-lg"
            >
              {/* Left: Duration */}
              <div className="md:col-span-2">
                <span className="text-white/20 text-xs font-mono tracking-wider">{exp.duration}</span>
              </div>

              {/* Center: Role + Org */}
              <div className="md:col-span-5">
                <h3 className="text-white text-lg font-semibold tracking-tight mb-1">{exp.role}</h3>
                <p className="text-white/30 text-sm">{exp.organization}</p>
              </div>

              {/* Right: Key skills */}
              <div className="md:col-span-5">
                <div className="flex flex-wrap gap-2">
                  {exp.tech.map(t => (
                    <span key={t} className="text-white/30 text-xs font-mono border border-white/[0.06] px-3 py-1 rounded-full group-hover:text-white/50 group-hover:border-white/15 transition-colors">
                      {t}
                    </span>
                  ))}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default Experience;
