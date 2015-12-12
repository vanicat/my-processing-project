int SIZE = 10;


final int DIRUP    = 0;
final int DIRLEFT  = 1;
final int DIRDOWN  = 2;
final int DIRRIGHT = 3;

int oposite_dir(int dir) throws Exception {
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
  throw new Exception("no such direction");
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

  RootPart add(int dir) throws Exception {
    RootPart root;
    if(connected[dir]){
      throw new Exception("already added");
    }
    connected[dir]=true;
    /* root = new RootPart(); */
    root = new RootPart(xpos,ypos); /* à finir ! */
    return root;
  }

  void display() {
    ellipse(xpos * SIZE + SIZE/2, ypos * SIZE + SIZE/2, SIZE/2, SIZE/2);
  }
}

class Root {
  ArrayList<RootPart> parts = new ArrayList<RootPart>();

  Root (int x, int y) {
    parts.add(new RootPart(x,y));
  }

  void display() {                 /* pensez à la couleur */
    for (RootPart part : parts) {
      part.display();
    }
  }
}