class Player {
  Root r;
  Things pos;

  float water;
  float trunk;
  float root;
  float energy;

  Player(Root theroot, Things seed, int e) {
    r = theroot;
    pos = seed;
    pos.select();
    energy = e;
    water = 0;
    trunk = 0;
    root = 1;
  }

  void spendEnergy() {
    energy--;
  }

  void addWater() {
    water++;
  }

  void addTrunk() {
    trunk++;
  }

  void addRoot() {
    root++;
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

  void drawBar(int max, float value) {
    rect(width-96,max-value,96,value);
  }

  void display() {
    float deltaEnergy = min(water/10,trunk) - root/50;

    fill(0x20,0x24,0x25);
    noStroke();
    rect(width-96,0,96,height);

    if(deltaEnergy < 0) {
      float e = energy;
      fill(0xff,0x08,0x25);
      drawBar(height,energy);

      energy+=deltaEnergy;

      fill(0x08,0xf0,0x25);
      drawBar(height,min(energy,e-1));
    } else {
      float e = energy;
      energy+=deltaEnergy;

      fill(0x08,0xff,0x25);
      drawBar(height,energy);

      fill(0x08,0xf0,0x25);
      drawBar(height,min(e,energy-1));
    }

    if(energy < 0) {
      dead = true;
    }
  }
}
