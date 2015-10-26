## memo 003 set app icon 

#### ./example/test/BUILD.gn
```
import("//sky/build/sky_app.gni")

sky_app("test") {
  main_dart = "lib/main.dart"
  manifest = "sky.yaml"
  if (is_android) {
    apk_name = "test"
    deps = [
      "//examples/test/apk:resources",
    ]
  }
}
```

* set icon resource  "//examples/test/apk:resources"
* 
