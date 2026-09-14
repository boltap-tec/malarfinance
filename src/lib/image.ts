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

// Shrink one image file to a JPEG data URL no larger than ~targetKb. We lower
// the JPEG quality first, then step the dimensions down, retrying until the
// encoded size is under the target (or we hit a sensible floor). Falls back to
// the raw data URL if the browser can't decode it (e.g. some HEIC files) so
// nothing is silently lost.
export async function shrinkImage(file: File, targetKb = 150, startDim = 1400, minDim = 640): Promise<ShrinkResult> {
  const raw = await readAsDataUrl(file)
  if (!file.type.startsWith('image/')) return { dataUrl: raw, approxKb: kbOf(raw) }
  let img: HTMLImageElement
  try {
    img = await loadImage(raw)
  } catch {
    return { dataUrl: raw, approxKb: kbOf(raw) } // undecodable — keep original
  }
  const canvas = document.createElement('canvas')
  const ctx = canvas.getContext('2d')
  if (!ctx) return { dataUrl: raw, approxKb: kbOf(raw) }
  const longest = Math.max(img.width, img.height) || 1

  const encodeAt = (dim: number): string => {
    const scale = Math.min(1, dim / longest)
    canvas.width = Math.max(1, Math.round(img.width * scale))
    canvas.height = Math.max(1, Math.round(img.height * scale))
    ctx.clearRect(0, 0, canvas.width, canvas.height)
    ctx.drawImage(img, 0, 0, canvas.width, canvas.height)
    let q = 0.82
    let out = canvas.toDataURL('image/jpeg', q)
    while (kbOf(out) > targetKb && q > 0.42) {
      q = Math.round((q - 0.1) * 100) / 100
      out = canvas.toDataURL('image/jpeg', q)
    }
    return out
  }

  try {
    let dim = Math.min(startDim, longest)
    let best = encodeAt(dim)
    // Still too big at this size → shrink the dimensions and try again.
    while (kbOf(best) > targetKb && dim > minDim) {
      dim = Math.max(minDim, Math.round(dim * 0.8))
      best = encodeAt(dim)
    }
    // Never return something larger than the original (tiny PNGs etc.).
    if (best.length >= raw.length) best = raw
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
