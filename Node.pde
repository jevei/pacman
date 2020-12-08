class Node extends Cell {

  // Variables pour le pathfinding
  private int G;
  private int H;
  private int movementCost;
  
  Node parent; // Cellule parent
  ArrayList<Node> neighbours; // Cellules voisins
  
  
  boolean isStart = false; // Definit si la cellule est une la case départ
  boolean isEnd = false; // Definit si la cellule est une la case fin
  boolean selected = false; // Definit si la cellule est sélectionnée pour le chemin
  
  boolean isWalkable = true; // Definit si la cellule est marchable
  boolean isEateable = false;
  boolean isPortal = false;
  boolean isGhostWall = false;
  boolean isBigBoost = false;
  
  Node (int _x, int _y) {
    super (_x, _y);
    
    G = 0;
    H = 0;
  }
  
  Node (int _x, int _y, int _w, int _h) {
    super (_x, _y, _w, _h);
    
    movementCost = 10;
  }
  
  int getF() {
    return G + H;
  }
  
  int getH() {
    return H;
  }
  
  int getG() {
    return G;
  }
  
  void setH (int h) {
    this.H = h;
  }
  
  // Permet d'ajouter des voisins à la liste
  void addNeighbour (Node neighbour) {
   
    if (neighbours == null) {
      neighbours = new ArrayList<Node>();
    }
    
    neighbours.add(neighbour);
  }
  
  
  void setMovementCost (int cost) {
    movementCost = cost;
    
    
    if (this.parent != null) {
      G = movementCost + parent.getF();
    }
    
  }
  
  Node getParent () {
    return this.parent;
  }    
  
  void setParent (Node parent) {
    this.parent = parent;
    
    this.G = this.movementCost + parent.getF();
    
  }
  
  String toString() {
    return "( " + getF() + ", " + getG() + ", " + getH() + ")"; 
  }
  
  
  void setWalkable (boolean value,boolean ghost, int bgColor) {
    isWalkable =value;
    isGhostWall=ghost;
    fillColor = bgColor;
  }
  void setBoost (boolean value, boolean eateable, int bgColor) {
    isWalkable = value;
    isEateable = eateable;
    fillColor = bgColor;
  }
  void setPortal(boolean value, boolean eateable, boolean portal, int bgColor){
    isWalkable = value;
    isEateable = eateable;
    isPortal = portal;
    fillColor = bgColor;
  }
  void display () {
    pushMatrix();
      translate (x, y);
      fill (fillColor);
      alpha(currentAlpha);
      stroke (0);
      if(isEateable)
      {
        fill (0);
        rect (0, 0, w, h);
        fill (fillColor);
        ellipse(w/2,h/2,w/2,h/2);
      }
      else
      {
        rect (0, 0, w, h);
      }
    popMatrix();
  }
}
