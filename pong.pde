float x = 300;
float y = 150;
float dx = random(2, 4);
float dy = random(2, 4);
float ballSpeed = 1;

float pad1Pos; //position of paddle 1
float pad2Pos; //position of paddle 2
float pad1Vel; //velocity of paddle 1
float pad2Vel; //velocity of paddle 2

int counter = 0;
int score1 = 0;
int score2 = 0;


void setup(){
  size(600, 300);
  fill(0);
}

  
void draw(){
  if (score1 == 5 || score2 == 5){
    gameOver();
    return;
  }
  x = x + dx * ballSpeed;
  y = y + dy * ballSpeed;
  background(255);
  ellipse(x, y, 20, 20);
  if (x <= 20 || x >= 580){
    dx = -dx;
  }
  if (y <= 10 || y >= 290){
    dy = -dy;
  }
  drawLines();
  drawPaddles();
  collide();
  drawScores();
}
  
  
/** draw lines and gutters */
void drawLines(){
  line(0, 0, 600, 0); //top line
  line(0, 300, 600, 300); //bottom line
  line(300, 0, 300, 300); //mid line
  line(10, 0, 10, 300); //left gutter
  line(590, 0, 590, 300); //right gutter
}


/** draw left and right paddles and move them */
void drawPaddles(){
  pushStyle();
  strokeWeight(10);
  line(5, pad1Pos, 5, pad1Pos + 80); //paddle width = 10, paddle height = 80
  line(595, pad2Pos, 595, pad2Pos + 80);
  popStyle();
  //update paddle's vertical position, keep paddle on the screen
  if (pad1Pos + pad1Vel >= 0 && pad1Pos + pad1Vel <= 220){
    pad1Pos = pad1Pos + pad1Vel;
  }
  if (pad2Pos + pad2Vel >= 0 && pad2Pos + pad2Vel <= 220){
    pad2Pos = pad2Pos + pad2Vel;
  }
}


/** whether or not the ball collides with the paddles */
void collide(){
  //collide left
  //ball and left paddle collide
  if (x <= 20 && pad1Pos <= y && y <= pad1Pos + 80){
    ballSpeed += 0.1;
  }
  //ball and left paddle doesn't collide, restart ball
  else if (x <= 20 && (y < pad1Pos || y > pad1Pos + 80)){
    score2 += 1;
    counter += 1;
    x = 300;
    y = 150;
    ballSpeed = 1; 
    if (counter % 2 == 0){
      dx = random(2, 4);
      dy = random(2, 4);
    }
    else {
      dx = -random(2, 4);
      dy = -random(2, 4);
    }
  }
  //collide right
  //ball and right paddle collide
  if (x >= 580 && pad2Pos <= y && y <= pad2Pos + 80){
    ballSpeed += 0.1;
  }
  //ball and right paddle doesn't collide, restart ball
  else if (x >= 580 && (y < pad2Pos || y > pad2Pos + 80)){
    score1 += 1;
    counter += 1;
    x = 300;
    y = 150;
    ballSpeed = 1; 
    if (counter % 2 == 0){
      dx = random(2, 4);
      dy = random(2, 4);
    }
    else {
      dx = -random(2, 4);
      dy = -random(2, 4);
    }
  }  
}


/** draw scores of both sides */
void drawScores(){
  fill(0, 0, 0);
  textSize(24);
  text(score1, 150, 100);
  text(score2, 450, 100);
}


/** update paddle's position when key is pressed */
void keyPressed(){
  if (key == 's'){
    pad1Vel = 5;
  }
  else if (key == 'w'){
    pad1Vel = -5;
  }
  else if (keyCode == DOWN){
    pad2Vel = 5;
  }
  else if (keyCode == UP){
    pad2Vel = -5;
  }
}


/** stop moving paddle when key is released */
void keyReleased(){
  if (key == 's'){
    pad1Vel = 0;
  }
  else if (key == 'w'){
    pad1Vel = 0;
  }
  else if (keyCode == DOWN){
    pad2Vel = 0;
  }
  else if (keyCode == UP){
    pad2Vel = 0;
  }
}


/** game over if one side reaches 5 */
void gameOver(){
  pushStyle();
  textSize(36);
  popStyle();
  if (score1 == 5){
    text("Left side wins!", 70, 150);
  }
  else if (score2 == 5){
    text("Right side wins!", 370, 150);
  }
}
