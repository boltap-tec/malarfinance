import { Camera, ImagePlus } from 'lucide-react'

// Two ways to add pictures: "Take photo" opens the camera directly (capture),
// "Upload" opens the gallery / file picker and allows several at once.
//
// The file inputs are wrapped in <label>s rather than triggered with a
// programmatic .click(). Many Android WebViews (the APK) silently ignore a
// scripted click on a hidden input, so the picker never opens — a real label
// tap always opens it.
export default function PhotoInputs({ onFiles, small }: { onFiles: (files: File[]) => void; small?: boolean }) {
  const handle = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = Array.from(e.target.files ?? [])
    e.target.value = '' // allow re-picking the same file
    if (files.length) onFiles(files)
  }
  const cls = `btn-ghost cursor-pointer ring-1 ring-inset ring-brand-500/30 text-brand-300 ${small ? '!py-1 text-xs' : '!py-1.5'}`
  const size = small ? 14 : 15
  return (
    <div className="flex flex-wrap gap-2">
      <label className={cls}>
        <Camera size={size} /> Take photo
        <input type="file" accept="image/*" capture="environment" className="hidden" onChange={handle} />
      </label>
      <label className={cls}>
        <ImagePlus size={size} /> Upload
        <input type="file" accept="image/*" multiple className="hidden" onChange={handle} />
      </label>
    </div>
  )
}
