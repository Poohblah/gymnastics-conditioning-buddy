#!/bin/bash

set -e
set -x

IMAGE="$1"

yes | sdkmanager --install "${IMAGE}"
echo no | android create avd --force -n test -k "${IMAGE}"
export PATH=$ANDROID_HOME/emulator:$PATH
xvfb-run emulator -avd test -no-accel >/dev/null 2>&1 & # Qt complains and fills the log if output not blackholed
android-wait-for-emulator
adb shell input keyevent 82 &
