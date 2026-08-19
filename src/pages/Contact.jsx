import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { Mail, Send, CheckCircle2, Shield, MapPin, Terminal, Globe, Share2 } from 'lucide-react';
import { personalInfo, socialLinks } from '../data/portfolioData';
import { useCursor } from '../context/CursorContext';

export default function Contact() {
  const [formData, setFormData] = useState({ name: '', email: '', message: '' });
  const [submitted, setSubmitted] = useState(false);
  const [loading, setLoading] = useState(false);
  const { setCursorVariant, resetCursor } = useCursor();

  const handleSubmit = (e) => {
    e.preventDefault();
    setLoading(true);
    // Simulate interactive transmission
    setTimeout(() => {
      setLoading(false);
      setSubmitted(true);
      setFormData({ name: '', email: '', message: '' });
    }, 1200);
  };

  return (
    <div className="space-y-16">
      {/* Header */}
      <div className="max-w-3xl space-y-4">
        <motion.div
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-cyan-500/10 border border-cyan-500/30 text-cyan-400 font-mono text-xs tracking-wider"
        >
          <Mail className="w-3.5 h-3.5" />
          <span>INITIATE CONNECTION</span>
        </motion.div>

        <motion.h1
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="text-3xl sm:text-4xl md:text-5xl font-extrabold tracking-tight text-white"
        >
          Let's Build Something <span className="text-gradient">Meaningful.</span>
        </motion.h1>

        <motion.p
          initial={{ opacity: 0, y: 15 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="text-slate-300 text-base sm:text-lg leading-relaxed"
        >
          Whether you have a project idea, security query, or engineering opportunity, feel free to drop a message.
        </motion.p>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-12 gap-10">
        {/* Contact Interactive Form */}
        <motion.div
          initial={{ opacity: 0, x: -20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ delay: 0.2 }}
          className="lg:col-span-7 glass-panel p-6 sm:p-8 md:p-10 rounded-3xl border border-cyan-500/30 shadow-[0_0_40px_rgba(0,242,254,0.1)] relative"
        >
          {submitted ? (
            <div className="py-12 text-center space-y-4">
              <div className="w-16 h-16 rounded-full bg-cyan-500/10 border border-cyan-400 flex items-center justify-center mx-auto text-cyan-400 shadow-[0_0_20px_rgba(0,242,254,0.5)]">
                <CheckCircle2 className="w-8 h-8" />
              </div>
              <h3 className="text-2xl font-bold text-white">Message Transmitted!</h3>
              <p className="text-slate-300 text-sm max-w-md mx-auto">
                Thank you for reaching out. I will review your message and reply promptly.
              </p>
              <button
                onClick={() => setSubmitted(false)}
                className="mt-4 px-6 py-2.5 text-xs font-mono font-semibold text-black bg-cyan-400 rounded-xl hover:bg-cyan-300 transition-all"
              >
                Send Another Message
              </button>
            </div>
          ) : (
            <form onSubmit={handleSubmit} className="space-y-6">
              <div className="space-y-2">
                <label className="text-xs font-mono uppercase text-slate-300 tracking-wider">
                  Your Full Name
                </label>
                <input
                  type="text"
                  required
                  placeholder="e.g. Alex Mercer"
                  value={formData.name}
                  onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                  className="w-full px-4 py-3 rounded-xl bg-slate-900/80 border border-white/10 text-white placeholder-slate-500 focus:outline-none focus:border-cyan-400 focus:ring-1 focus:ring-cyan-400 transition-all text-sm font-sans"
                />
              </div>

              <div className="space-y-2">
                <label className="text-xs font-mono uppercase text-slate-300 tracking-wider">
                  Your Email Address
                </label>
                <input
                  type="email"
                  required
                  placeholder="alex@company.com"
                  value={formData.email}
                  onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                  className="w-full px-4 py-3 rounded-xl bg-slate-900/80 border border-white/10 text-white placeholder-slate-500 focus:outline-none focus:border-cyan-400 focus:ring-1 focus:ring-cyan-400 transition-all text-sm font-sans"
                />
              </div>

              <div className="space-y-2">
                <label className="text-xs font-mono uppercase text-slate-300 tracking-wider">
                  Project / Security Inquiry Message
                </label>
                <textarea
                  required
                  rows={5}
                  placeholder="Tell me about your project, timeline, or security goals..."
                  value={formData.message}
                  onChange={(e) => setFormData({ ...formData, message: e.target.value })}
                  className="w-full px-4 py-3 rounded-xl bg-slate-900/80 border border-white/10 text-white placeholder-slate-500 focus:outline-none focus:border-cyan-400 focus:ring-1 focus:ring-cyan-400 transition-all text-sm font-sans resize-none"
                />
              </div>

              <button
                type="submit"
                disabled={loading}
                onMouseEnter={() => setCursorVariant('button')}
                onMouseLeave={resetCursor}
                className="w-full inline-flex items-center justify-center gap-2 py-3.5 text-sm font-mono font-semibold text-black bg-cyan-400 rounded-xl hover:bg-cyan-300 shadow-[0_0_20px_rgba(0,242,254,0.3)] transition-all disabled:opacity-50"
              >
                {loading ? (
                  <span>TRANSMITTING...</span>
                ) : (
                  <>
                    <Send className="w-4 h-4" />
                    <span>Transmit Message</span>
                  </>
                )}
              </button>
            </form>
          )}
        </motion.div>

        {/* Contact Info Sidebar */}
        <motion.div
          initial={{ opacity: 0, x: 20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ delay: 0.3 }}
          className="lg:col-span-5 space-y-6"
        >
          <div className="glass-panel p-6 sm:p-8 rounded-3xl border border-white/10 space-y-6">
            <h3 className="text-lg font-bold text-white font-mono flex items-center gap-2">
              <Terminal className="w-4 h-4 text-cyan-400" /> DIRECT CHANNELS
            </h3>

            <div className="space-y-4 text-sm text-slate-300">
              <div className="p-4 rounded-2xl bg-slate-900/80 border border-white/5 space-y-1">
                <span className="text-[10px] font-mono text-cyan-400 uppercase">Primary Email</span>
                <a
                  href={`mailto:${personalInfo.email}`}
                  className="block text-white font-mono font-semibold hover:text-cyan-400 transition-colors"
                >
                  {personalInfo.email}
                </a>
              </div>

              <div className="p-4 rounded-2xl bg-slate-900/80 border border-white/5 space-y-1">
                <span className="text-[10px] font-mono text-cyan-400 uppercase">Location</span>
                <p className="text-white font-mono font-semibold flex items-center gap-2">
                  <MapPin className="w-4 h-4 text-cyan-400" /> {personalInfo.location}
                </p>
              </div>

              <div className="p-4 rounded-2xl bg-slate-900/80 border border-white/5 space-y-1">
                <span className="text-[10px] font-mono text-cyan-400 uppercase">Academic ID</span>
                <p className="text-white font-mono font-semibold">{personalInfo.idNumber}</p>
              </div>
            </div>

            {/* Social Links */}
            <div className="pt-4 border-t border-white/10 space-y-3">
              <span className="text-xs font-mono uppercase text-slate-400">Social Profiles</span>
              <div className="flex items-center gap-3">
                {socialLinks.map((link) => (
                  <a
                    key={link.name}
                    href={link.url}
                    target="_blank"
                    rel="noreferrer"
                    onMouseEnter={() => setCursorVariant('button')}
                    onMouseLeave={resetCursor}
                    className="p-3 rounded-xl bg-slate-900 border border-white/10 text-slate-300 hover:text-cyan-400 hover:border-cyan-400 transition-all"
                    aria-label={link.name}
                  >
                    {link.name === 'Email' ? <Mail className="w-5 h-5" /> : <Globe className="w-5 h-5" />}
                  </a>
                ))}
              </div>
            </div>
          </div>
        </motion.div>
      </div>
    </div>
  );
}
