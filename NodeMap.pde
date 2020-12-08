/********************
  Énumération des directions
  possibles
  
********************/
enum Direction {
  EAST, SOUTH, WEST, NORTH
}

/********************
  Représente une carte de cellule permettant
  de trouver le chemin le plus court entre deux cellules
  
********************/
class NodeMap extends Matrix {
  Node start;
  Node end;
  
  ArrayList <Node> path;
  
  ArrayList <Node> openList;
  ArrayList <Node> closeList;
  
  boolean debug = false;
  
  NodeMap (int nbRows, int nbColumns) {
    super (nbRows, nbColumns);
  }
  
  NodeMap (int nbRows, int nbColumns, int bpp, int width, int height) {
    super (nbRows, nbColumns, bpp, width, height);
  }
  
  void init() {
    
    cells = new ArrayList<ArrayList<Cell>>();
    
    for (int j = 0; j < rows; j++){
      // Instanciation des rangees
      cells.add (new ArrayList<Cell>());
      
      for (int i = 0; i < cols; i++) {
        Cell temp = new Node(i * cellWidth, j * cellHeight, cellWidth, cellHeight);
        
        // Position matricielle
        temp.i = i;
        temp.j = j;
        
        cells.get(j).add (temp);
      }
    }
    
    println ("rows : " + rows + " -- cols : " + cols);
  }
  
  /*
    Configure la cellule de départ
  */
  void setStartCell (int j, int i) {
    
    if (start != null) {
      start.isStart = false;
      //start.setFillColor(baseColor);
    } 
    
    start = (Node)cells.get(j).get(i);
    while(start.isStart!=true)
    {
      if(((start.isWalkable||start.isGhostWall)==true)&&(start.isEnd==false))
      {
        start.isStart = true;
        println (start.j,start.i);
      }
      else
      {
        i=int(random(1,mapCols-1));
        j=int(random(1,mapRows-1));
        start = (Node)cells.get(j).get(i);
      }
    }
    
    //start.setFillColor(color (130, 0, 130));
  }
  
  /*
    Configure la cellule de fin
  */
  void setEndCell (int j, int i) {
    
    if (end != null) {
      end.isEnd = false;
      //end.setFillColor(baseColor);
    }
    
    end = (Node)cells.get(j).get(i);
    while(end.isEnd!=true)
    {
      if(end.isWalkable==true&&end.isStart==false)
      {
        end.isEnd = true;
        println (end.j,end.i);
      }
      else
      {
        i=int(random(1,mapCols-1));
        j=int(random(1,mapRows-1));
        end = (Node)cells.get(j).get(i);
      }
    }
    
    
    //end.setFillColor(color (127, 255, 0));
  }
  
  /** Met a jour les H des cellules
  doit etre appele apres le changement du noeud
  de debut ou fin
  */
  void updateHs() {
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        Node current = (Node)cells.get(j).get(i); 
        current.setH( calculateH(current));
      }
    }
  }
  
  // Permet de generer aleatoirement le cout de deplacement
  // entre chaque cellule
  void randomizeMovementCost() {
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        
        int cost = parseInt(random (0, cols)) + 1;
        
        Node current = (Node)cells.get(j).get(i);
        current.setMovementCost(cost);
       
      }
    }
  }
  
  // Permet de generer les voisins de la cellule a la position indiquee
  void generateNeighbours(int i, int j) {
    Node c = (Node)getCell (i, j);
    if (debug) println ("Current cell : " + i + ", " + j);
    
    
    for (Direction d : Direction.values()) {
      Node neighbour = null;
      
      switch (d) {
        case EAST :
          if (i < cols - 1) {
            if (debug) println ("\tGetting " + d + " neighbour for " + i + ", " + j);
            neighbour = (Node)getCell(i + 1, j);
          }
          break;
        case SOUTH :
          if (j < rows - 1) {
            if (debug) println ("\tGetting " + d + " neighbour for " + i + ", " + j);
            neighbour = (Node)getCell(i, j + 1);
          }
          break;
        case WEST :
          if (i > 0) {
            if (debug) println ("\tGetting " + d + " neighbour for " + i + ", " + j);
            neighbour = (Node)getCell(i - 1, j);
          }
          break;
        case NORTH :
          if (j > 0) {
            if (debug) println ("\tGetting " + d + " neighbour for " + i + ", " + j);
            neighbour = (Node)getCell(i, j - 1);
          }
          break;
      }
      
      if (neighbour != null) {
        if (neighbour.isWalkable||neighbour.isGhostWall) {
          c.addNeighbour(neighbour);
        }
      }
    }
  }
  
  /**
    Génère les voisins de chaque Noeud
    Pas la méthode la plus efficace car ça
    prend beaucoup de mémoire.
    Idéalement, on devrait le faire au besoin
  */
  void generateNeighbourhood() {
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {

        generateNeighbours(i, j);
      }
    }
  }
  
  /*
    Permet de trouver le chemin le plus court entre
    deux cellules
  */
  void findAStarPath () {
    // TODO : Complétez ce code
    //println ("Start and end defined!");
    
    if (start == null || end == null) {
      println ("No start and no end defined!");
      return;
    }
    
    ////
    openList=new ArrayList<Node>();
    closeList=new ArrayList<Node>();
    openList.add(start);
    Node actif;
    while(!openList.isEmpty())
    {
      actif=getLowestCost(openList);
      if(actif==end)
      {
        generatePath(actif);
        //println("DONE!");
        //break;
      }
      openList.remove(actif);
      closeList.add(actif);
      for(int i=0;i<actif.neighbours.size();i++)
      {
        if(closeList.contains(actif.neighbours.get(i)))
        {
          //println ("Voisin déjà évalué");
        }
        else if(actif.neighbours.get(i).isWalkable||actif.neighbours.get(i).isGhostWall)
        {
          int gPrime=actif.getG()+calculateCost(actif,actif.neighbours.get(i));
          if(!openList.contains(actif.neighbours.get(i)))
          {
            openList.add(actif.neighbours.get(i));
          }
          else if(gPrime>=actif.neighbours.get(i).getG())
          {
            //println ("Mauvais chemin");
          }
          actif.neighbours.get(i).parent=actif;
          actif.neighbours.get(i).G=gPrime;
        }
        //println ("Voisin suivant");
      }
    }
    //println ("Error: openList vide!");
    ////
    
    // TODO : Complétez ce code
    ////
    
    ////
    
    // Appelez generatePath si le chemin est terminé
    // TODO : Complétez ce code
    
  }
  
  /*
    Permet de générer le chemin une fois trouvée
  */
  void generatePath (Node current) {
    // TODO : Complétez ce code
    path = new ArrayList<Node>();
    Node temp = current;
    path.add(temp);
    while (/*temp.parent != null||*/temp!=start)
    {
      path.add(temp.parent);
      temp = temp.parent;
    }
  }
  
  /**
  * Cherche et retourne le noeud le moins couteux de la liste ouverte
  * @return Node le moins couteux de la liste ouverte
  */
  private Node getLowestCost(ArrayList<Node> openList) {
    // TODO : Complétez ce code
    Node temp=openList.get(0);
      for(int i=0;i<openList.size();i++)
      {
        if(openList.get(i)!=temp&&openList.get(i).getF()<temp.getF())
        {
          temp=openList.get(i);
          //println (temp.toString());
        }
      }
    return temp;
  }
  

  
 /**
  * Calcule le coût de déplacement entre deux noeuds
  * @param nodeA Premier noeud
  * @param nodeB Second noeud
  * @return
  */
  private int calculateCost(Cell nodeA, Cell nodeB) {
    // TODO : Complétez ce code
    float c = dist(nodeA.i, nodeA.j, nodeB.i, nodeB.j);
    return int(c);
  }
  
  /**
  * Calcule l'heuristique entre le noeud donnée et le noeud finale
  * @param node Noeud que l'on calcule le H
  * @return la valeur H
  */
  private int calculateH(Cell node) {
    // TODO : Complétez ce code
    //return 0;
    float h = dist(node.i, node.j, end.i, end.j);
    return int(h);
  }
  
  String toStringFGH() {
    String result = "";
    
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {

        Node current = (Node)cells.get(j).get(i);
        
        result += "(" + current.getF() + ", " + current.getG() + ", " + current.getH() + ") ";
      }
      
      result += "\n";
    }
    
    return result;
  }
  
  // Permet de créer un mur à la position _i, _j avec une longueur
  // et orientation données.
  void makeWall (int _i, int _j, int _length, boolean _vertical) {
    int max;
    
    if (_vertical) {
      max = _j + _length > rows ? rows: _j + _length;  
      
      for (int j = _j; j < max; j++) {
        ((Node)cells.get(j).get(_i)).setWalkable (false, true, color(0,130,0)/*0*/);
      }       
    } else {
      max = _i + _length > cols ? cols: _i + _length;  
      
      for (int i = _i; i < max; i++) {
        ((Node)cells.get(_j).get(i)).setWalkable (false, true, color(0,130,0));
      }     
    }
  }
  void makeWallRandom()
  {
    for (int j=0; j<30; j++) {
      for (int i=0; i<28; i++) {
        int temp=int(random(0,2));
        if(temp==1)
        {
          ((Node)cells.get(j).get(i)).setWalkable (false, true, color(0,130,0));
        }
      }
    }
  }
  void destroyWall (int _i, int _j, int _length, boolean _vertical) {
    int max;
    
    if (_vertical) {
      max = _j + _length > rows ? rows: _j + _length;  
      
      for (int j = _j; j < max; j++) {
        ((Node)cells.get(j).get(_i)).setWalkable (true, true, 0/*color(0,127,0)*/);
      }       
    } else {
      max = _i + _length > cols ? cols: _i + _length;  
      
      for (int i = _i; i < max; i++) {
        ((Node)cells.get(_j).get(i)).setWalkable (true, true, 0);
      }     
    }
  }
  void makePacMap(/*int tileMap[][]*/Tile map[][])
  {
    for(int j=0;j<31;j++)
    {
      for(int i=0;i<28;i++)
      {
        int tile = map[i][j].state;
        switch(tile) {
          case 0:
            
            break;
          case 1:
            ((Node)cells.get(j).get(i)).setBoost (true, true, color(150,150,0));
            break;
          case 2:
            if((i==27)||(i==0))
            {
               ((Node)cells.get(j).get(i)).setPortal (true, false, true, 0);
            }
            break;
          case 3:
            ((Node)cells.get(j).get(i)).setWalkable (false, false, color(0,130,0));
            break;
          case 4:
            ((Node)cells.get(j).get(i)).setWalkable (false, true, 0);//color(100,100,100));
            break;
          case 5:
            if(j!=30)
            {
              ((Node)cells.get(j).get(i)).setBoost (true, true, color(250,250,0));
            }
            else
            {
              ((Node)cells.get(j).get(i)).setPortal (false, false, false, color(0,130,0));
            }
            break;
          case 6:
            
            break;
        }
      }
    }
  }
  void update()
  {
    if (path != null) {
      for (Node n : path) {
        if(n.isBigBoost==true)
        {
          n.setFillColor(color(250,250,0));
        }
        else if(n.isEateable==true)
        {
          n.setFillColor(color(150,150,0));
        }
        else
        {
          //n.setFillColor(0);
        }
      }
    }
  }
  Boolean isWall(int i, int j)
  {
    Node temp = ((Node)cells.get(j).get(i));
    return temp.isWalkable;
  }
  Boolean isGhostWall(int i, int j)
  {
    Node temp = ((Node)cells.get(j).get(i));
    return temp.isGhostWall;
  }
  void isEateable(int y, int x)
  {
    Node temp = ((Node)cells.get(y).get(x));
    if(temp.isEateable==true)
    {
      ((Node)cells.get(y).get(x)).setBoost (true, false, 0);
    }
  }
  boolean isPortal(int y, int x)
  {
    Node temp = ((Node)cells.get(y).get(x));
    if(temp.isPortal==true)
    {
      return true;
    }
    return false;
  }
  Node getPos(int y, int x)
  {
    return ((Node)cells.get(y).get(x));
  }
}
