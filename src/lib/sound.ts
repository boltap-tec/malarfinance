// Tiny Web-Audio UI sounds — no asset files, CSP-safe. A soft click for taps and
// a two-note chime for primary/submit actions. Respects a mute flag.
let ctx: AudioContext | null = null
function audio(): AudioContext | null {
  try {
    const Ctx = window.AudioContext || (window as any).webkitAudioContext
    if (!Ctx) return null
    if (!ctx) ctx = new Ctx()
    if (ctx.state === 'suspended') ctx.resume()
    return ctx
  } catch { return null }
}

const MUTE_KEY = 'arul-finance:muted'
export function isMuted(): boolean { return localStorage.getItem(MUTE_KEY) === '1' }
export function setMuted(v: boolean): void { localStorage.setItem(MUTE_KEY, v ? '1' : '0') }

function tone(freq: number, dur = 0.07, type: OscillatorType = 'triangle', gain = 0.05, delay = 0): void {
  const c = audio()
  if (!c || isMuted()) return
  const t = c.currentTime + delay
  const osc = c.createOscillator()
  const g = c.createGain()
  osc.connect(g); g.connect(c.destination)
  osc.type = type
  osc.frequency.value = freq
  g.gain.setValueAtTime(0.0001, t)
  g.gain.exponentialRampToValueAtTime(gain, t + 0.008)
  g.gain.exponentialRampToValueAtTime(0.0001, t + dur)
  osc.start(t); osc.stop(t + dur + 0.02)
}

export function playClick(): void { tone(480, 0.05, 'triangle', 0.045) }
export function playAction(): void { tone(620, 0.07, 'sine', 0.06); tone(880, 0.08, 'sine', 0.055, 0.06) }
