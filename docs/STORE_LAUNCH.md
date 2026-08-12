# Flouka POS — store launch checklist (Apple / Google)

Bundle ID: `com.zeroonez.flouka.pos`  
Display name: Flouka POS / Flouka Vendeur

**Ordre** : 1) valider staging + simuler review → [`STORE_REVIEW_SIM.md`](./STORE_REVIEW_SIM.md) · 2) Cloudflare / nouveau serveur · 3) builds prod + upload stores.

## Prérequis code (déjà en place)
- [x] Release API → `https://api.flouka.app/api/` (`Constants.baseUri` en `kReleaseMode`)
- [x] Auto-login seed **off** en release
- [x] HttpOverrides cert-bypass **off** en release
- [x] Cleartext limité au staging IP (network security config)
- [x] Info.plist usage strings (camera / photos / micro / localisation)
- [x] `android/key.properties.example` pour signing upload

## Android — Google Play (internal track)

1. Créer / rejoindre le compte [Google Play Console](https://play.google.com/console).
2. Créer l’app **Flouka POS** (catégorie Business), package `com.zeroonez.flouka.pos`.
3. Générer un keystore upload (une seule fois) :

```bash
mkdir -p android/keystore
keytool -genkey -v -keystore android/keystore/flouka-pos-upload.jks \
  -keyalg RSA -keysize 2048 -validity 10000 -alias flouka-pos
```

4. Copier `android/key.properties.example` → `android/key.properties` (ne pas committer).
5. Build AAB :

```bash
flutter build appbundle --release
# → build/app/outputs/bundle/release/app-release.aab
```

6. Play Console → Testing → Internal testing → upload AAB + liste testeurs.
7. Fiche store (draft FR) : nom, short/full description, icon 512, feature graphic, screenshots tablette paysage.

## iOS — App Store Connect / TestFlight

1. Compte [Apple Developer](https://developer.apple.com) (Organization si possible).
2. App Store Connect → New App → Bundle ID `com.zeroonez.flouka.pos`.
3. Xcode : ouvrir `ios/Runner.xcworkspace`, Team ID, signing Automatic (Release).
4. Build / archive :

```bash
flutter build ipa --release
# ou Archive depuis Xcode → Distribute → TestFlight
```

5. TestFlight → Internal / External testing.
6. Privacy questionnaire : photos, camera, location (aligné Info.plist).

## Après Cloudflare / nouveau serveur
- Pointer `api.flouka.app` (HTTPS) vers l’API.
- Vérifier que les builds release joignent bien `https://api.flouka.app/api/`.
- Rebuild AAB/IPA si l’URL API change.

## Hors day-1
- Publish public store (après internal QA)
- Push FCM production (handlers encore partiels)
