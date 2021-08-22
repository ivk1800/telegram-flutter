#!/bin/bash

if [ $1 == 'build' ]; then
  flutter packages pub run build_runner build
elif [ $1 == 'packages_get' ]; then
  flutter packages get
else
  echo You may not go to the party.
fi
