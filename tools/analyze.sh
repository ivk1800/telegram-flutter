#!/usr/bin/env bash
set -e

parent_path=$(
  cd "$(dirname "${BASH_SOURCE[0]}")"
  pwd -P
)
echo "analyze..."
dart run "$parent_path/tools-project/lib/main.dart" analyze --work-directory "$parent_path/../"