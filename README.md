
### (WIP) Telegram client written in Dart and uses Flutter.
---

Work in progress! Some code needs refactoring as it was written in haste. Somewhere left TODO and somewhere as it is. Some screens have partial functionality, because in order not to block the work, what is there is enough. For example, the authorization screen does not support password authorization. The architecture in the application is multi-modular, there are a lot of modules, this architecture has features and disadvantages. We won’t know about the disadvantages until we try it in practice!

<img src='res/telegram_picture.png' width='800'>

Preferred flutter version: `stable, 3.7.6`

[TDLib](https://github.com/tdlib/td) version: `1.8.4` `d489014`

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

1. Download prebuild TbLib for your platform from [page](https://github.com/ivk1800/td-json-client-prebuilt/releases)
2. Place binaries to `tdlib` to the repo folder:

For Android:
```
└── tdlib 
    └── android 
        └── arm64-v8a
        │   └── libtdjsonandroid.so
        └── armeabi-v7a
        │   └── libtdjsonandroid.so
        └── x86
        │   └── libtdjsonandroid.so
        └── x86_64
            └── libtdjsonandroid.so
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
