SpaceShip spaceship = new SpaceShip();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
int numTimesHit = 0; //how many asteroids hit ship

public void setup() {
  
  size(600,600);
  noStroke();
  textAlign(CENTER,CENTER);
  

  for (int i = 0; i < 15; i ++) {
    asteroids.add(new Asteroid());
  }
}

public void draw() {
  if (!focused) {
    background(0);
    fill(255);
    textSize(50);
    text("WASD to Move",width/2,height/2-150);
    text("F to Shoot",width/2,height/2-75);
    text("SPACE to Hyperspace",width/2,height/2);
    fill(0,255,50);
    text("Click Here to Play",width/2,height/2+100);
  } else {
    fill(0,0,0,80);
    noStroke();
    rect(0,0,width,height);
    if (numTimesHit > 5) {
      fill(255,0,50);
      textSize(75);
      text("YOU LOSE",height/2,width/2);
    } else if (asteroids.size() == 0) {
      fill(0,255,50,100);
      textSize(75);
      text("YOU WIN",height/2,width/2);
    }
  
    for (int i = asteroids.size()-1; i >= 0; i --) {
      Asteroid ast = asteroids.get(i);
      ast.show();
      ast.move();
      for (Bullet tempBullet : bullets) { // this is for some out of bounds error, i think this fixes it
        if (dist((float)ast.myCenterX, (float)ast.myCenterY, (float)tempBullet.myCenterX, (float)tempBullet.myCenterY) < 20) {
          asteroids.remove(i);
          break;
        }
      }
      if (numTimesHit<6 && dist((float)ast.myCenterX, (float)ast.myCenterY, (float)spaceship.myCenterX, (float)spaceship.myCenterY) < 20) {
        asteroids.remove(i);
        numTimesHit++;
        spaceship.setColor(numTimesHit);
      }
    }
  
    for (int i = bullets.size()-1; i >= 0 ; i --) {
      Bullet tempBullet = bullets.get(i);
      tempBullet.show();
      tempBullet.move();
  
        if(tempBullet.myCenterX > width) {     
          bullets.remove(i);
        }    
        else if (tempBullet.myCenterX < 0) {     
          bullets.remove(i);
        } else if(tempBullet.myCenterY > height) {    
          bullets.remove(i);
        }   
        else if (tempBullet.myCenterY < 0) {     
          bullets.remove(i);
        }  
    }
  
    spaceship.show();
    spaceship.move();
  }
}

class Bullet extends Floater {
  public Bullet(SpaceShip tempSpaceShip) {
    myCenterX = tempSpaceShip.getX();
    myCenterY = tempSpaceShip.getY();
    myPointDirection = tempSpaceShip.getPointDirection();
    double dRadians = myPointDirection*(Math.PI/180);
    myDirectionX = 5*Math.cos(dRadians) + tempSpaceShip.myDirectionX;
    myDirectionY = 5*Math.sin(dRadians) + tempSpaceShip.myDirectionY;
    myColor = color(200,0,0);
  }
  public void setX(int x) {myCenterX = x;}  
  public int getX() {return (int)myCenterX;}   
  public void setY(int y) {myCenterY = y;}   
  public int getY() {return (int)myCenterY;}   
  public void setDirectionX(double x) {myDirectionX = x;}   
  public double getDirectionX() {return myDirectionX;}   
  public void setDirectionY(double y) {myDirectionY = y;}   
  public double getDirectionY() {return myDirectionY;}   
  public void setPointDirection(int degrees) {myPointDirection = degrees;}   
  public double getPointDirection() {return myPointDirection;}
  public void show() {
    fill(myColor);
    stroke(myColor);
    ellipse((float)myCenterX,(float)myCenterY,5,5);
  }
  public void move() {
    myCenterX += myDirectionX;      
    myCenterY += myDirectionY;
  }
}

class Asteroid extends Floater {
  private int myRotationSpeed;
  public Asteroid() {
    corners = 9;
    myColor = 150;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = 8+((int)(Math.random()*9)-4);
    xCorners[1] = 8+((int)(Math.random()*9)-4);
    xCorners[2] = 0+((int)(Math.random()*9)-4);
    xCorners[3] = -4+((int)(Math.random()*9)-4);
    xCorners[4] = -11+((int)(Math.random()*9)-4);
    xCorners[5] = -11+((int)(Math.random()*9)-4);
    xCorners[6] = -6+((int)(Math.random()*9)-4);
    xCorners[7] = 8+((int)(Math.random()*9)-4);
    xCorners[8] = 10+((int)(Math.random()*9)-4);
    yCorners[0] = 2+((int)(Math.random()*9)-4);
    yCorners[1] = 10+((int)(Math.random()*9)-4);
    yCorners[2] = 12+((int)(Math.random()*9)-4);
    yCorners[3] = 7+((int)(Math.random()*9)-4);
    yCorners[4] = 4+((int)(Math.random()*9)-4);
    yCorners[5] = -5+((int)(Math.random()*9)-4);
    yCorners[6] = -10+((int)(Math.random()*9)-4);
    yCorners[7] = -7+((int)(Math.random()*9)-4);
    yCorners[8] = -3 +((int)(Math.random()*9)-4);

    myRotationSpeed = (int)(Math.random()*7)-3;
    myColor = color(150);
    myCenterX = (int)(Math.random()*width);
    myCenterY = (int)(Math.random()*height);
    myDirectionX = Math.random()-.5;
    myDirectionY = Math.random()-.5;
  }
  public void setX(int x) {myCenterX = x;}  
  public int getX() {return (int)myCenterX;}   
  public void setY(int y) {myCenterY = y;}   
  public int getY() {return (int)myCenterY;}   
  public void setDirectionX(double x) {myDirectionX = x;}   
  public double getDirectionX() {return myDirectionX;}   
  public void setDirectionY(double y) {myDirectionY = y;}   
  public double getDirectionY() {return myDirectionY;}   
  public void setPointDirection(int degrees) {myPointDirection = degrees;}   
  public double getPointDirection() {return myPointDirection;}
  public void move() {
    noStroke();
    super.move();
    rotate(myRotationSpeed);
  }
}

class SpaceShip extends Floater  { 
  int myColorR, myColorG, myColorB, myColorOpacity;

  public SpaceShip(){
    corners = 4;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -8;
    yCorners[0] = -8;
    xCorners[1] = 16;
    yCorners[1] = 0;
    xCorners[2] = -8;
    yCorners[2] = 8;
    xCorners[3] = -2;
    yCorners[3] = 0;
    myCenterX = 300;
    myCenterY = 300;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 270;
    myColorR = 0;
    myColorG = 255;
    myColorB = 50;
    myColorOpacity = 255;
    myColor = color(myColorR,myColorG,myColorB,myColorOpacity);
  }

  public void setColor(int numTimesHit) {
    myColorR += 20*numTimesHit;
    myColorG -= 20*numTimesHit;
    myColorOpacity -= 15*numTimesHit;
    myColor = color(myColorR,myColorG,myColorB,myColorOpacity);
  }
  public void setX(int x) {myCenterX = x;}  
  public int getX() {return (int)myCenterX;}   
  public void setY(int y) {myCenterY = y;}   
  public int getY() {return (int)myCenterY;}   
  public void setDirectionX(double x) {myDirectionX = x;}   
  public double getDirectionX() {return myDirectionX;}   
  public void setDirectionY(double y) {myDirectionY = y;}   
  public double getDirectionY() {return myDirectionY;}   
  public void setPointDirection(int degrees) {myPointDirection = degrees;}   
  public double getPointDirection() {return myPointDirection;}
  public void move() {
    super.move();

    boolean upIsPressed = false;
    boolean downIsPressed = false;
    boolean leftIsPressed = false;
    boolean rightIsPressed = false;

    if (keyPressed) {
      if (key == 'w') {
        upIsPressed = true;
      }
    
      if (key == 's') {
        downIsPressed = true;
      }
    
      if (key == 'd') {
        rightIsPressed = true;
      }
    
      if (key == 'a') {
        leftIsPressed = true;
      }

      if (key == 'f' && numTimesHit<6) {
        bullets.add(new Bullet(spaceship)); 
      }

      if (!(upIsPressed && downIsPressed)) {
        if (upIsPressed) {
          accelerate(0.08);
        }
        if (downIsPressed) {
          accelerate(-0.08);
        }
      }
    
      if (!(leftIsPressed && rightIsPressed)) {
        if (rightIsPressed) {
          rotate(5);
        }
        if (leftIsPressed) {
          rotate(-5);
        }
      }
    }
  }
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners; 
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();  
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection();

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate(double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians = myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection += nDegreesOfRotation;   
  }   
  public void move()   //move the floater in the current direction of travel
  {     
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;      
    myCenterY += myDirectionY;

    //wrap around screen    
    if(myCenterX > width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX < 0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY > height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   

  }   

  public void show()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
}

public void keyPressed() {
  if (key == ' ') {
    spaceship.setDirectionX(0);
    spaceship.setDirectionY(0);
    spaceship.setX((int)(Math.random()*width+1));
    spaceship.setY((int)(Math.random()*height+1));
    spaceship.setPointDirection((int)(Math.random()*361));
  }
}

