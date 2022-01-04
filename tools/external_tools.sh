#!/bin/bash

if [ $1 == 'build' ]; then
  pubspec="pubspec.yaml"
  if [ -f "$pubspec" ]; then
    if grep -q build_runner "$pubspec"; then
      if grep -q flutter: "$pubspec"; then
        flutter packages pub run build_runner build --delete-conflicting-outputs
      else
        dart run build_runner build --delete-conflicting-outputs
      fi
    fi
  fi
elif [ $1 == 'packages_get' ]; then
  flutter packages get
else
  echo You may not go to the party.
fi
