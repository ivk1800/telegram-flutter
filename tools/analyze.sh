#!/usr/bin/env bash
set -e

function analyze() {
  for d in */; do
    cd $d
    pubspec="pubspec.yaml"
    if [ -f "$pubspec" ]; then
      echo "$(tput setaf 2)analyze: $d$(tput sgr0)"
      flutter analyze
    elif [ $1 == true ]; then
      analyze false
    fi
    cd ..
  done
}

parent_path=$(
  cd "$(dirname "${BASH_SOURCE[0]}")"
  pwd -P
)
cd "$parent_path/.."
analyze false
cd feature/
analyze true
