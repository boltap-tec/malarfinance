import { useState, useEffect, useRef } from 'react'
import { useSearchParams, useNavigate } from 'react-router-dom'
import { useApp, canEdit } from '../store/app'

// Lets a page open its "New …" form directly from a link like /loans?new=1
// (used by the command palette and dashboard quick-actions).
//
// If the form was opened by navigating here via such a link, closing it takes
// the user BACK to the screen they came from — instead of stranding them on the
// table they were sent to. If the form was opened by the page's own "New" button
// (no ?new=1 in the URL), closing just hides it and stays put.
// View-only roles (partners) can never open a create form, even by URL.
export function useCreateParam(): [boolean, (v: boolean) => void] {
  const [params, setParams] = useSearchParams()
  const navigate = useNavigate()
  const role = useApp(s => s.user?.role)
  const allowed = canEdit(role)
  const viaUrl = allowed && params.get('new') === '1'
  const [open, setOpen] = useState(viaUrl)
  // Remember whether this form was reached through a ?new=1 link.
  const openedViaUrl = useRef(viaUrl)

  useEffect(() => {
    if (allowed && params.get('new') === '1') { setOpen(true); openedViaUrl.current = true }
  }, [params, allowed])

  const set = (v: boolean) => {
    setOpen(v)
    if (v) return
    // Closing. If we arrived via a quick-action link, return to the previous
    // screen; otherwise just clear the flag so a refresh doesn't reopen the form.
    if (openedViaUrl.current) {
      openedViaUrl.current = false
      if (window.history.length > 1) { navigate(-1); return }
    }
    if (params.get('new') === '1') {
      params.delete('new')
      setParams(params, { replace: true })
    }
  }
  return [open, set]
}
