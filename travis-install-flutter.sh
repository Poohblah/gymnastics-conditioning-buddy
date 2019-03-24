#!/bin/bash

set -e
set -x

install_dir="$1"
flutter="${install_dir}/bin/flutter"

yes | sdkmanager "tools" "platform-tools" "platforms;android-28" "build-tools;28.0.3"

if [[ ! -f "$flutter" ]]; then
  git clone https://github.com/flutter/flutter.git -b beta "$install_dir"
fi

"$flutter" doctor -v
