import ddf.minim.*;

AudioPlayer player;
Minim minim;//audio context

AudioPlayer digging;
AudioPlayer splach;

void sound_init() {
  minim = new Minim(this);
  player = minim.loadFile("data/remi_vanicat - Sound of nature.mp3", 2048);
  player.loop();
  digging = minim.loadFile("data/grat.mp3", 2048);
  splach = minim.loadFile("data/sploou.mp3", 2048);
}

void stop()
{
  println("stop???");
  player.close();
  minim.stop();
  super.stop();
}