class Cursor {
  Root r;
  Things pos;

  Cursor(Root theroot, Things seed) {
    r = theroot;
    pos = seed;
    pos.select();
  }

  void move(int dir) {
    pos.unselect();
    pos = pos.move(dir);
    pos.select();
    current.maybe_scroll(pos.xpos,pos.ypos);
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
    } else {
      switch(key) {
      case 'z':
      case 'w':
      case 'é':
        move(DIRUP);
        break;
      case 's':
      case 'u':
        move(DIRDOWN);
        break;
      case 'q':
      case 'a':
        move(DIRLEFT);
        break;
      case 'd':
      case 'i':
        move(DIRRIGHT);
        break;
      }
    }
  }
}
