#!/usr/bin/env bash

function sync() {
  for d in */; do
    cd $d
    pubspec="pubspec.yaml"
    if [ -f "$pubspec" ]; then
      flutter packages get
    fi
    cd ..
  done
}

cd ..
sync
cd feature/
sync
