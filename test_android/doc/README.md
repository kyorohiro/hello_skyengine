# memo 001

https://github.com/kyorohiro/hello_skyengine/blob/master/test_android/sky.yaml


#### ./example/test/sky.yaml
```
name: test
version: 0.0.2
```

#### ./example/test/BUILD.gn

```
import("//sky/build/sky_app.gni")

sky_app("test") {
  main_dart = "lib/main.dart"
  manifest = "sky.yaml"
  if (is_android) {
    apk_name = "test"
  }
}
```