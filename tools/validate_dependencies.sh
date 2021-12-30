#!/usr/bin/env bash
set -e

function sync() {
  for d in */; do
    cd $d
    pubspec="pubspec.yaml"
    if [ -f "$pubspec" ]; then
      if grep -q dependency_validator: "$pubspec"; then
        echo "$(tput setaf 2)validate for: $d$(tput sgr0)"
        dart run dependency_validator
      else
        echo "$(tput setaf 1)dependency validator not found: $d$(tput sgr0)"
        exit 0
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
