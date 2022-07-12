#!/usr/bin/env bash
set -e

parent_path=$(
  cd "$(dirname "${BASH_SOURCE[0]}")"
  pwd -P
)
echo "gen_sp..."
dart run "$parent_path/tools-project/lib/main.dart" generate_stings_provider --work-directory "$parent_path/../"