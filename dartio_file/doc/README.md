# Dart:io File

https://github.com/kyorohiro/hello_skyengine/tree/master/dartio_file

![](screen.png)

```
//
// following code is checked in 2015/11/27
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

main() async {
  StringBuffer buffer = new StringBuffer();

  PathServiceProxy pathServiceProxy = new PathServiceProxy.unbound();
  shell.connectToService("dummy", pathServiceProxy);
  PathServiceGetFilesDirResponseParams dirResponse = await pathServiceProxy.ptr.getFilesDir();
  Directory dir = new Directory(dirResponse.path);


  //
  // create File
  print("###${dir.path}/dummy.txt");
  File f = new File("${dir.path}/dummy.txt");
  try {
    await f.create(recursive: true);
    RandomAccessFile rfile = await f.open();
    await rfile.writeString("hello!!");
    rfile.close();
  } catch(e) {
    print("${e}");
  }

  // permission
  // https://github.com/dart-lang/sdk/issues/15078
  // https://github.com/dart-lang/sdk/issues/22036
  // (await f.stat()).mode = 777;
  Permission.chmod(777, f);

  // list
  await for(FileSystemEntity fse in dir.list()) {
    print("${fse} ${(await fse.stat()).modeString()} ${(await fse.stat()).modified}");
    buffer.write("${fse} ${(await fse.stat()).modeString()} ${(await fse.stat()).modified}\n");
  }

  Text t = new Text("${buffer.toString()}");
  Center c = new Center(child: t);
  runApp(c);
  pathServiceProxy.close();
}

class Permission {
  // http://stackoverflow.com/questions/27494933/create-write-a-file-which-is-having-execute-permission
  static chmod(int mode, File f) {
    ProcessResult result =
    Process.runSync(
      "chmod",["${mode}", "${f.absolute.path}"]);
    return result.exitCode;
  }
}
```
