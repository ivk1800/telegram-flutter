
### (WIP) Telegram client written in Dart and uses Flutter.
---

preferred flutter version: `stable, 2.8.0, revision cf44000065`

td lib version: `1.8.0` c0385078

#### Supported platform
|Platform| Status|
|-|-|
|android|✅|
|iOS|✅|
|macOS|✅|
|Windows|✅|
|Linux|Need add native app and build td lib|

#### Showcase mode
`https://stackoverflow.com/a/64686348/4110159`

`--dart-define="mode=showcase"`

### build tdlib

1. `git clone git@github.com:tdlib/td.git`
2. cd td
3. git checkout ``

#### android
Instruction: https://github.com/tdlib/td/issues/77#issuecomment-640719893
1. Download libtdjsonandroid.zip https://github.com/tdlib/td/issues/77#issuecomment-640719893
2. Unpack the archive to td/example directory.
3. Then download the latest OpenSSL 1.1.1 source code as a .tar.gz archive from OpenSSL 1.1.1 release page and place it in the third_party/crypto subfolder.
4. Edit `example/third_party/crypto/build.sh`. Set your ANDROID_NDK path, `export ANDROID_NDK=/Users/arseny30/Library/Android/sdk/ndk-bundle` replace by own path to ndk.
5. chmod +x `build.sh` and `build-all.sh` in `example/third_party/crypto/` folder.
6. chmod +x `export.sh` in `example`
7. Setup ANDROID_NDK path in `example/build.sh`. Replace `...=${ANDROID_SDK_ROOT}/ndk-bundle/...` by own path to ndk.
8. chmod +x `build.sh` and `build-all.sh` in `example/` folder.
9. Fix cmake path in `CMakeLists.txt`, replace `set(TD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../..)` by `set(TD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/..)`.
10. Run `example/third_party/crypto/build-all.sh`
11. Run `example/export.sh`
12. copy folder `example/libs` to `<repo path>/tdlib` and rename `libs` to `android`

#### iOS, macOS
Instruction: https://github.com/tdlib/td/tree/master/example/ios

1. Remove watchOs and tvOS in `example/ios/build-openssl.sh` and `example/ios/build.sh`: replace `platforms="macOS iOS watchOS tvOS"` by `platforms="macOS iOS"`.
2. Build following the guide.
3. Copy `example/ios/tdjson/iOS/lib/libtdjson.dylib` to `<repo path>/tdlib/ios` and `example/ios/tdjson/macOS/lib/libtdjson.dylib` to `<repo path>/tdlib/macos`

#### windows
Instruction: https://tdlib.github.io/td/build.html

1. Choose language `C++`
2. Choose operating system `Windows`
3. Build following the guide.
4. Copy files from `/tdlib/bin` to `<repo path>/tdlib/windows`
5. Rename `libcrypto-1_1-(x64|x32).dll` to `libcrypto-1_1.dll` and `libssl-1_1-(x64|x32).dll` to `libssl-1_1.dll`
