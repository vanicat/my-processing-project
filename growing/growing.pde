PFont f;
Root r;

void setup() {
  size(1024,700);

  r = new Root(1024/SIZE/2,700/SIZE/2);


  /* // affiche toute les polices disponibles dans la console */
  /* printArray(PFont.list()); */

  // chargement de la police Arial
  f = createFont("Arial", width/8);
  textFont(f);
  textAlign(CENTER);
}

void draw() {
  background(100,0,0);
  r.display();
}
