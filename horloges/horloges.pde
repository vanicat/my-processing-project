PFont f;

void setup() {
  fullScreen();

  // affiche toute les polices disponibles dans la console
  printArray(PFont.list());

  // chargement de la police Arial
  f = createFont("Arial", width/8);
  textFont(f);
  textAlign(CENTER);

}

void draw() {
  background(0);
  int s = second();  // Values from 0 - 59
  int m = minute();  // Values from 0 - 59
  int h = hour();    // Values from 0 - 23

  String time = "";

  if(h<10){
    time = time + "0" + h;
  } else {
    time = time + h;
  }
  time += ":";
  if(m<10){
    time = time + "0" + m;
  } else {
    time = time + m;
  }
  time += ":";
  if(s<10){
    time = time + "0" + s;
  } else {
    time = time + s;
  }

  text(time, width * 0.5, height * 0.5);
}


// cette fonction est appelé quand on appuie sur le bouton de la
// souris
void mousePressed() {
  exit();
}
