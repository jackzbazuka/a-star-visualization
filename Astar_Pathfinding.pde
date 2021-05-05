// Set the grid dimensions (rows and columns will be equal because the nodes are square in shape)
float columns = 60;
float rows = columns;

// Instantiate the cell object array
Cell[][] grid = new Cell[(int)rows][(int)columns];

// Unevaluated cells
ArrayList<Cell>openSet = new ArrayList<Cell>();

// Evaluated cells
ArrayList<Cell>closedSet = new ArrayList<Cell>();

// Path to Re-trace
ArrayList<Cell>path = new ArrayList<Cell>();

boolean noSolution = false;

Cell start, end, current;

// Heurestic function
int heurestic(Cell neighbor, Cell end) {
  int dist = (int)dist(neighbor.i, neighbor.j, end.i, end.j);
  //int dist = abs(neighbor.i - end.i) + abs(neighbor.j - end.j);
  return dist;
}

void setup() {
  
  // Windows dimensions
  size(700, 700);
  
  // Background for window
  background(255);

  // Size of single square cell
  float size = (float)(width / columns);
  float x = size / 2;
  float y = x;
  
  // x, y initial value will be size / 2
  // x = half of size of cell (increase values in half)
  // y = increase y by size after inner loop
  // Making 2D grid with cell objects
  for (int i = 0; i < rows; i++) {
    if (i != 0) {
      x = size / 2;
    }
    for (int j = 0; j < columns; j++) {
      System.out.println(size);
      grid[i][j] = new Cell(x, y, size, i, j);
      x += size;
    }
    y += size;
  }
  
  // Add neighbors for each cell
  for(int i = 0; i < rows; i++) {
    for(int j = 0; j < columns; j++) {
      grid[i][j].addNeighbors(grid);
    }
  }

  // Select start and end nodes
  start = grid[0][0];
  end = grid[(int)columns - 1][(int)columns - 1];
  start.wall = false;
  end.wall = false;
  
  openSet.add(start);
}

void draw() {
  background(255);
  
  if(openSet.size() > 0) {
    // Keep going
    
    // Index of least cost node in openSet
    int win = 0;
    
    // Iterate over openSet to find cell index of least cost
    for(int i = 0; i < openSet.size(); i++) {
       if(openSet.get(i).f < openSet.get(win).f) {
        // Update win
        win = i;
      }
    }
    
    // Current cell is cell with least cost
    current = openSet.get(win);
    
    // Check if winner equals end cell
    if(current == end) {
      // Re-trace the path
      Cell currentIsEnd = current;
      path.add(currentIsEnd);
      while(currentIsEnd.cameFrom != null) {
        path.add(currentIsEnd.cameFrom);
        currentIsEnd = currentIsEnd.cameFrom;
      }
      noLoop();
      System.out.println("DONE!!");
    }
    
     // Move current from openSet to closedSet
     closedSet.add(current);
     int woop = openSet.indexOf(current);
     openSet.remove(woop);
     
     ArrayList<Cell>neighbors = current.neighbors;
     
     // Iterate over the neighbors of the least cost node to add in openSet
     for(Cell neighbor : neighbors) {
       boolean a = false;
       boolean b = false;
       
       // Check if ncell is in closedSet
       for(Cell ccell : closedSet) {
         if(neighbor == ccell) {
           a = true;
         }
       }
       
       // neighbor not in closedSet
       if(!a && !neighbor.wall) {
         // Increment tentative g by 1
         int tentativeG = neighbor.g + 1;
         
         // Check if ncell is in openSet
         for(Cell ocell : openSet) {
           if(neighbor == ocell) {
             b = true;
           }
         }
         
         // Checking if tentativeG is less that neighbor.g -> update neighbor.g
         if(b) {
           if(tentativeG < neighbor.g) {
             neighbor.g = tentativeG;
           }
         } else {
           neighbor.g = tentativeG;
           openSet.add(neighbor);
         }
         
         neighbor.h = heurestic(neighbor, end);
         neighbor.f = neighbor.g + neighbor.h;
         neighbor.cameFrom = current;
       }
     }
  } else {
    // No solution
    System.out.println("No Solution");
    noLoop();
  }

  // Displaying the grid
  for(int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      grid[i][j].display(255, 255, 255);
    }
  }

  for(Cell cell : closedSet)
  {
    cell.display(255, 0, 0);
  }

  for(Cell cell : openSet) {
    cell.display(0, 255, 0);
  }

  for(Cell cell : path) {
    cell.display(0, 0, 255);
  }
}
