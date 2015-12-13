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
    int x = pos.xpos; int y = pos.ypos;
    current.maybe_scroll(x,y);
    current.get(x+1,y);
    current.get(x-1,y);
    current.get(x,y+1);
    current.get(x,y-1);
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
