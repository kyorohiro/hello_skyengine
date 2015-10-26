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

#### ./example/test/apk/BUILD.gn

```
assert(is_android)

import("//build/config/android/config.gni")
import("//build/config/android/rules.gni")

android_resources("resources") {
  resource_dirs = [ "res" ]
  android_manifest = "AndroidManifest.xml"
}

```

* set res foder as resource folder


#### ./example/test/apk/AndroidManifest.xml

```
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="info.kyorohiro.flutter.hello" 
    android:versionCode="1"
    android:versionName="0.0.1">

    <uses-sdk android:minSdkVersion="14" android:targetSdkVersion="21" />
    <uses-permission android:name="android.permission.INTERNET"/>

    <application android:icon="@mipmap/ic_launcher" android:name="org.domokit.sky.shell.SkyApplication" android:label="test">
        <activity android:name="org.domokit.sky.shell.SkyActivity"
                  android:launchMode="singleTask"
                  android:theme="@android:style/Theme.Black.NoTitleBar"
                  android:configChanges="orientation|keyboardHidden|keyboard|screenSize"
                  android:hardwareAccelerated="true"
                  android:screenOrientation="portrait">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application>
 </manifest>
```

* set application icon path "android:icon="@mipmap/ic_launcher"