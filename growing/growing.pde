PFont f;
Root r;

void setup() {
  size(1424,700);

  r = new Root(width/SIZE/2,height/SIZE/2);
  r.seed().move(DIRUP);

  /* // affiche toute les polices disponibles dans la console */
  /* printArray(PFont.list()); */

  // chargement de la police Arial
  f = createFont("Arial", width/8);
  textFont(f);
  textAlign(CENTER);
}

void draw() {
  background(0x79,0x55,0x48);
  r.display();
}
