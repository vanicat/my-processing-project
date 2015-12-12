void setup() {
  fullScreen();

  // affiche toute les polices disponibles dans la console
  printArray(PFont.list());

  // chargement de la police Arial
  f = createFont("Arial", width/8);
  textFont(f);
  textAlign(CENTER);
}