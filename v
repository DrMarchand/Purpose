# Indirect Mesh Redirects + Unified Reports (`v && V`)

This bundle gives **indirect** implementations so your system enforces:
- Canonical API: **`/api/reports`** (deduped, unified).
- Legacy routes: `/api/v`, `/api/V`, `/api/v1`, `/api/v2`.
- Decision:
  - **Mesh / automated** clients ⇒ **301** to `/api/reports`.
  - **Human** (HTML-preferring) clients ⇒ **404** with message.
- Optional mesh signal header: **`X-Mesh: 1`**.

Pick the layer(s) you control and drop-in the matching snippet. You can stack multiple for belt-and-suspenders.

## Contents
- `nginx/redirects.conf` – Edge redirects with `map` and return.
- `apache/.htaccess` – Fallback for Apache.
- `cloudflare/worker.js` – Worker to classify mesh vs humans.
- `express/legacyRedirect.js` – App-level middleware for Node/Express.
- `k8s/ingress.yaml` – NGINX Ingress with conditional redirect + rewrite.
- `sample-api/server.js` – Tiny Express API serving `/api/reports` (unified).
- `tests/curl.sh` – Smoke tests you can run anywhere.
- `docs/policy.md` – Human-readable policy to paste in your docs/Runbooks.

## Canonical contract
- Unique key for deduping: `DayHour + AdvertiserID + CampaignID + CreativeID`.
- Output is stable, idempotent. Legacy endpoints are not for humans.

---

### Quick start (sample API)
```bash
cd sample-api
npm i
node server.js
# visit http://localhost:8787/api/reports
```

### Test redirects
```bash
bash tests/curl.sh http://localhost:8787
```
