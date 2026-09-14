// Client-side image shrinking for jewel-loan photos. Phones produce 3–8 MB
// images; storing those raw would bloat the database and slow every load. We
// draw each picture onto a canvas, scale it down to a sensible longest edge and
// re-encode as JPEG — typically 60–150 KB — then keep it as a data URL. No
// upload bucket is needed: the string is stored like any other field.

export interface ShrinkResult { dataUrl: string; approxKb: number }

// Read a File as a data URL.
function readAsDataUrl(file: File): Promise<string> {
  return new Promise((resolve, reject) => {
    const fr = new FileReader()
    fr.onload = () => resolve(String(fr.result))
    fr.onerror = () => reject(fr.error ?? new Error('read failed'))
    fr.readAsDataURL(file)
  })
}

function loadImage(src: string): Promise<HTMLImageElement> {
  return new Promise((resolve, reject) => {
    const img = new Image()
    img.onload = () => resolve(img)
    img.onerror = () => reject(new Error('decode failed'))
    img.src = src
  })
}

// Rough size of a data URL's payload in KB (base64 is ~4/3 of the bytes).
const kbOf = (dataUrl: string) => Math.round(((dataUrl.length - (dataUrl.indexOf(',') + 1)) * 0.75) / 1024)

// Shrink one image file to a JPEG data URL. Falls back to the raw data URL if
// the browser can't decode it (e.g. some HEIC files) so nothing is silently lost.
export async function shrinkImage(file: File, maxDim = 1400, quality = 0.72): Promise<ShrinkResult> {
  const raw = await readAsDataUrl(file)
  if (!file.type.startsWith('image/')) return { dataUrl: raw, approxKb: kbOf(raw) }
  let img: HTMLImageElement
  try {
    img = await loadImage(raw)
  } catch {
    return { dataUrl: raw, approxKb: kbOf(raw) } // undecodable — keep original
  }
  const longest = Math.max(img.width, img.height) || 1
  const scale = Math.min(1, maxDim / longest)
  const w = Math.max(1, Math.round(img.width * scale))
  const h = Math.max(1, Math.round(img.height * scale))
  const canvas = document.createElement('canvas')
  canvas.width = w; canvas.height = h
  const ctx = canvas.getContext('2d')
  if (!ctx) return { dataUrl: raw, approxKb: kbOf(raw) }
  ctx.drawImage(img, 0, 0, w, h)
  try {
    const out = canvas.toDataURL('image/jpeg', quality)
    // Keep whichever is smaller (a tiny source can encode larger as JPEG).
    const best = out.length < raw.length ? out : raw
    return { dataUrl: best, approxKb: kbOf(best) }
  } catch {
    return { dataUrl: raw, approxKb: kbOf(raw) }
  }
}

// Shrink several files, skipping any that fail. `onProgress` lets the UI show
// "Processing 2 of 4…" while big pictures are crunched.
export async function shrinkImages(
  files: File[],
  onProgress?: (done: number, total: number) => void,
): Promise<string[]> {
  const out: string[] = []
  for (let i = 0; i < files.length; i++) {
    try {
      const r = await shrinkImage(files[i])
      out.push(r.dataUrl)
    } catch { /* skip this one */ }
    onProgress?.(i + 1, files.length)
  }
  return out
}
