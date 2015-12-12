class Cursor {
  Root r;
  RootPart pos;

  Cursor(Root theroot, RootPart seed) {
    r = theroot;
    pos = seed;
  }

  void move(int dir) {
    pos = pos.move(dir);
  }

  void keypressed() {
    if(key == CODED) {
      switch(key) {
      case UP:
        move(DIRUP);
        break;
      case DOWN:
        move(DIRDOWN);
        break;
      case LEFT:
        move(DIRLEFT);
        break;
      case RIGHT:
        move(DIRRIGHT);
        break;
      }
    }
  }
}