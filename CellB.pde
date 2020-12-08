class CellB {
  //static int numFilled = 0;
  public boolean filled;
  public IntTuple position;
  public boolean connect[];
  public CellB next[];
  public int number;
  public int group;
  
  public boolean isGhostSpace;
  
  public boolean isRaiseHeightCandidate;
  public boolean raiseHeight;
  public boolean isShrinkWidthCandidate;
  public boolean shrinkWidth;

  public boolean isJoinCandidate;

  public boolean isEdgeTunnelCandidate;
  public boolean isVoidTunnelCandidate;
  public boolean isSingleDeadEndCandidate;
  public int singleDeadEndDir;
  public boolean isDoubleDeadEndCandidate;
  public boolean topTunnel;

  public IntTuple tilePosition;
  public IntTuple tileSize;

  static final int UP = 0;
  static final int RIGHT = 1;
  static final int DOWN = 2;
  static final int LEFT = 3;

  public CellB(int _x, int _y) {
    filled = false;
    position = new IntTuple(_x, _y);
    connect = new boolean[] { false, false, false, false };
    next = new CellB[] { null, null, null, null };
    number = -1;
    group = -1;
    
    isGhostSpace = false;

    isRaiseHeightCandidate = false;
    raiseHeight = false;
    isShrinkWidthCandidate = false;
    shrinkWidth = false;

    isJoinCandidate = false;

    isEdgeTunnelCandidate = false;
    isVoidTunnelCandidate = false;
    isSingleDeadEndCandidate = false;
    singleDeadEndDir = -1;
    isDoubleDeadEndCandidate = false;
    topTunnel = false;

    tilePosition = new IntTuple();
    tileSize = new IntTuple();
  }

  public boolean isOpen(int dir, int prevDir, int size) {
    if ((position.y == 6 && position.x == 0 && dir == DOWN)
        || (position.y == 7 && position.x == 0 && dir == UP)) {
      return false;
    }

    if (size == 2 && (dir == prevDir || ((dir + 2) % 4) == prevDir)) {
      return false;
    }

    if (next[dir] != null && !next[dir].filled) {
      if (!(next[dir].next[LEFT] != null && !next[dir].next[LEFT].filled)) {
        return true;
      }
    }

    return false;
  }

  public boolean isOpen(int dir) {
    return isOpen(dir, -1, -1);
  }

  public ArrayList<Integer> getOpenCells(int prevDir, int size) {
    ArrayList<Integer> openCells = new ArrayList<Integer>();
    for (int i = 0; i != 4; i++) {
      if (isOpen(i, prevDir, size)) {
        openCells.add(new Integer(i));
      }
    }
    return openCells;
  }

  public void connect(int dir) {
    connect[dir] = true;
    next[dir].connect[(dir + 2) % 4] = true;
    if (position.x == 0 && dir == CellB.RIGHT) {
      connect[CellB.LEFT] = true;
    }
  }

  public void fill(int numGroup) {
    filled = true;
    //number = CellB.numFilled++;
    group = numGroup;
  }

  public boolean isCrossCenter() {
    return connect[UP] && connect[RIGHT] && connect[DOWN] && connect[LEFT];
  }
}
