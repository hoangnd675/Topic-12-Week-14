#!/usr/bin/env bash
set -euo pipefail

FLUTTER_VERSION="${FLUTTER_VERSION:-stable}"
FLUTTER_DIR="/tmp/flutter"

if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  git clone --depth 1 --branch "$FLUTTER_VERSION" https://github.com/flutter/flutter.git "$FLUTTER_DIR"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"
flutter config --enable-web
flutter pub get
flutter test
flutter build web --release
