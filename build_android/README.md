2015/10/26

for creating standalone apk tool is in progress now. 
so, I try to create standalone flutter apk from flutter build environment.


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

project folder name is "test"
```
./examples/test/lib
./examples/test/apk
./examples/test/...
..
..
```

## (4) build on flutter/src
```
ninja -C out/android_Debug
```

## (5) install apk
```
adb install -r ./out/android_Debug/apks/test.apk 

```
