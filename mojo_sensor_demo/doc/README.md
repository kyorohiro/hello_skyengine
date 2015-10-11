# Post Request, Get Request

https://github.com/kyorohiro/hello_skyengine/tree/master/mojo_urlRequest


```
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
    shell.requestService("m", networkService);
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
    new sky.ImageDecoder.consume(response.body.handle.h, completer.complete);
    return completer.future;
  }

  static Future<Stream<ByteData>> loadAsStream(String url, {method: "GET", redirect: true}) async {
    UrlResponse response = await load(url, method: method, redirect: redirect);

    // Normally we use the DataPipeDrainer#drain()
    core.MojoDataPipeConsumer consumer = response.body;
    return MojoDataPipeConsumer2ByteDataStream.loadAsStream(consumer);

  }

  static Future<ByteData> loadAsByteData(String url, {method: "GET", redirect: true}) async {
    Stream<ByteData> stream =
        await loadAsStream(url, method: method, redirect: redirect);
    StreamIterator<ByteData> itr = new StreamIterator(stream);
    List<ByteData> buffers = [];

    int dataLength = 0;
    while (await itr.moveNext()) {
      buffers.add(itr.current);
      dataLength += itr.current.lengthInBytes;
    }
    ByteData data = new ByteData(dataLength);
    int index = 0;
    for (ByteData d in buffers) {
      data.buffer.asUint8List().setAll(index, d.buffer.asUint8List());
      index += d.lengthInBytes;
    }
    return data;
  }
}

class MojoDataPipeConsumer2ByteDataStream {
  static ByteData _cloneByteData(ByteData byteData) {
    Uint8List d = byteData.buffer.asUint8List();
    ByteBuffer b = new Uint8List.fromList(d).buffer;
    return new ByteData.view(b);
  }

  // Normally we use the DataPipeDrainer#drain()
  static Stream<ByteData> loadAsStream(core.MojoDataPipeConsumer consumer) {
    StreamController<ByteData> returnStream = new StreamController<ByteData>();
    core.MojoEventStream eventStream = new core.MojoEventStream(consumer.handle);
    eventStream.listen((List<int> v) {
      core.MojoHandleSignals signals = new core.MojoHandleSignals(v[1]);
      if (!signals.isReadable && signals.isPeerClosed) {
        eventStream.close();
        returnStream.close();
        return;
      }
      if (!signals.isReadable) {
        returnStream.addError("");
        returnStream.close();
        return;
      }

      ByteData d = consumer.beginRead();
      if (d == null) {
        returnStream.addError("");
        returnStream.close();
        eventStream.close();
        return;
      }
      returnStream.add(_cloneByteData(d));
      if (!consumer.endRead(d.lengthInBytes).isOk) {
        eventStream.close();
        returnStream.close();
        return;
      }
      eventStream.enableReadEvents();
    });
    return returnStream.stream;
  }
}

main() async {
  print("######====================######");
  ByteData data = await MyGet.loadAsByteData("https://raw.githubusercontent.com/kyorohiro/hello_skyengine/master/SUMMARY.md");
  String s1 = UTF8.decode(data.buffer.asUint8List(), allowMalformed: true);
  print("### ${data.buffer.lengthInBytes} ${s1}");
}
```