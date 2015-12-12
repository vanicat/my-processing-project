int SIZE = 16;


final int DIRUP    = 0;
final int DIRRIGHT = 1;
final int DIRDOWN  = 2;
final int DIRLEFT  = 3;

int oposite_dir(int dir) {
  switch(dir){
  case DIRUP:
    return DIRDOWN;
  case DIRLEFT:
    return DIRRIGHT;
  case DIRDOWN:
    return DIRUP;
  case DIRRIGHT:
    return DIRLEFT;
  }
  exit();
  return 0;
}

class RootPart extends Things{

  RootPart (int x, int y, Root a){
    super(x,y);
    r = a;
  }

  RootPart (int x, int y, int dir, Things from){
    super(x,y);
    r = from.r;
    connected[dir] = true;
    next[dir] = from;
  }


  void display() {
    int image = 0;
    if(selected) {              /* how to display selected? */
      rect(xpos * SIZE, ypos * SIZE,SIZE,SIZE,SIZE/5);
    } else {
      fill(0xCD,0xDC,0x39);
    };
    for(int i=0; i<4; i++){
      if(connected[i]){
        image += 1<<i;
      }
    }
    image(rootPixel[image],xpos * SIZE, ypos * SIZE);
  }

  void debug(){
    print("x: ");
    print(xpos);
    print(" y: ");
    print(ypos);
    println("");
  }
}

class Root {
  ArrayList<RootPart> parts = new ArrayList<RootPart>();

  Root (int x, int y) {
    parts.add(new RootPart(x,y,this));
  }

  void display() {                 /* pensez à la couleur */
    for (RootPart part : parts) {
      /* part.debug(); */
      part.display();
    }
  }

  void add(RootPart part){
    parts.add(part);
  }

  RootPart seed() {
    return parts.get(0);
  }
}
