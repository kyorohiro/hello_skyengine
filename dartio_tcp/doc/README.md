# Dart:io TCP Socket

https://github.com/kyorohiro/hello_skyengine/tree/master/hello

![](screen.png)

```
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

main() async {
  Text t = new Text("${await getTest('http://example.com')}");
  Center c = new Center(child: t);
  runApp(c);

  try {
    //
    // 2015/10/16
    //
    // ANDROID: I/sky     : Invalid argument(s): Secure Sockets unsupported on this platform
    print("${await getTest('https://raw.githubusercontent.com/kyorohiro/hello_skyengine/master/SUMMARY.md')}");
  } catch(e) {
    print("${e}");
  }
}

Future<String> getTest(String uri) async {
  HttpClient client = new HttpClient();
  HttpClientRequest request = await client.getUrl(Uri.parse(uri));
  HttpClientResponse response = await request.close();
  StringBuffer builder = new StringBuffer();
  await for (String a in await response.transform(UTF8.decoder)) {
    builder.write(a);
  }
  return builder.toString();
}

Future<String> postTest(String uri, String message) async {
  HttpClient client = new HttpClient();
  HttpClientRequest request = await client.postUrl(Uri.parse(uri));
  request.write(message);
  HttpClientResponse response = await request.close();
  StringBuffer builder = new StringBuffer();
  await for (String a in await response.transform(UTF8.decoder)) {
    builder.write(a);
  }
  return builder.toString();
}```
