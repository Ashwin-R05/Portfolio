import React from 'react';
import { technicalSkills } from '../data/portfolioData';

const Skills = () => {
  // Flatten all skills from all categories into one array for a masonry-feel bento
  const allCategories = technicalSkills.categories;

  return (
    <section id="skills" className="bg-black px-6 md:px-10 py-24 md:py-36 border-t border-white/[0.06]">
      <div className="max-w-[1400px] mx-auto">

        {/* Section label */}
        <div className="flex items-center gap-4 mb-16 md:mb-24">
          <span className="text-white/20 text-xs font-mono tracking-widest uppercase">03</span>
          <div className="flex-1 h-[1px] bg-white/[0.06]" />
          <span className="text-white/20 text-xs font-mono tracking-widest uppercase">Technical Arsenal</span>
        </div>

        {/* Bento grid — asymmetric layout */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {allCategories.map((cat, catIdx) => (
            <div 
              key={cat.title}
              className={`border border-white/[0.06] rounded-2xl p-6 md:p-8 hover:border-white/20 transition-colors duration-400 ${
                catIdx === 0 ? 'lg:row-span-2' : ''
              }`}
            >
              <h3 className="text-white text-base font-semibold mb-6 tracking-tight">
                {cat.title}
              </h3>
              <div className="space-y-4">
                {cat.skills.map(skill => (
                  <div key={skill.name}>
                    <div className="flex items-center justify-between mb-1.5">
                      <span className="text-white/50 text-[13px]">{skill.name}</span>
                      <span className="text-white/20 text-xs font-mono">{skill.level}</span>
                    </div>
                    <div className="w-full h-[3px] bg-white/[0.06] rounded-full overflow-hidden">
                      <div className="h-full bg-white/60 rounded-full" style={{ width: `${skill.level}%` }} />
                    </div>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default Skills;
