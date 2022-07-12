#!/usr/bin/env bash
set -e

parent_path=$(
  cd "$(dirname "${BASH_SOURCE[0]}")"
  pwd -P
)
echo "run_tests..."
dart run "$parent_path/tools-project/lib/main.dart" test --work-directory "$parent_path/../" --withOutputs true