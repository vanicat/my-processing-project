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
  } else if(y+marge > up_corner + board_height) {
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

  Things(int x, int y){
    xpos = x;
    ypos = y;
    board.put(coordinate_hash(x,y),this);
  }

  boolean accept() {
    return false;               /* Can we connect */
  }
}

HashMap<Integer, Things> board = new HashMap<Integer, Things>();
