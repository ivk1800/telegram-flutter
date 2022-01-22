@ECHO off
SET parent_path=%~dp0

dart run "%parent_path%/tools-project/lib/main.dart" validate_dependencies --work-directory "%parent_path%/../" --withOutputs true