import html2canvas from 'html2canvas'
import { jsPDF } from 'jspdf'

// Turn a self-contained statement HTML document into a paginated A4 PDF Blob.
// The HTML is rendered off-screen in an isolated iframe (so its <style> can't
// leak into the app), captured to a canvas, then sliced across PDF pages.
export async function htmlToPdfBlob(html: string): Promise<Blob> {
  const doc = html.replace(/<script[\s\S]*?<\/script>/g, '') // drop the auto-print hook
  const WIDTH = 820 // logical px width the statement is laid out at

  const iframe = document.createElement('iframe')
  iframe.setAttribute('aria-hidden', 'true')
  iframe.style.cssText = `position:fixed;left:-10000px;top:0;width:${WIDTH}px;height:10px;border:0;opacity:0;`
  document.body.appendChild(iframe)
  try {
    const idoc = iframe.contentDocument!
    idoc.open(); idoc.write(doc); idoc.close()
    // Let layout settle (and fonts apply) before capture.
    await new Promise(r => setTimeout(r, 80))

    const canvas = await html2canvas(idoc.body, { scale: 2, backgroundColor: '#ffffff', windowWidth: WIDTH, useCORS: true })

    const pdf = new jsPDF({ unit: 'pt', format: 'a4' })
    const pageW = pdf.internal.pageSize.getWidth()
    const pageH = pdf.internal.pageSize.getHeight()
    const imgW = pageW
    const imgH = canvas.height * (imgW / canvas.width)
    const imgData = canvas.toDataURL('image/jpeg', 0.92)

    let heightLeft = imgH
    let position = 0
    pdf.addImage(imgData, 'JPEG', 0, position, imgW, imgH)
    heightLeft -= pageH
    while (heightLeft > 0) {
      position -= pageH
      pdf.addPage()
      pdf.addImage(imgData, 'JPEG', 0, position, imgW, imgH)
      heightLeft -= pageH
    }
    return pdf.output('blob')
  } finally {
    document.body.removeChild(iframe)
  }
}

export type ShareResult = 'shared' | 'downloaded'

// Share a PDF via the native share sheet (WhatsApp etc.) when the platform
// supports sharing files; otherwise fall back to downloading it so the user
// can attach it manually.
export async function sharePdf(blob: Blob, filename: string, title: string): Promise<ShareResult> {
  const file = new File([blob], filename, { type: 'application/pdf' })
  const nav = navigator as Navigator & { canShare?: (d: any) => boolean; share?: (d: any) => Promise<void> }
  if (nav.canShare?.({ files: [file] }) && nav.share) {
    try {
      await nav.share({ files: [file], title, text: title })
      return 'shared'
    } catch (e) {
      // User dismissed the sheet — treat as handled, don't also download.
      if ((e as { name?: string })?.name === 'AbortError') return 'shared'
      // Otherwise fall through to download.
    }
  }
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url; a.download = filename
  document.body.appendChild(a); a.click(); a.remove()
  setTimeout(() => URL.revokeObjectURL(url), 5000)
  return 'downloaded'
}

// Convenience: build a PDF from statement HTML and share/download it.
export async function shareStatementPdf(html: string, filename: string, title: string): Promise<ShareResult> {
  const blob = await htmlToPdfBlob(html)
  return sharePdf(blob, filename, title)
}
