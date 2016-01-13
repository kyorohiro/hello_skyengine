# Post Request, Get Request

https://github.com/kyorohiro/hello_skyengine/tree/master/mojo_urlRequest


```
//
// following code is checked in 2016/01/13
import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:ui' as sky;
import 'package:flutter/services.dart';
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/url_request.mojom.dart';
import 'package:mojo/mojo/url_response.mojom.dart';
import 'package:mojo_services/mojo/network_service.mojom.dart';
import 'package:mojo_services/mojo/url_loader.mojom.dart';
export 'package:mojo/mojo/url_response.mojom.dart' show UrlResponse;

// Normally use 'package:flutter/src/services/fetch.dart'
class MyGet {
  static Future<UrlResponse> load(String url, {method: "GET", redirect: true}) async {
    NetworkServiceProxy networkService = new NetworkServiceProxy.unbound();
    shell.connectToService("m", networkService);
    UrlLoaderProxy loader = new UrlLoaderProxy.unbound();
    networkService.ptr.createUrlLoader(loader);
    UrlRequest request = new UrlRequest();
    request.url = Uri.base.resolve(url).toString();
    request.autoFollowRedirects = redirect;
    request.method = method;
    networkService.close();
    return (await loader.ptr.start(request)).response;
  }

  static Future<sky.Image> loadAsImage(String url, {method: "GET", redirect: true}) async {
    UrlResponse response = await load(url, method: method, redirect: redirect);
    if (response.body == null) {
      return null;
    }

    Completer<sky.Image> completer = new Completer();
    sky.decodeImageFromDataPipe(response.body.handle.h, completer.complete);
    return completer.future;
  }

  static Future<ByteData> loadAsStream(String url, {method: "GET", redirect: true}) async {
    UrlResponse response = await load(url, method: method, redirect: redirect);
    core.MojoDataPipeConsumer consumer = response.body;
    return await core.DataPipeDrainer.drainHandle(consumer);
  }

  static Future<ByteData> loadAsByteData(String url, {method: "GET", redirect: true}) async {
    return await loadAsStream(url, method: method, redirect: redirect);
  }
}

main() async {
  print("######====================######");
  ByteData data = await MyGet.loadAsByteData("https://raw.githubusercontent.com/kyorohiro/hello_skyengine/master/SUMMARY.md");
  String s1 = UTF8.decode(data.buffer.asUint8List(), allowMalformed: true);
  print("### ${data.buffer.lengthInBytes} ${s1}");
}

```
