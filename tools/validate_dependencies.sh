#!/usr/bin/env bash
set -e

parent_path=$(
  cd "$(dirname "${BASH_SOURCE[0]}")"
  pwd -P
)
echo "validate_dependencies..."
dart run "$parent_path/tools-project/lib/main.dart" validate_dependencies --work-directory "$parent_path/../" --withOutputs true