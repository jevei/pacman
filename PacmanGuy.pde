class PacmanGuy {
  float x, y;
  int d;
  float mouth_opening = 0, max_mouth_opening = .4;
  boolean is_mouth_opening = true;
  NodeMap pacMap;
 
  PacmanGuy() {
    x = 379;
    y = 588;
    d = 2;
  }
  void setNodeMap(NodeMap map)
  {
    pacMap = map;
  }
  void draw() {
    simulate();
    render();
  }
  void simulate() {
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
    inspectFloor();
    if (!is_not_wall()) {
      x = pastX;
      y = pastY;
    }
    animate_mouth();
  }
  void animate_mouth() {
    if (is_mouth_opening) {
      mouth_opening+=.01;
    } else {
      mouth_opening-=.01;
    }
    if (mouth_opening >max_mouth_opening || mouth_opening < 0) {
      is_mouth_opening = !is_mouth_opening;
    }
  }
  void inspectFloor() {
    pacMap.isEateable(int(y/25), int(x/28));
    if(pacMap.isPortal(int(y/25), int(x/28))==true)
    {
      if(int(x/28)==27)
      {
        x-=728;
      }
      else if(int(x/28)==0)
      {
        x+=728;
      }
    }
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
  void render() {
    pushMatrix();
    translate(x, y);
    rotate(HALF_PI*d);
    stroke(0);
    fill(255, 255, 0);
    ellipseMode(CENTER);
    ellipse(0, 0, 22, 22);
    fill(0);
    arc(0, 0, 22, 22, -mouth_opening, mouth_opening);
    popMatrix();
  }
  void on_keyPressed() {
    switch(key) {
    case CODED:
      switch(keyCode) {
      case RIGHT:
        x+=28;
        if(is_not_wall())
        {
          if(d==1)
          {
            y-=22;
            if(is_not_wall())
            {
              d = 0;
            }
            y+=22;
          }
          else if(d==2)
          {
            d = 0;
          }
          else if(d==3)
          {
            y+=22;
            if(is_not_wall())
            {
              d = 0;
            }
            y-=22;
          }
        }
        x-=28;
        //println (d);
        break;
      case DOWN:
        y+=25;
        if(is_not_wall())
        {
          if(d==0)
          {
            x-=25;
            if(is_not_wall())
            {
              d = 1;
            }
            x+=25;
          }
          else if(d==2)
          {
            x+=25;
            if(is_not_wall())
            {
              d = 1;
            }
            x-=25;
          }
          else if(d==3)
          {
            d = 1;
          }
        }
        y-=25;
        //println (d);
        break;
      case LEFT:
        x-=28;
        if(is_not_wall())
        {
          if(d==0)
          {
            if(is_not_wall())
            {
              d = 2;
            }
          }
          else if(d==1)
          {
            y-=22;
            if(is_not_wall())
            {
              d = 2;
            }
            y+=22;
          }
          else if(d==3)
          {
            y+=22;
            if(is_not_wall())
            {
              d = 2;
            }
            y-=22;
          }
        }
        x+=28;
        //println (d);
        break;
      case UP:
        y-=25;
        if(is_not_wall())
        {
          if(d==0)
          {
            x-=25;
            if(is_not_wall())
            {
              d = 3;
            }
            x+=25;
          }
          else if(d==1)
          {
            if(is_not_wall())
            {
              d = 3;
            }
          }
          else if(d==2)
          {
            x+=25;
            if(is_not_wall())
            {
              d = 3;
            }
            x-=25;
          }
        }
        y+=25;
        //println (d);
        break;
      }
    }
  }
}
