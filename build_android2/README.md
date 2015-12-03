# build standalone android app
2015/11/29

input command ,then create apk in build folder.
> flutter apk 

<br>
<br>

## ex: release Google play result
![](mino_sample.png)

https://play.google.com/store/apps/details?id=info.kyorohiro.umiuni2d.demo.mino&hl=ja

<br>
<br>

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

<br>
<br>

## Detail: Prepare to create APK
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

<br>
<br>
# Ex: For Release

### 1. sign cert

http://developer.android.com/intl/ja/tools/publishing/app-signing.html

##### 1-1 create keystore
```
keytool -genkey -v -keystore my-release-key.keystore -alias umiuni2d -keyalg RSA -keysize 2048 -validity 10000
```

##### 1-2 sign
```
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.keystore my_application.apk umiuni2d
```
<br>
<br>
## Detail: remove debug certification
```
cd build
mkdir w
cp app.apk ./w
cd w
unzip app.apk 
rm app.apk 
rm -rf META-INF/
zip ../app_unsigned.apk -r .

```
<br>
<br>

# Ex: If Add Icon
#### (1)
```
> flutter apk
> cd build
> java -jar apktool_2.0.2.jar d app.apk
> cd app
> emacs AndroidManifest.xml
```

#### (2) add "android:icon="@mipmap/ic_launcher"" in AndroidManirest.xml
```
<?xml version="1.0" encoding="utf-8"?>
<manifest android:versionCode="1" android:versionName="0.0.1" package="info.kyorohiro.umiuni2d.demo.mino" platformBuildVersionCode="22" platformBuildVersionName="5.1.1-1819727"
  xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <application android:icon="@mipmap/ic_launcher"  android:label="Wonder Minon" android:name="org.domokit.sky.shell.SkyApplication">
        <activity android:theme="@android:style/Theme.Black.NoTitleBar" android:name="org.domokit.sky.shell.SkyActivity" android:launchMode="singleTask" android:configChanges="keyboard|keyboardHidden|orientation|screenSize" android:hardwareAccelerated="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
```

#### (3) add resource file
```
./AndroidManifest.xml
...
...
..
./res/mipmap-hdpi
./res/mipmap-hdpi/ic_launcher.png
./res/mipmap-mdpi/.DS_Store
./res/mipmap-mdpi/ic_launcher.png
./res/mipmap-xhdpi/ic_launcher.png
./res/mipmap-xxhdpi/ic_launcher.png
./res/mipmap-xxxhdpi/ic_launcher.png
..
```


#### (4) build
```
cd ../
java -jar apktool_2.0.2.jar b app
```

#### (5) cert
```
> cd app
> cd dist
> jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.keystore app.apk umiuni2d
> zipalign -v 4 app.apk app_zip.apk
```



