#!/usr/bin/env bash
set -e

parent_path=$(
  cd "$(dirname "${BASH_SOURCE[0]}")"
  pwd -P
)
echo "gen..."
dart run "$parent_path/tools-project/lib/main.dart" gen --work-directory "$parent_path/../"