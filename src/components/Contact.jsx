import React, { useState } from 'react';
import { personalInfo, emailjsConfig } from '../data/portfolioData';

const Contact = () => {
  const [status, setStatus] = useState('idle');

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (status === 'sending') return;

    setStatus('sending');
    const form = e.target;
    const name = form.name?.value || '';
    const email = form.email?.value || '';
    const message = form.message?.value || '';

    const isConfigured = 
      emailjsConfig.serviceId && 
      emailjsConfig.serviceId !== 'YOUR_EMAILJS_SERVICE_ID' &&
      emailjsConfig.templateId && 
      emailjsConfig.templateId !== 'YOUR_EMAILJS_TEMPLATE_ID' &&
      emailjsConfig.publicKey && 
      emailjsConfig.publicKey !== 'YOUR_EMAILJS_PUBLIC_KEY';

    if (!isConfigured) {
      const mailtoLink = `mailto:${personalInfo.emails.primary}?subject=Security%20Inquiry%20from%20${encodeURIComponent(name)}&body=${encodeURIComponent(`Sender: ${name}\nEmail: ${email}\n\nMessage:\n${message}`)}`;
      window.open(mailtoLink, '_blank');
      setStatus('success');
      form.reset();
      setTimeout(() => setStatus('idle'), 3000);
      return;
    }

    try {
      const emailjs = await import('@emailjs/browser');
      await emailjs.sendForm(
        emailjsConfig.serviceId,
        emailjsConfig.templateId,
        form,
        emailjsConfig.publicKey
      );
      setStatus('success');
      form.reset();
    } catch (error) {
      console.error('EmailJS Error:', error);
      setStatus('error');
    }

    setTimeout(() => setStatus('idle'), 3000);
  };

  return (
    <section id="contact" className="bg-black px-6 md:px-10 py-24 md:py-36 border-t border-white/[0.06]">
      <div className="max-w-[1400px] mx-auto">
        {/* Section label */}
        <div className="flex items-center gap-4 mb-16 md:mb-24">
          <span className="text-white/20 text-xs font-mono tracking-widest uppercase">06</span>
          <div className="flex-1 h-[1px] bg-white/[0.06]" />
          <span className="text-white/20 text-xs font-mono tracking-widest uppercase">Contact</span>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-20">
          <div>
            <h2 className="text-4xl md:text-6xl font-bold text-white tracking-tight mb-6">
              Let's build<br />
              <span className="text-white/30">secure systems.</span>
            </h2>
            <p className="text-white/40 text-sm md:text-base leading-relaxed mb-8 max-w-md">
              Available for penetration testing, security audits, eBPF telemetry research, and vulnerability assessments.
            </p>

            <div className="space-y-2 text-sm font-mono">
              <div className="text-white/30">DIRECT DISPATCH</div>
              <a href={`mailto:${personalInfo.emails.primary}`} className="text-white hover:underline text-lg font-sans font-medium block">
                {personalInfo.emails.primary}
              </a>
            </div>
          </div>

          <div>
            <form onSubmit={handleSubmit} className="space-y-6">
              <div>
                <input 
                  type="text" 
                  name="name" 
                  required 
                  placeholder="Your Name" 
                  className="w-full bg-transparent border-b border-white/20 py-3 text-white text-sm focus:border-white focus:outline-none transition-colors placeholder:text-white/20"
                />
              </div>
              <div>
                <input 
                  type="email" 
                  name="email" 
                  required 
                  placeholder="Your Email Address" 
                  className="w-full bg-transparent border-b border-white/20 py-3 text-white text-sm focus:border-white focus:outline-none transition-colors placeholder:text-white/20"
                />
              </div>
              <div>
                <textarea 
                  name="message" 
                  rows={4} 
                  required 
                  placeholder="Project details or scope of engagement..." 
                  className="w-full bg-transparent border-b border-white/20 py-3 text-white text-sm focus:border-white focus:outline-none transition-colors resize-none placeholder:text-white/20"
                />
              </div>

              <button 
                type="submit"
                disabled={status === 'sending'}
                className="text-black bg-white text-[13px] font-semibold px-8 py-3 rounded-full hover:bg-white/90 transition-colors disabled:opacity-50"
              >
                {status === 'sending' ? 'Sending...' : status === 'success' ? 'Message Sent' : 'Send Message'}
              </button>
            </form>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Contact;
