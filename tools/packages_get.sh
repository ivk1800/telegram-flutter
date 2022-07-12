#!/usr/bin/env bash
set -e

parent_path=$(
  cd "$(dirname "${BASH_SOURCE[0]}")"
  pwd -P
)
echo "packages_get...";
dart run "$parent_path/tools-project/lib/main.dart" get --work-directory "$parent_path/../"