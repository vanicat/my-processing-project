int SIZE = 30;


final int DIRUP    = 0;
final int DIRLEFT  = 1;
final int DIRDOWN  = 2;
final int DIRRIGHT = 3;

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

class RootPart {
  int xpos, ypos;
  boolean[] connected={ false, false, false, false};
  RootPart[] next = new RootPart[4];

  RootPart (int x, int y){
    xpos = x;
    ypos = y;
    for(int i=0; i < 4 ; i++){

      next[i] = this;
    }
  }

  RootPart (int x, int y, int dir, RootPart from){
    xpos = x;
    ypos = y;
    connected[dir] = true;
    next[dir] = from;
    for(int i=0; i < 4 ; i++){
      next[i] = this;
    }
  }

  RootPart move(int dir) {
    RootPart root;
    if(connected[dir]){
      return next[dir];
    }
    int newx=xpos;
    int newy=ypos;
    switch(dir){
    case DIRUP:
      newy--;
      break;
    case DIRLEFT:
      newx--;
      break;
    case DIRDOWN:
      newy++;
      break;
    case DIRRIGHT:
      newx++;
      break;
    default:
      exit();
    }

    root = new RootPart(newx,newy,oposite_dir(dir),this);
    next[dir] = root;
    connected[dir]=true;
    return root;
  }

  void display() {
    ellipse(xpos * SIZE + SIZE/2, ypos * SIZE + SIZE/2, SIZE/2, SIZE/2);
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
    parts.add(new RootPart(x,y));
  }

  void display() {                 /* pensez à la couleur */
    fill(0xCD,0xDC,0x39);
    for (RootPart part : parts) {
      /* part.debug(); */
      part.display();
    }
  }
}
