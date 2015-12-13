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

class Trunk extends Things{
  Trunk (int x, int y, int dir, Things from){
    super(x,y);
    r = from.r;
    connected[dir] = true;
    next[dir] = from;
  }

  Things move(int dir) {
    if(dir == DIRDOWN) {
      return super.move(dir);
    } else {
      return this;
    }
  }

  void display() {
    super.display();            /* for selction */

    image(tiles[trunkTiles],xpos * SIZE, ypos * SIZE); /* a magic number ! */
  }

  void debug(){
    print("x: ");
    print(xpos);
    print(" y: ");
    print(ypos);
    println("");
  }
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

    image(tiles[easyDirtTiles],xpos * SIZE, ypos * SIZE);
    super.display_connected();
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
  ArrayList<Things> parts = new ArrayList<Things>();

  Root (int x, int y) {
    parts.add(new RootPart(x,y,this));
  }

  void display() {                 /* pensez à la couleur */
    for (Things part : parts) {
      /* part.debug(); */
      part.display();
    }
  }

  void add(Things part){
    parts.add(part);
  }

  Things seed() {
    return parts.get(0);
  }
}
