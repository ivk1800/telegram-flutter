#!/usr/bin/env bash

function sync() {
  for d in */; do
    cd $d
    pubspec="pubspec.yaml"
    if [ -f "$pubspec" ]; then
      if grep -q flutter: "$pubspec"; then
        flutter packages get
      else
        dart pub get
      fi
    elif [ $1 == true ]; then
      sync false
    fi
    cd ..
  done
}

cd ..
sync false
cd feature/
sync true
