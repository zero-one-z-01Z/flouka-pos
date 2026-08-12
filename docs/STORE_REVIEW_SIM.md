# Simulation review Apple / Google — staging d’abord

Valider **sur staging** avant Cloudflare / prod. Les builds « store-like » pointent l’API staging via `dart-define` (sans toucher l’URL prod des builds déjà en review).

## Environnement

| Service | URL |
|---------|-----|
| API | `http://72.60.191.26:3102/api/` |
| POS web | `http://72.60.191.26:3101` |
| Marketplace | `http://72.60.191.26:3100` |
| Seed vendor | `21610000001` / `FloukaSeed1!` · device token `123456` |

## 0 — Smoke auto (à relancer avant chaque session QA)

```bash
bash /Users/wassef/flouka-pos-web/scripts/smoke-staging.sh http://72.60.191.26:3101
bash /Users/wassef/flouka-pos-web/deploy/staging/e2e-api.sh
```

Attendu : **PASSED** (withdraw 404 = WARN OK).

## 1 — Builds « comme le store » → staging

Release/profile **sans** auto-login, mais API staging :

```bash
cd /Users/wassef/flouka-pos

# Android APK (install sideload / device review)
flutter build apk --release \
  --dart-define=FLOUKA_API_BASE=http://72.60.191.26:3102/

# Android AAB (Play internal — staging only, ne pas soumettre public)
flutter build appbundle --release \
  --dart-define=FLOUKA_API_BASE=http://72.60.191.26:3102/

# iOS (device / TestFlight interne staging)
flutter build ipa --release \
  --dart-define=FLOUKA_API_BASE=http://72.60.191.26:3102/
```

Debug quotidien (staging + auto-login possible) :

```bash
flutter run --debug
```

**Ne pas** uploader un AAB/IPA staging sur la track **production** / App Store public.

## 2 — Parcours Google Play (simulation review)

Checklist type reviewer Play (compte seed) :

1. **Cold start** — écran login vide (pas de seed prérempli en release).
2. **Login** — phone + password + device token → Overview KPI.
3. **Produits** — liste, ouvrir détail, créer / éditer (photo si possible).
4. **Commandes** — liste, ouvrir une commande, changer statut si dispo.
5. **Wallet** — solde + opérations ; withdraw empty OK si 404.
6. **Settings / tickets** — ouvrir sans crash.
7. **Permissions** — camera / photos : prompt système + usage string.
8. **Offline / mauvais réseau** — message d’erreur propre, pas de crash.
9. **Back / rotate** — pas de crash sur tablet paysage (POS).
10. **Logout** → retour login.

Play Console (quand compte prêt) : Internal testing → upload AAB **staging** uniquement pour QA interne.

## 3 — Parcours Apple App Review (simulation)

Même parcours fonctionnel + points Apple :

1. Login **manuel** (demo account dans notes Review : seed ci-dessus).
2. Aucune URL HTTP hors allowlist (staging IP déjà dans network security ; iOS ATS : HTTP staging OK en sim, prod sera HTTPS).
3. Privacy labels alignés Info.plist (camera, photos, micro, localisation).
4. Pas de contenu placeholder cassé sur le happy path.
5. Compte démo fonctionnel 24/7 (seed staging).

TestFlight : build avec `FLOUKA_API_BASE` staging pour QA ; build **sans** override seulement quand `api.flouka.app` est live.

## 4 — POS web (complément tablet browser)

Sur `http://72.60.191.26:3101` :

- [ ] Login seed → dashboard
- [ ] Products / Orders / Wallet / Settings
- [ ] Upload image produit
- [ ] FR/AR si applicable

## 5 — Go / No-go avant Cloudflare

| Critère | Statut |
|---------|--------|
| Smoke POS web + API e2e | à cocher session |
| Parcours §2 Android device | |
| Parcours §3 iOS device | |
| Aucun crash P0 | |
| Compte démo documenté pour stores | seed OK |

Puis seulement : nouveau serveur + Cloudflare + rebuild **sans** `FLOUKA_API_BASE` (→ `https://api.flouka.app/`).
