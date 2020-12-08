class Blinky {
  int type;
  float x, y, tx, ty;
  int d;
  boolean scared;
  Node nextMove;
  Blinky(/*int itype*/) {
    //type = itype % ghost_colors.length;
    x = 378;
    y = 363;//.5;
    tx = 0;//pacman.x;
    ty = 0;//pacman.y;
    d = 2;
  }
  void draw() {
    simulate();
    render();
  }
  void simulate() {
    findPacman();
    if(nextMove==pacMap.end) //<>//
    {
      restart(); //<>//
    }
    int temp=calcDist();
    println (" x : " + int(x/28) + " -- " + " y : " + int(y/25));
    println (" x : " + int(nextMove.x/28) + " -- " + " y : " + int(nextMove.y/25));
    d=temp;
    move();
  }
  boolean is_not_wall(){
    int i = int(x/28);
    int j = int(y/25); 
    if(d==0)
    {
      i = int((x+14)/28);
    }
    else if(d==1)
    {
      j = int((y+13)/25);
    }
    else if(d==2)
    {
      i = int((x-14)/28);
    }
    else if(d==3)
    {
      j = int((y-13)/25);
    }
    //println ("i : " + i + " x : " + x + " -- j : " + j + " y : " + y);
    return pacMap.isWall(i, j);
  }
  boolean is_ghostWall(){
    int i = int(x/28);
    int j = int(y/25); 
    if(d==0)
    {
      i = int((x+14)/28);
    }
    else if(d==1)
    {
      j = int((y+13)/25);
    }
    else if(d==2)
    {
      i = int((x-14)/28);
    }
    else if(d==3)
    {
      j = int((y-13)/25);
    }
    //println ("i : " + i + " x : " + x + " -- j : " + j + " y : " + y);
    return pacMap.isGhostWall(i, j);
  }
  int calcDist()
  {
    tx = nextMove.x+14;
    ty = nextMove.y+13;
    float distX=tx-x;
    float distY=ty-y;
    //if(x+distX///trouver solution
    if(distX<0)
    {
      if(distY<0)
      {
        distX*=-1;
        distY*=-1;
        if(distX<distY)
        {
          return 3;
        }
        else if(distX>distY)
        {
          return 2;
        }
      }
      else if(distY>0)
      {
        distX*=-1;
        if(distX<distY)
        {
          return 1;
        }
        else if(distX>distY)
        {
          return 2;
        }
      }
    }
    else if(distX>0)
    {
      if(distY<0)
      {
        distY*=-1;
        if(distX<distY)
        {
          return 3;
        }
        else if(distX>distY)
        {
          return 0;
        }
      }
      else if(distY>0)
      {
        if(distX<distY)
        {
          return 1;
        }
        else if(distX>distY)
        {
          return 0;
        }
      }
      if(distX==1)
      {
        x+=1;
      }
    }
    if(distY<0)
    {
      distX*=-1;
      distY*=-1;
      if(distX<distY)
      {
        return 3;
      }
      else if(distX>distY)
      {
        return 2;
      }
    }
    else if(distY>0)
    {
      distX*=-1;
      if(distX<distY-2)
      {
        return 1;
      }
      else if(distX>distY)
      {
        return 2;
      }
      y+=2;
    }
    else if(tx<x)
    {
      return 2;
    }
    else if(tx>x)
    {
      return 0;
    }
    return d;
  }
  void move()
  {
    float pastX=x, pastY=y;
    if (0==d) { 
      x++;
    }
    if (1==d) { 
      y++;
    }
    if (2==d) { 
      x--;
    }
    if (3==d) { 
      y--;
    }
    if (!is_not_wall()) {
      if(!is_ghostWall())
      {
        x = pastX;
        y = pastY;
      }
    }
  }
  void render() {
    stroke(0);
    //fill(is_scared?color(0, 0, 255):ghost_colors[type]);
    fill(255, 0, 0);
    pushMatrix();
    translate(x, y);
    //if (!is_dead) {
      rect(-11, -1, 22, 11);
      arc(0, 0, 22, 22, PI, TWO_PI);
      for (int i=0; i<4; i++) {
        arc(-7+5*i, 10, 5, 5, 0, PI);
      }
    //}
    fill(255);
    noStroke();
    ellipse(-4, 0, 4, 8);
    ellipse(4, 0, 4, 8);
    /*if (is_dead||!is_scared) {
      fill(0, 0, 255);
      int eyex = (d==2?-1:0)+(d==0?1:0);
      int eyey = (d==3?-3:0)+(d==1?3:0);
      ellipse(-4+eyex, eyey, 3, 3);
      ellipse(4+eyex, eyey, 3, 3);
    }*/
    popMatrix();
  }
  void findPacman () {
    pacMap.setStartCell(int(y/25), int(x/28));
    pacMap.setEndCell(int(pacman.y/25), int(pacman.x/28));
    pacMap.updateHs();
    pacMap.findAStarPath();
    if(x==tx&&y==ty)
    {
      nextMove=pacMap.path.get(pacMap.path.size()-2);
    }
    else if(tx==0&&ty==0)
    {
      nextMove=pacMap.path.get(pacMap.path.size()-2);
    }
  }
}
