#!/usr/bin/env bash

function generate() {
  for d in */; do
    cd $d
    pubspec="pubspec.yaml"
    if [ -f "$pubspec" ]; then
      if grep -q build_runner "$pubspec"; then
        echo "$(tput setaf 2)build for $d$(tput sgr0)"
        if grep -q flutter: "$pubspec"; then
          flutter packages pub run build_runner build --delete-conflicting-outputs
        else
          dart run build_runner build --delete-conflicting-outputs
        fi
      fi
    elif [ $1 == true ]; then
      generate false
    fi
    cd ..
  done
}

cd ..
generate false
cd feature/
generate true
