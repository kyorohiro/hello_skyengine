part of gplay;

class PlayBullets extends TinyDisplayObject {
  Game game;

  PlayBullets(this.game) {
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyPaint p = new TinyPaint();
    p.color = new TinyColor.argb(0xff, 0xff, 0xff, 0x00);
    TinyRect dst = new TinyRect(-50.0, -50.0, 100.0, 100.0);

    for(GameBullet b in this.game.environ.bullets) {
      dst.x = b.xy.x - b.angle;
      dst.y = b.xy.y - b.angle;
      dst.w = b.radius*2;
      dst.h = b.radius*2;
      canvas.drawOval(stage, dst, p);
    }
  }

}
