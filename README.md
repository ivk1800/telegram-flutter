
### (WIP) Telegram client written in Dart and uses Flutter.
---

Preferred flutter version: `stable, 3.0.0`

[TdLib](https://github.com/tdlib/td) version: `1.8.4` `d489014`

### Supported platform
|Platform| Status|
|-|-|
|Android|✅|
|iOS|✅|
|MacOS|✅|
|Windows|✅|
|Linux|✅|
|Web|TBD|

### Getting started

1. Build TbLib for your platform, following the instructions: https://github.com/ivk1800/tdlib-dart#build-tdlib
2. Place binaries to `tdlib` to the repo folder:

For Android:
```
└── tdlib 
    └── android 
        └── arm64-v8a
        │   └── libtdjsonandroid.so
        │   └── libtdjsonandroid.so.debug
        └── armeabi-v7a
        │   └── libtdjsonandroid.so
        │   └── libtdjsonandroid.so.debug
        └── x86
        │   └── libtdjsonandroid.so
        │   └── libtdjsonandroid.so.debug
        └── x86_64
            └── libtdjsonandroid.so
            └── libtdjsonandroid.so.debug
```
For iOS:
```
└── tdlib 
    └── ios 
        └── libtdjson.dylib
```
For MacOS:
```
└── tdlib 
    └── macos 
        └── libtdjson.dylib
```
For Windows:
```
└── tdlib 
    └── windows 
        └── libcrypto-1_1.dll
        └── libssl-1_1.dll
        └── tdjson.dll
        └── zlib1.dll
```

2. Obtain api_id and api_hash at https://my.telegram.org
3. Create file `config.txt` with content in assets:
```
└── app 
    └── assets 
        └── tdlib
            └── config.txt
```
Content:
```
apiId:<api_id>
apiHash:<api_hash>
useTestDc:<true/false>
```
4. `cd <repo folder>`
5. `cd tools/tools-project/ && dart pub get && cd ../..`
6. `./tools/packages_get.sh`
7. `./tools/gen.sh`
8. `cd launch/ && flutter run `