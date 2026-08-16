import React from 'react';
import { aboutContent, personalInfo, education } from '../data/portfolioData';

const statItems = [
  { value: '3+', label: 'Production Projects' },
  { value: '6', label: 'Platforms Shipped (Flutter)' },
  { value: 'OAuth 2.0', label: 'Auth Infrastructure' },
  { value: 'B.Tech IT', label: 'Undergraduate Degree' },
];

const About = () => {
  return (
    <section id="about" className="bg-black px-6 md:px-10 py-24 md:py-36 border-t border-white/[0.06]">
      <div className="max-w-[1400px] mx-auto">

        {/* Section label */}
        <div className="flex items-center gap-4 mb-16 md:mb-24">
          <span className="text-white/20 text-xs font-mono tracking-widest uppercase">01</span>
          <div className="flex-1 h-[1px] bg-white/[0.06]" />
          <span className="text-white/20 text-xs font-mono tracking-widest uppercase">About</span>
        </div>

        {/* Top: Bio + Stats Bento */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-20 mb-20 md:mb-28">
          
          {/* Left: Bio narrative */}
          <div>
            <h2 className="text-3xl md:text-5xl font-bold text-white leading-[1.1] tracking-tight mb-8">
              Engineering full-stack applications<br/>
              <span className="text-white/25">with a cloud security mindset.</span>
            </h2>
            <div className="text-white/45 text-[15px] leading-relaxed space-y-4 max-w-lg">
              {personalInfo.bioLines.map((paragraph, idx) => (
                <p key={idx}>{paragraph}</p>
              ))}
              <p className="text-white/30 text-sm font-mono pt-2">
                {education.degree} · {education.institution} · {education.location}
              </p>
            </div>
            <div className="mt-8 flex items-center gap-4">
              <a 
                href={`mailto:${personalInfo.emails.primary}`}
                className="text-black bg-white text-[13px] font-semibold px-6 py-2.5 rounded-full hover:bg-white/90 transition-colors inline-flex items-center gap-2"
              >
                Contact Me
              </a>
              <a href={personalInfo.github} target="_blank" rel="noopener noreferrer" className="text-white/40 text-[13px] font-medium hover:text-white transition-colors">
                GitHub Profile ↗
              </a>
            </div>
          </div>

          {/* Right: Stats grid */}
          <div className="grid grid-cols-2 gap-4">
            {statItems.map((s, i) => (
              <div key={i} className="border border-white/[0.06] rounded-2xl p-6 md:p-8 flex flex-col justify-between min-h-[140px] hover:border-white/20 transition-colors duration-400 group">
                <span className="text-2xl md:text-3xl font-bold text-white group-hover:text-white transition-colors font-mono">{s.value}</span>
                <span className="text-white/30 text-xs font-mono tracking-wider uppercase mt-auto">{s.label}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Bottom: Core Focus Disciplines */}
        <div>
          <h3 className="text-white/20 text-xs font-mono tracking-widest uppercase mb-6">Core Focus &amp; Technologies</h3>
          <div className="flex flex-wrap gap-3">
            {aboutContent.techStack.map(skill => (
              <span key={skill} className="px-5 py-2.5 rounded-full border border-white/[0.08] text-white/50 text-sm font-medium hover:text-white hover:border-white/30 transition-all duration-300 cursor-default">
                {skill}
              </span>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
};

export default About;
