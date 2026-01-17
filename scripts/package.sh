#!/usr/bin/env bash
set -euo pipefail

# --- Config ---
SDK="${ANDROID_SDK_ROOT:?ANDROID_SDK_ROOT not set}"
BT="$SDK/build-tools/34.0.0"
OUT="$(pwd)/build/apk"
STAGE="$OUT/stage"

echo "[+] SDK: $SDK"
echo "[+] Build-tools: $BT"

# --- Clean ---
rm -rf "$OUT"
mkdir -p "$STAGE/lib/arm64-v8a"

# --- Copy native libraries ---
cp build/android/core/libcore.so "$STAGE/lib/arm64-v8a/"
cp build/android/loader/libnative_activity.so "$STAGE/lib/arm64-v8a/"

# --- Compile resources ---
"$BT/aapt2" compile \
  --dir apk \
  -o "$OUT/compiled.zip"

# --- Link resources INTO DIRECTORY (critical flag) ---
"$BT/aapt2" link \
  --output-to-dir \
  -o "$STAGE" \
  --manifest apk/AndroidManifest.xml \
  -I "$SDK/platforms/android-34/android.jar" \
  "$OUT/compiled.zip"

# --- Create APK manually (preserves native libs) ---
rm -f "$OUT/app-unsigned.apk" "$OUT/app-aligned.apk"

(
  cd "$STAGE"
  zip -r "$OUT/app-unsigned.apk" .
)

# --- Align ---
zipalign -f 4 \
  "$OUT/app-unsigned.apk" \
  "$OUT/app-aligned.apk"

# --- Sign (debug key) ---
apksigner sign \
  --ks "$HOME/.android/debug.keystore" \
  --ks-key-alias androiddebugkey \
  --ks-pass pass:android \
  "$OUT/app-aligned.apk"

echo "[✓] APK ready: $OUT/app-aligned.apk"
