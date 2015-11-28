# build standalone android app
2015/11/29

input command
> flutter apk 


## ex: mino
https://github.com/kyorohiro/doc_2dgame/tree/master/demo/mino

```
> brew install android-sdk
> emacs ~/.bash_profile
> export ANDROID_HOME=/usr/local/opt/android-sdk
> source ~/.bash_profile
> git clone https://github.com/kyorohiro/doc_2dgame.git
> cd demo/mino
> pub get
> pub upgrade
> flutter apk
```

## Detail: 
### 1 create apk folder
```
mkdir apk
```

### 2 create AndroidManifest.xml in apk folder
```
<?xml version="1.0" encoding="utf-8"?>
<!-- Copyright 2015 The Chromium Authors. All rights reserved.
     Use of this source code is governed by a BSD-style license that can be
     found in the LICENSE file.
 -->
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="info.kyorohiro.umiuni2d.demo.mino" android:versionCode="1" android:versionName="0.0.1">

    <uses-sdk android:minSdkVersion="14" android:targetSdkVersion="21" />
    <uses-permission android:name="android.permission.INTERNET"/>

    <application android:name="org.domokit.sky.shell.SkyApplication" android:label="Wonder Minon">
        <activity android:name="org.domokit.sky.shell.SkyActivity"
                  android:launchMode="singleTask"
                  android:theme="@android:style/Theme.Black.NoTitleBar"
                  android:configChanges="orientation|keyboardHidden|keyboard|screenSize"
                  android:hardwareAccelerated="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application>
 </manifest>
```
##### 2-1 mod into your package name
```
"info.kyorohiro.umiuni2d.demo.mino"
```
##### 2-2 mod into your app label
```
"Wonder Minon"
```

