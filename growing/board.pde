final int SIZE = 32;

final int marge = 2;

class Board {
  int left_corner;
  int up_corner;

  HashMap<Integer, Things> board;
  Carte carte;

  Root r;
  Cursor c;

  Board(String name) {
    left_corner = 0;
    up_corner = 0;
    board = new HashMap<Integer, Things>();
    carte = new Carte(name);
  }

  void init_objects() {
    for(int i = 0; i < carte.objects.size(); i++){
      JSONObject obj = carte.objects.getJSONObject(i);

      if(obj.getInt("gid") == seedTiles+1) {
        int x = obj.getInt("x")/SIZE;
        int y = obj.getInt("y")/SIZE;
        r = new Root(x,y);
        c = new Cursor(r,r.seed());
        left_corner = x - board_width/2;
        up_corner = max(y - board_width/2,0);
      }
    }
  }

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
    if(up_corner < 0) {
      up_corner = 0;
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

  void display() {
    background(0xff,0xff,0xff);

    pushMatrix();
    translate(-left_corner * SIZE, -up_corner * SIZE);
    for (Map.Entry me : board.entrySet()) {
      ((Things)me.getValue()).display();
    }
    popMatrix();

    if(keyPressed) {
      c.keyPressed();
    }
  }

  void put(int x, int y, Things t) {
    board.put(coordinate_hash(x,y),t);
  }

  Things get(int x, int y) {
    Things t = board.get(coordinate_hash(x,y));
    if(t == null) {
      int type = carte.get(x,y);
      switch(type) {
      case(waterTiles):
        t = new Water(x,y);
        break;
      case(rockTiles):
        t = new Rock(x,y);
        break;
      default:
        t = new Dirt(x, y);
        break;
      }
    }
    return t;
  }
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
    current.put(x,y,this);

    for(int i=0; i < 4 ; i++){
      next[i] = this;
    }
  }

  boolean accept() {
    return false;               /* Can we connect */
  }


  Things accepting(Things from, int dir) {
    r = from.r;
    connected[dir] = true;
    next[dir] = from;
    return this;
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

    Things atdest = current.get(newx,newy);

    if( !atdest.accept()){
      return this;              /* can go there */
    } else {
      atdest = atdest.accepting(this, oposite_dir(dir));
      connected[dir] = true;
      next[dir] = atdest;
      return atdest;            /* should do something! */
    }
  }

  void select() {
    selected = true;
  }

  void unselect() {
    selected = false;
  }

  void display() {
  }

  void display_connected() {
    if(selected) {
      fill(0xCD,0xDC,0x39);
      rect(xpos * SIZE, ypos * SIZE,SIZE,SIZE,SIZE/5);
    };
    image(tiles[rootTiles],xpos * SIZE, ypos * SIZE);
    for(int i=0; i<4; i++){
      if(connected[i]){
        image(tiles[rootTiles+1+i],xpos * SIZE, ypos * SIZE);
      }
    }

  }
}

class Dirt extends Things {
  int resistance = 4;
  int trying = 0;

  Dirt(int x, int y) {
    super(x, y);
    if(y==0){
      resistance = 1;
    };
  }

  Dirt(int x, int y, int r) {
    super(x, y);
    resistance = r;
  }

  void display() {
    if(trying > 0) {
      stroke(0);
      trying--;
    } else {
      noStroke();
    }
    rect(xpos * SIZE, ypos * SIZE,SIZE,SIZE,SIZE/5);
    if(ypos == 0) {
      image(tiles[groundTiles], xpos * SIZE, ypos * SIZE);
    } else {
      image(tiles[resistance], xpos * SIZE, ypos * SIZE);
    }
    noFill();
  }

  boolean accept() {
    if(trying > 0 && resistance == 0) {
      return true;
    } else if(trying > 0) {
      resistance--;
    }
    trying = 4;

    return false;               /* Can we connect */
  }

  Things accepting(Things from, int dir) {
    if(ypos == 0){
      Trunk tr = new Trunk(xpos, ypos, dir, from);
      from.r.add(tr);
      return tr;
    } else {
      RootPart root = new RootPart(xpos, ypos, dir, from);

      from.r.add(root);
      return root;
    }
  }
}

class Water extends Things {
  Water(int x, int y) {
    super(x, y);
  }

  boolean accept() {
    for(int i=0; i<4; i++){     /* copied from root... berk */
      if(connected[i]){
        return false;
      }
    }
    return true;
  }

  void display() {
    image(tiles[waterTiles],xpos * SIZE, ypos * SIZE);

    super.display_connected();
  }
}

class Rock extends Things {
  Rock(int x, int y) {
    super(x, y);
  }

  boolean accept() {
    return false;
  }

  void display() {
    image(tiles[rockTiles],xpos * SIZE, ypos * SIZE);
  }
}
