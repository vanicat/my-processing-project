PFont f;
Root r;
Cursor c;

PImage[] rootPixel = new PImage[16];

void setup() {
  size(1324,700);

  r = new Root(width/SIZE/2,height/SIZE/2);
  c = new Cursor(r,r.seed());

  /* // affiche toute les polices disponibles dans la console */
  /* printArray(PFont.list()); */

  // chargement de la police Arial
  f = createFont("Arial", width/8);
  textFont(f);
  textAlign(CENTER);

  // changement du framerate
  frameRate(10);

  // loading image
  PImage tiles = loadImage("drawing.png");
  for(int i = 0; i < 16; i++){
    rootPixel[i] = tiles.get(i*SIZE,0,SIZE,SIZE);
  }
}

void draw() {
  background(0x79,0x55,0x48);
  r.display();
  if(keyPressed) {
    c.keyPressed();
  }
}
