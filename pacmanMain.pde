NodeMap pacMap;
PacmanMap leMap;

int deltaTime = 0;
int previousTime = 0;

int mapCols = 28;
int mapRows = 31;
int[][] mapRepresentation = { 
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 8, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 8, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 6, 1, 1, 6, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 6, 1, 1, 6, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {9, 6, 6, 6, 6, 6, 0, 6, 6, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 6, 6, 0, 6, 6, 6, 6, 6, 9}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 8, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 8, 1}, 
  {1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1}, 
  {1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1}, 
  {1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};


color baseColor = 0;//color (0, 127, 0);

PacmanGuy pacman;
Blinky blinky;

void setup () {
  size (800, 800);
  //fullScreen();
  leMap = new PacmanMap();
  pacman = new PacmanGuy();
  blinky = new Blinky();
  initMap();
}

void draw () {
  deltaTime = millis () - previousTime;
  previousTime = millis();
  update(deltaTime);
  display();
  blinky.draw();
  pacman.draw();
}

void update (float delta) {
  pacMap.update(delta);
}

void display () {
  
  if (pacMap.path != null) {
    for (Cell c : pacMap.path) {
      //c.setFillColor(color (130, 0, 0));
    }
  }
  pacMap.display();
  pacMap.update();
}

void initMap () {
  pacMap = new NodeMap (mapRows, mapCols); 
  
  pacMap.setBaseColor(baseColor);
  
  /*worldMap.setStartCell(mapCols / 2 - 5, 3);
  worldMap.setEndCell(mapCols - 1, mapRows - 1);*/
  
  /*pacMap.makeWallRandom();
  
  //contour
  pacMap.makeWall (mapCols-1, 0, 30, true);
  pacMap.makeWall (0, mapRows-1, 28, false);
  pacMap.makeWall (mapCols-28, 0, 30, true);
  pacMap.makeWall (0, mapRows-31, 28, false);
  
  //boite fantoome
  pacMap.makeWall (mapCols-11, 13, 5, true);
  pacMap.makeWall (mapCols-18, 13, 5, true);
  pacMap.makeWall (10, mapRows-18, 3, false);
  pacMap.makeWall (15, mapRows-18, 3, false);
  pacMap.makeWall (10, mapRows-14, 8, false);
  
  //inerieur boite
  pacMap.destroyWall (13, mapRows-18, 2, false);
  pacMap.destroyWall (11, mapRows-17, 6, false);
  pacMap.destroyWall (11, mapRows-16, 6, false);
  pacMap.destroyWall (11, mapRows-15, 6, false);
  
  //espace autour boite
  pacMap.destroyWall (mapCols-10, 12, 7, true);
  pacMap.destroyWall (mapCols-19, 12, 7, true);
  pacMap.destroyWall (10, mapRows-13, 8, false);
  pacMap.destroyWall (10, mapRows-19, 8, false);*/
  
  //pacMap.setStartCell(int(random(1,mapCols-1)), int(random(1,mapRows-1)));
  //pacMap.setEndCell(int(random(1,mapCols-1)), int(random(1,mapRows-1)));
  // Mise à jour de tous les H des cellules
  //pacMap.updateHs();
  leMap.generate();
  pacMap.makePacMap(leMap.getTileMap());
  pacman.setNodeMap(pacMap);
  pacMap.generateNeighbourhood();
  /*pacMap.setStartCell(int(random(0,30)),int(random(0,27)));
  pacMap.setEndCell(int(random(0,30)),int(random(0,27)));
  
  
    
  pacMap.generateNeighbourhood();
      
  pacMap.findAStarPath();*/
}
void keyPressed() {
  pacman.on_keyPressed();
}
public void restart()
{
  setup(); //<>//
}
