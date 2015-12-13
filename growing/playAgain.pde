boolean dead = false;

Box yes, no, title;

void againSetup() {
  title = new Box( width/4,1*height/5,width/2,height/5,255 );
  yes   = new Box( width/5,3*height/5,width/5,height/5,255 );
  no    = new Box( 3*width/5,3*height/5,width/5,height/5,255 );
}

void againDisplay() {
  title.display();
  yes.display();
  no.display();

  fill(0);
  text("Again ?",width/2,3*height/10-10);
  text("Yes",3*width/10,7*height/10-10);
  text("No",7*width/10,7*height/10-10);
}

void mouseClicked() {
  if(dead) {
    if(yes.over()){
      dead = false;
      load_map(current.carte.name);
    }
    if(no.over()){
      exit();
    }
  }
}

class Box{
  //     These are the things a box 'knows' (they're put up here to indicate that):
  int xpos,ypos;    //  where it is,
  int sizx;          //  how big it is
  int sizy;          //  how big it is
  int col;          //  what color it is, and
  boolean sel;      //  whether it is selected.


  Box( int x, int y, int sx, int sy, int c ){
    this.xpos = x;
    this.ypos = y;
    this.sizx = sx;
    this.sizy = sy;
    this.col = c;
    this.sel=false;
  }


  // One thing our box better know how to do is display (draw) itself when told to. It does this by
  // making normal drawing-environment changes appropriate to the desired result.

  void display (){
    fill(col);
    stroke(0);
    if(this.sel) fill(100);
    rect( xpos,ypos,sizx,sizy );
  }

  // Another useful thing for the box to know is whether a particular test position (x,y)is "on top" of it.
  // Being a box, this basically means testing whether the test-x is between the left and right edges, and
  // whether the test-y is between bottom and top. If both of those things are true, the point is ON the box!

  boolean over(){
    return ( xpos < mouseX && mouseX < xpos + sizx && ypos < mouseY && mouseY < ypos + sizy );
  }

  // the box knows how to move itself a specified distance (basically it just updates it's position)

  void move(int dx, int dy){
    this.xpos += dx;
    this.ypos += dy;
  }

  // and it knows how to become selected and deselected, and you can ask it if it is selected.

  void select(){
    this.sel=true;
  }

  boolean selected(){
    return this.sel;
  }

  void deselect(){
    this.sel=false;
  }
}
