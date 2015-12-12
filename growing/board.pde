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


  void accepting(Things from, int dir) {
    r = from.r;
    connected[dir] = true;
    next[dir] = from;
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
        atdest.accepting(this, oposite_dir(dir));
        connected[dir] = true;
        next[dir] = atdest;
        return atdest;            /* should do something! */
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

  void display() {
    if(selected) {
      rect(xpos * SIZE, ypos * SIZE,SIZE,SIZE,SIZE/5);
    } else {
      fill(0xCD,0xDC,0x39);
    };
  }
}

class Dirt extends Things {
  int resistance = 4;
  boolean trying = false;

  Dirt(int x, int y) {
    super(x, y);
  }

  Dirt(int x, int y, int r) {
    super(x, y);
    resistance = r;
  }

  void display() {
    fill(resistance*10,resistance*10,resistance*10);
    if(trying) {
      stroke(0);
    } else {
      noStroke();
    }
    rect(xpos * SIZE, ypos * SIZE,SIZE,SIZE,SIZE/5);
    noFill();
  }
}

HashMap<Integer, Things> board = new HashMap<Integer, Things>();
