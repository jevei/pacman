class Tile {
  public IntTuple position;
  public int state;
  public CellB cell;
  
  public static final int BLANK = 0;
  public static final int PATH = 1;
  public static final int PATHBLANK = 2;
  public static final int WALL = 3;
  public static final int GHOSTWALL = 4;
  public static final int ENERGIZER = 5;
  public static final int GHOSTSPACE = 6;
  
  public Tile(int _x, int _y) {
    position = new IntTuple(_x, _y);
    state = BLANK;
    cell = null;
  }
}
