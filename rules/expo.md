# Expo 56 + React Native 0.85 + NativeWind 4

Verify against Context7 (Expo v56, NativeWind v4) before coding — Expo has breaking changes per SDK.

- **Expo Router** (file-based routing under `app/`). New Architecture (Fabric/TurboModules) is default.
- **NativeWind 4:** `className` on RN components; requires `nativewind/babel` preset + `metro.config.js` wrapper + `global.css`. Tailwind classes map to RN styles — not every web class exists.
- Use Expo SDK modules over bare RN native code where available.
- Test on device/simulator; RN styling ≠ web CSS (no cascade, flex defaults differ: `flexDirection: 'column'`).
