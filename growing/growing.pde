import java.util.Map;
import ddf.minim.*;

PFont f;
Board current;

int board_width;
int board_height;

void load_map(String name) {
  current = new Board(name);
  current.init_objects();

}

void setup() {
  size(1324,700);

  board_width = width/SIZE;
  board_height = height/SIZE;

  load_map("menu");

  minim = new Minim(this);
  player = minim.loadFile("data/remi_vanicat - Sound of nature.mp3", 2048);
  player.loop();

  /* // affiche toute les polices disponibles dans la console */
  /* printArray(PFont.list()); */

  // chargement de la police Arial
  // f = createFont("Arial", width/8);
  // textFont(f);
  // textAlign(CENTER);

  // changement du framerate
  frameRate(20);

  // loading image
  PImage tilesFile = loadImage("map-tile.png");
  for(int i = 0; i < 10; i++){
    for(int j = 0; j < 4; j++){ /* do not forget to make it grow as needed */
      tiles[i+10*j] = tilesFile.get(i*SIZE,j*SIZE,SIZE,SIZE);
    }
  }
}

void draw() {
  current.display();
}
