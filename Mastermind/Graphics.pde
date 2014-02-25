/*
Mastermind Graphics and UI
 Nico M.
 
 build number 0.1
 latest revision: 2/21/14 
 
 The graphics and User Interface of the Mastermind Project.
 This file contains code for the Main Menu and other
 GUI features and actions.
 
 Most importantly, it will include major hooks into 
 the gameboard and other drawing functions. 
 */

void pregame() {
  //fancy mode selection
  if ((mouseX > width/2 + 100) &&
    (mouseX < width/2 + 300) &&
    (mouseY > height/2 - 50) &&
    (mouseY < height/2 + 50)) {
    if ((mousePressed == true)) {
      //modeSelect = 2;      //THIS IS AN ARBITRARY FUNCTION
      fill(255);
      rect(width/2 + 95, height/2 - 55, 210, 110);

      background(0);
      //createBoard();       //placeholder for our actual board
    }
    /*else if (modeSelect == 0) {
     fill(random(0, 255), random(0, 255), random(0, 255), random(0, 255));
     rect(width/2 + 95, height/2 - 55, 210, 110);
     }*/
  }
  else if ((mouseX > width/2 - 300) &&
    (mouseX < width/2 - 100) &&
    (mouseY > height/2 - 50) &&
    (mouseY < height/2 + 50)) {
    fill(255, 0, 0);
    rect(width/2 - 305, height/2 - 55, 210, 110);
  }
  else {
    background(15);
  }
  stroke(1);
  fill(255);
  rect(width/2 - 300, height/2 - 50, 200, 100); //singleplayer
  rect(width/2 + 100, height/2 - 50, 200, 100); //multiplayer

  //draw buttontitle
  fill(0);
  textSize(25);
  text("Singleplayer", width/2 - 275, height/2 + 10);
  text("Settings", width/2 + 150, height/2 + 10);
}

