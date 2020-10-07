int cellSize, range;
boolean [][] cells;
boolean [][] bufferedCells;
void setup() {
  size(600, 600);
  frameRate(5);
  cellSize = 10;
  range = width/cellSize;
  cells = new boolean[range][range];
  bufferedCells = new boolean[range][range];

  textSize(20);
  for (int row = 0; row < range; row++) {
    for (int col = 0; col < range; col++) {
      cells[row][col] = random(1.0)<0.1;
    }
  }
  for (int row = 0; row < range; row++) {
    for (int col = 0; col < range; col++) {
      bufferedCells[row][col] = cells[row][col];
    }
  }
}

void draw() {

  for (int row = 0; row < range; row++) {
    for (int col = 0; col < range; col++) {
      //println("row: " + row + " col: " + col);
      if (cells[row][col]) {
        fill(0, 200, 0);
      } else {
        fill(250);
      }
      square(row*cellSize, col*cellSize, cellSize);

    }
  }
  evolve();
}

void evolve() {
  for (int row = 0; row < range; row++) {
    for (int col = 0; col < range; col++) {
      bufferedCells[row][col] = shouldLive(row, col);
    }
  }
  
  for (int row = 0; row < range; row++) {
    for (int col = 0; col < range; col++) {
      cells[row][col] = bufferedCells[row][col];
    }
  }

} 

boolean shouldLive(int row, int col) {
  //return random(1.0) < 0.5;
  int livingNeighbors = 0;
  for (int rowStart = row-1; rowStart<=row+1; rowStart++) {
    for (int colStart = col-1; colStart<=col+1; colStart++) {
      if (rowStart < 0 || rowStart >= range 
        || colStart < 0 || colStart >= range
        || (rowStart == row && colStart==col)) {
        continue;
      }
      if (cells[rowStart][colStart]) {
        livingNeighbors++;
      }
    }
  }
  return (livingNeighbors == 3 || (livingNeighbors == 2 && cells[row][col]) ) ;
}
