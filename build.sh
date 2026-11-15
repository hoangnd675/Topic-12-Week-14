#!/usr/bin/env bash
set -euo pipefail
FLUTTER_VERSION="${FLUTTER_VERSION:-stable}"
git clone --depth 1 --branch "$FLUTTER_VERSION" https://github.com/flutter/flutter.git /tmp/flutter
export PATH="/tmp/flutter/bin:$PATH"
flutter config --enable-web
flutter pub get
flutter build web --release
