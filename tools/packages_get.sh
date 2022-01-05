#!/usr/bin/env bash
set -e

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

parent_path=$(
  cd "$(dirname "${BASH_SOURCE[0]}")"
  pwd -P
)
cd "$parent_path/.."
sync false
cd feature/
sync true
cd ../component/
sync true
