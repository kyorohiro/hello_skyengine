import 'dart:async';
import 'package:flutter/src/services/fetch.dart';
import 'package:mojo/core.dart';
import 'package:sky_services/media/media.mojom.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

main() async {
  runApp(new Center(child: new Text("Sound Test")));
  MojoDataPipeConsumer data =
      await ResouceLoader.load("bgm_maoudamashii_acoustic09.mp3");
  SoundTest test = new SoundTest(data);
  await test.init();
  await test.play();
  await new Future.delayed(new Duration(seconds:5));
  await test.pause();
  await new Future.delayed(new Duration(seconds:5));
  await test.play();
}

class ResouceLoader {
  static Future<MojoDataPipeConsumer> load(String url) async {
    UrlResponse response = await fetchUrl(url);
    return response.body;
  }
}

class SoundTest {
  MojoDataPipeConsumer data;
  SoundTest(this.data) {}

  MediaServiceProxy service = new MediaServiceProxy.unbound();
  MediaPlayerProxy player = new MediaPlayerProxy.unbound();

  init() async {
    shell.requestService(null, service);
    service.ptr.createPlayer(player);
    await player.ptr.prepare(data);
  }

  play() async {
    print("start play");
    player.ptr.seekTo(0);
    player.ptr.start();
    print("/start play");
  }

  pause() async {
    player.ptr.pause();
  }
}
