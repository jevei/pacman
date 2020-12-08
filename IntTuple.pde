class IntTuple {
  public int x;
  public int y;
  
  public int direction;
  
  public IntTuple(int _x, int _y) {
    x = _x;
    y = _y;
    direction = -1;
  }

  public IntTuple() {
    this(0, 0);
  }
  
  public boolean equals(IntTuple t) {
    return (t.x == x && t.y == y);
  }
}
