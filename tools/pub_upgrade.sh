#!/usr/bin/env bash
set -e

parent_path=$(
  cd "$(dirname "${BASH_SOURCE[0]}")"
  pwd -P
)
echo "pub upgrade...";
dart run "$parent_path/tools-project/lib/main.dart" upgrade --work-directory "$parent_path/../"