#!/usr/bin/env bash

function generate() {
  for d in */; do
    cd $d
    pubspec="pubspec.yaml"
    if [ -f "$pubspec" ]; then
      if grep -q build_runner "$pubspec"; then
        echo "$(tput setaf 2)build for $d$(tput sgr0)"
        flutter packages pub run build_runner build
      fi
    fi
    cd ..
  done
}

cd ..
generate

cd feature/
generate
