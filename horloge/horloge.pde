int font_size = 0;
PFont f;

void setup(){
  fullScreen();
  stroke(255);     // Les lignes seront tracé en blanc.
  frameRate(3);

  f = createFont("Arial", 100);
  textFont(f);
}

void draw(){
  background(0, 0, 0, 0);

  if(font_size == 0) {
    font_size = int(height * 0.25);
    f = createFont("Arial", font_size);
    textFont(f);
  }

  String time = "" + nf(hour(),2) + ':' + nf(minute(),2) + ':' + nf(second(),2);

  textAlign(CENTER);
  text(time, width * 0.5, height * 0.5);
}
