class Cursor {
  Root r;
  RootPart pos;

  Cursor(Root theroot, RootPart seed) {
    r = theroot;
    pos = seed;
    pos.select();
  }

  void move(int dir) {
    pos.unselect();
    pos = pos.move(dir);
    pos.select();
  }

  void keyPressed() {
    if(key == CODED) {
      switch(keyCode) {
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