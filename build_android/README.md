now wriring
Standalone apk create tool is in progress now.
and, I try to create standalone flutter apk from flutter build envirnment.


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
