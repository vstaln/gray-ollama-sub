#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/ollama-sub.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/ollama-sub" ;;
    *) rel="x86_64-apple-darwin/ollama-sub" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/ollama-sub" ;;
    *) rel="x86_64-unknown-linux-musl/ollama-sub" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/ollama-sub.exe" "$here/target/release/ollama-sub" "$here/target/debug/ollama-sub.exe" "$here/target/debug/ollama-sub"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "ollama-sub binary not found in $here" >&2
exit 1
