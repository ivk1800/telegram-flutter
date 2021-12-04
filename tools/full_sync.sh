#!/usr/bin/env bash
set -e
git clean -fX
bash packages_get.sh
bash gen.sh