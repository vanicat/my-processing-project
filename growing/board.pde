final int marge = 2;

int left_corner;
int up_corner;
int board_width;
int board_height;

void maybe_scroll(int x, int y){
  if(x - marge < left_corner) {
    left_corner--;
  } else if(x+marge > left_corner + board_width) {
    left_corner++;
  }
  if(y - marge < up_corner) {
    up_corner--;
  } else if(y + marge > up_corner + board_height) {
    up_corner++;
  }
}

int coordinate_hash(int x, int y) { /* from number therorie: no two number map to the same number */
  int a, b, n;
  if(x<0){
    a = -2*x;
  } else {
    a = 2 * x + 1;
  }
  if(y<0){
    b = -2*y;
  } else {
    b = 2 * y + 1;
  }
  n = a + b;
  return n*(n+1)/2+a;
}


class Things {
  int xpos, ypos;

  boolean selected = false;

  Root r;
  boolean[] connected={ false, false, false, false};
  Things[] next = new Things[4];

  Things(int x, int y){
    xpos = x;
    ypos = y;
    board.put(coordinate_hash(x,y),this);

    for(int i=0; i < 4 ; i++){
      next[i] = this;
    }
  }

  boolean accept() {
    return false;               /* Can we connect */
  }


  Things move(int dir) {
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

    Things atdest = board.get(coordinate_hash(newx,newy));

    if(atdest != null){
      if( !atdest.accept()){
        return this;              /* can go there */
      } else {
        return this;            /* should do something! */
      }
    } else {                    /* nothing there: creating new root */
      RootPart root = new RootPart(newx,newy,oposite_dir(dir),this);
      next[dir] = root;
      connected[dir]=true;

      r.add(root);
      return root;
    }
  }

  void select() {
    selected = true;
  }

  void unselect() {
    selected = false;
  }

}

HashMap<Integer, Things> board = new HashMap<Integer, Things>();
