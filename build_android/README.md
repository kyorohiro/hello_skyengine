now wriring
Standalone apk create tool is in progress now.
and, I try to create standalone flutter apk from flutter build envirnment.


ex : create "test" app

## (1) create flutter build env
  * [build flutter](build_flutter/README.md)

## (2) modify BUILD.gn on examples
flutter/src/examples/BUILD.gn
```
group("examples") {
  testonly = true

  deps = [
    "//examples/fitness",
    "//examples/game",
    "//examples/mine_digger",
    "//examples/stocks",
    "//examples/test",
  ]
}
```
## (3) create app project
https://github.com/kyorohiro/hello_skyengine/blob/master/test_android/BUILD.gn

## (4) build on flutter/src
```
ninja -C out/android_Debug
```

## (5) install apk
```
adb install -r ./out/android_Debug/apks/test.apk 

```
