#!/usr/bin/env bash

function findTests() {
  for d in */; do
    cd $d
    pubspec="pubspec.yaml"
    if [ -f "$pubspec" ]; then
      if grep -q test: "$pubspec"; then
        echo "$(tput setaf 2)run for $d$(tput sgr0)"
          flutter test
      fi
    elif [ $1 == true ]; then
      findTests false
    fi
    cd ..
  done
}

cd ..
findTests false
cd feature/
findTests true
cd ../component/
findTests true
cd ../rich_text/
findTests true