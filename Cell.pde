// Blueprint of a node
class Cell {

  // Node coordinates and size
  protected float x, y, dimension;
  
  // Color of the node
  protected int i, j, f, g, h;
  
  protected boolean wall;
  
  protected Cell cameFrom;
  
  protected ArrayList<Cell>neighbors = new ArrayList<Cell>();

  Cell(float x, float y, float dimension, int i, int j) {
    this.x = x;
    this.y = y;
    this.i = i;
    this.j = j;
    this.dimension = dimension;
    this.f = 0;
    this.g = 0;
    this.h = 0;
    this.cameFrom = null;
    this.wall = false;
    if(random(1) < 0.5) {
      this.wall = true;
    }
  }

  void display(int r, int g, int b) {
    fill(r, g, b);
    if(this.wall) {
      fill(0, 0, 0);
    }
    rectMode(CENTER);
    noStroke();
    square(this.x, this.y, this.dimension);
  }

  void addNeighbors(Cell[][] grid) {
    int a = this.i;
    int b = this.j;
    // Bottom neighbor
    if(a < rows - 1) {
      neighbors.add(grid[a+1][b]);
    }
    // Above neighbor
    if(a > 0) {
      neighbors.add(grid[a-1][b]);
    }
    // Right neighbor
    if(b < columns - 1) {
      neighbors.add(grid[a][b+1]);
    }
    // Left neighbor
    if(b > 0) {
      neighbors.add(grid[a][b-1]);
    }
    // Left-top neighbor
    if(a > 0 && b > 0) {
      neighbors.add(grid[a-1][b-1]);
    }
    // Right-top neighbor
    if(a > 0 && b < columns - 1) {
      neighbors.add(grid[a-1][b+1]);
    }
    // Left-bottom neighbor
    if(a < rows - 1 && b > 0) {
      neighbors.add(grid[a+1][b-1]);
    }
    // Right-bottom neighbor
    if(a < rows - 1 && b < columns - 1) {
      neighbors.add(grid[a+1][b+1]);
    }
  }
}
