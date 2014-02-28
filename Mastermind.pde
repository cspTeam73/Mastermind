/*
      ball info
 ======================
 ball diameter = 38
 ball spacing = 67
 center first ball = 69, 886
 first ball top left = 51, 868
 
 hole info
 ======================
 top left first hole = 164, 22
 y spacing = 85
 x spacing = 67
 
 peg info
 ======================
 peg y spacing = 29
 peg x spacing = 33
 peg box spacing = 85
 first peg top left = 75, 19
 
 buttons
 ======================
 first = 169, 268
 second = 169, 412
 last = 169, 555
 
 end buttons
 ======================
 topleft left = 38, 251
 topleft right = 242, 251
 
 */


int[] code = new int[4];
int[][] grid = new int[10][4];
int[][] pegs = new int[20][2];
int[] temp = new int[4];
int[] tempCode = new int[4];

PImage[] balls = new PImage[7];
PImage board, menu, play, play_dark, help, help_dark, quit, quit_dark;
PImage peg_black;
PImage peg_white;

boolean last = false;
boolean button1 = false;
boolean button2 = false;
boolean button3 = false;

int ball;
int row = 0;
int row_count = 0;
int wincheck = 0;

int mode = 0;

void setup() {
  size(480, 774);
  loadImages();
  randomCode();
  //println("Code: " + code[0] + code[1] + code[2] + code[3]);
}

void draw() {
  background(0);
  switch(mode) {
  case 0:
    image(menu, 0, 0);
    startbutton();
    helpbutton();
    quitbutton();
    break;
  case 1:
    drawImages();
    row_count = 0;
    for (int n = 0; n < 4; n++) {
      if (grid[row][n] != 0) row_count++;
    }
    if (row_count == 4) {
      for (int n = 0; n < 4; n++) temp[n] = grid[row][n];
      for (int n = 0; n < 4; n++) tempCode[n] = code[n];
      writePegs(getBlack(row), getWhite(row), row);
      wincheck = 0;
      for (int n = 0; n < 4; n++) {
        if (code[n] == grid[row][n]) wincheck++;
      }
      if (wincheck == 4) {
        //win
        println("You Won!");
        mode = 0;
      } else if (row >= 7) {
        //lose
        println("You Lost!");
        exit();
      }
      row++;
    }
    dragBall();
    break;
  case 2:
      
    break;
  case 3:
    exit();
    break;
  }
  last = mousePressed;
}

void loadImages() {
  board = loadImage("Board.png");
  peg_black = loadImage("BlackPeg.png");
  peg_white = loadImage("WhitePeg.png");
  menu = loadImage("Menu.png");
  play = loadImage("Play.png");
  play_dark = loadImage("Play_Dark.png");
  help = loadImage("Help.png");
  help_dark = loadImage("Help_Dark.png");
  quit = loadImage("Quit.png");
  quit_dark = loadImage("Quit_Dark.png");
  for (int n = 0; n < 7; n++) balls[n] = loadImage(str(n)+".png");
}

void randomCode() {
  for (int n = 0; n < 4; n++) code[n] = int(random(1, 7));
}

void drawImages() {
  image(board, 0, 0);
  for (int y = 0; y < 8; y++) {
    for (int x = 0; x < 4; x++) {
      image(balls[grid[y][x]], 164+x*67, 29+y*85);
    }
  }
  for (int y = 0; y < 8; y++) {
    for (int a = 0; a < 2; a++) {
      for (int b = 0; b < 2; b++) {
        if (pegs[y*2+a][b] == 1) {
          image(peg_white, 75+b*33, 27+y*85+a*29);
        } else if (pegs[y*2+a][b] == 2) {
          image(peg_black, 75+b*33, 27+y*85+a*29);
        }
      }
    }
  }
}

void dragBall() {
  // If you pressed the mouse and you werent pressing it last loop
  if (last == false && mousePressed == true) {
    ball = 0;
    cursor(ARROW);
    for (int n = 1; n < 7; n++) {
      if ((mouseX >= 51+(n-1)*67 && mouseX <= 51+38+(n-1)*67) && (mouseY >= 705 && mouseY <= 705+38)) {
        ball = n;
        cursor(HAND);
      }
    }
  }

  if (last == true && mousePressed == true && ball != 0) {
    cursor(HAND);
    image(balls[ball], mouseX-19, mouseY-19);
  }

  if (last == true && mousePressed == false) {
    cursor(ARROW);
    if (ball != 0) {
      for (int x = 0; x < 4; x++) {
        if ((mouseX >= 164+x*67 && mouseX <= 164+38+x*67) && 
          (mouseY >= 30+row*85 && mouseY <= 30+38+row*85)) {
          grid[row][x] = ball;
          ball = 0;
        }
      }
    }
  }
}

int getBlack(int y) {
  int blackcount = 0;
  for (int n = 0; n < 4; n++) {
    if (temp[n] == tempCode[n]) {
      blackcount++;
      temp[n] = 0;
      tempCode[n] = 0;
    }
  }
  return blackcount;
}

int getWhite(int y) {
  int whitecount = 0;
  for (int n = 0; n < 4; n++) {
    boolean found = false;
    if (tempCode[n] != 0) {
      for (int i = 0; i < 4; i++) {
        if (tempCode[n] == temp[i] && found == false) {
          whitecount++;
          temp[i] = 0;
          found = true;
        }
      }
    }
  }
  return whitecount;
}

void writePegs(int black, int white, int row_y) {
  for (int x = 0; x < black; x++) {
    if (x > 1) {
      pegs[row_y*2+1][x-2] = 2;
    } else {
      pegs[row_y*2][x] = 2;
    }
  }
  for (int x = black; x < black+white; x++) {
    if (x > 1) {
      pegs[row_y*2+1][x-2] = 1;
    } else {
      pegs[row_y*2][x] = 1;
    }
  }
}

void startbutton() {
  if ((mouseX <= 169+140 && mouseX >= 169) && (mouseY <= 268+70 && mouseY >= 268)) {
    if (mousePressed == true) {
      button1 = true;
      image(play_dark, 169, 268);
    } else {
      image(play, 169, 268);
      button1 = false;
    }
    if (mousePressed == false && last == true) {
      mode = 1;
      button1 = false;
      randomCode();
      for (int y = 0; y < 8; y++) {
        for (int x = 0; x < 4; x++) {
          grid[y][x] = 0;
        }
      }
      for (int y = 0; y < 16; y++) {
        for (int x = 0; x < 2; x++) {
          pegs[y][x] = 0;
        }
      }
      row = 0;
    }
  } else {
    image(play, 169, 268);
    button1 = false;
  }
}

void helpbutton() {
  if ((mouseX <= 169+140 && mouseX >= 169) && (mouseY <= 412+70 && mouseY >= 412)) {
    if (mousePressed == true) {
      button2 = true;
      image(help_dark, 169, 412);
    } else {
      image(help, 169, 412);
      button2 = false;
    }
    if (mousePressed == false && last == true) {
      mode = 2;
      button2 = false;
    }
  } else {
    image(help, 169, 412);
    button2 = false;
  }
}

void quitbutton() {
  if ((mouseX <= 169+140 && mouseX >= 169) && (mouseY <= 555+70 && mouseY >= 555)) {
    if (mousePressed == true) {
      button3 = true;
      image(quit_dark, 169, 555);
    } else {
      image(quit, 169, 555);
      button3 = false;
    }
    if (mousePressed == false && last == true) {
      mode = 3;
      button3 = false;
    }
  } else {
    image(quit, 169, 555);
    button3 = false;
  }
}

