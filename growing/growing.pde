import java.util.Map;

PFont f;
Root r;
Cursor c;

PImage[] rootPixel = new PImage[16];
PImage[] tiles = new PImage[10*10];

void setup() {
  size(1324,700);

  r = new Root(width/SIZE/2,height/SIZE/2);
  c = new Cursor(r,r.seed());

  left_corner = 0;
  up_corner = 0;
  board_width = width/SIZE;
  board_height = height/SIZE;

  /* // affiche toute les polices disponibles dans la console */
  /* printArray(PFont.list()); */

  // chargement de la police Arial
  f = createFont("Arial", width/8);
  textFont(f);
  textAlign(CENTER);

  // changement du framerate
  frameRate(10);

  // loading image
  PImage tilesFile = loadImage("drawing.png");
  for(int i = 0; i < 16; i++){
    rootPixel[i] = tilesFile.get(i*SIZE/image_root,0,SIZE/image_root,SIZE/image_root);
  }
  tilesFile = loadImage("map-tile.png");
  for(int i = 0; i < 10; i++){
    for(int j = 0; j < 1; j++){ /* do not forget to make it grow as needed */
      tiles[i+10*j] = tilesFile.get(i*SIZE,j*SIZE,SIZE,SIZE);
    }
  }
}

void draw() {
  background(0xff,0xff,0xff);

  pushMatrix();
  translate(-left_corner * SIZE, -up_corner * SIZE);
  for (Map.Entry me : board.entrySet()) {
    ((Things)me.getValue()).display();
  }
  popMatrix();

  if(keyPressed) {
    c.keyPressed();
  }
}
