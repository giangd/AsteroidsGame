
SpaceShip spaceship = new SpaceShip();
Asteroid asteroid = new Asteroid();
Bullet bullet;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
//test
// Asteroid[] asteroids = new Asteroid[25];
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();

public void setup() {
  size(500,500);
  asteroid.setX(width/2);
  asteroid.setY(height/2);
  noStroke();

  for (int i = 0; i < 10; i ++) {
    asteroids.add(new Asteroid());
  }
}

public void draw() {
  // background(210,210,210);
  background((int)(Math.random()*361),(int)(Math.random()*361),(int)(Math.random()*361));
  spaceship.show();
  spaceship.move();


  // for (int i = 0; i < asteroids.length-1; i ++) {
  //   asteroids[i].show();
  //   asteroids[i].move();
  // }
  for (int i = 0; i < asteroids.size()-1; i ++) {
    Asteroid ast = asteroids.get(i);
    ast.show();
    ast.move();
    ast.myColor = color((int)(Math.random()*361),(int)(Math.random()*361),(int)(Math.random()*361));
    if (dist((float)ast.myCenterX, (float)ast.myCenterY, (float)spaceship.myCenterX, (float)spaceship.myCenterY) < 20) {
      asteroids.remove(i);
    }
    for (Bullet tempBullet : bullets) {
      if (dist((float)ast.myCenterX, (float)ast.myCenterY, (float)tempBullet.myCenterX, (float)tempBullet.myCenterY) < 20) {
        asteroids.remove(i);
      }
    }
  }

  for (int i = bullets.size()-1; i >= 0 ; i --) {
    Bullet tempBullet = bullets.get(i);
    tempBullet.myColor = color((int)(Math.random()*361),(int)(Math.random()*361),(int)(Math.random()*361));
    tempBullet.show();
    tempBullet.move();


    if(tempBullet.myCenterX > width) {     
      bullets.remove(i);
    }    
    else if (tempBullet.myCenterX < 0) {     
      bullets.remove(i);
    }    
    if(tempBullet.myCenterY > height) {    
      bullets.remove(i);
    }   
    else if (tempBullet.myCenterY < 0) {     
      bullets.remove(i);
    }  
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
    myColor = color(0,100,255);
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
    ellipse((float)myCenterX,(float)myCenterY,10,10);
  }
  public void move() {
    myCenterX += myDirectionX;      
    myCenterY += myDirectionY;
  }
}

class Asteroid extends Floater {
  private int myRotationSpeed;
  public Asteroid() {
    corners = 6;
    xCorners = new int[corners];
    yCorners = new int[corners];
    // xCorners[0] = -7;
    // yCorners[0] = -10;
    // xCorners[1] = 7;
    // yCorners[1] = -8;
    // xCorners[2] = 13;
    // yCorners[2] = 0;
    // xCorners[3] = 6;
    // yCorners[3] = 10;
    // xCorners[4] = -5;
    // yCorners[4] = 10;
    // xCorners[5] = -5;
    // yCorners[5] = 0;
    xCorners[0] = -7+((int)(Math.random()*9)-4);
    yCorners[0] = -10+((int)(Math.random()*9)-4);
    xCorners[1] = 7+((int)(Math.random()*9)-4);
    yCorners[1] = -8+((int)(Math.random()*9)-4);
    xCorners[2] = 13+((int)(Math.random()*9)-4);
    yCorners[2] = 0+((int)(Math.random()*9)-4);
    xCorners[3] = 6+((int)(Math.random()*9)-4);
    yCorners[3] = 10+((int)(Math.random()*9)-4);
    xCorners[4] = -5+((int)(Math.random()*9)-4);
    yCorners[4] = 10+((int)(Math.random()*9)-4);
    xCorners[5] = -5+((int)(Math.random()*9)-4);
    yCorners[5] = 0+((int)(Math.random()*9)-4);
    myRotationSpeed = (int)(Math.random()*7)-3;
    myColor = color(182,73,38);
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
    super.move();
    rotate(myRotationSpeed);
  }
}

class SpaceShip extends Floater  { 
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
    myCenterX = 250;
    myCenterY = 250;
    myDirectionX = 0;
    myDirectionY = -1;
    myPointDirection = 270;
    myColor = color(0,100,255);
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
    myColor = color((int)(Math.random()*361),(int)(Math.random()*361),(int)(Math.random()*361));

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

      if (key == 'f') {
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








// //was working on making spaceship movement easier but too much work

// SpaceShip ship = new SpaceShip();
// boolean upIsPressed = false;
// boolean downIsPressed = false;
// boolean leftIsPressed = false;
// boolean rightIsPressed = false;
// String prevKey;
// double speedInc = 0;

// public void setup() {
//   size(500,500);
// }

// public void draw() {
//   background(210,210,210);
//   ship.show();
//   ship.move();

// }

// class SpaceShip extends Floater  { 
//   public SpaceShip() {
//     corners = 4;
//     xCorners = new int[corners];
//     yCorners = new int[corners];
//     xCorners[0] = -8;
//     yCorners[0] = -8;
//     xCorners[1] = 16;
//     yCorners[1] = 0;
//     xCorners[2] = -8;
//     yCorners[2] = 8;
//     xCorners[3] = -2;
//     yCorners[3] = 0;
//     myColor = color(255,255,255);
//     myCenterX = 250;
//     myCenterY = 250;
//     myDirectionX = 0;
//     myDirectionY = 0;
//     myPointDirection = 270;
//     myColor = color(0,100,255);
//   }

//   public void setX(int x) {myCenterX = x;}  
//   public int getX() {return (int)myCenterX;}   
//   public void setY(int y) {myCenterY = y;}   
//   public int getY() {return (int)myCenterY;}   
//   public void setDirectionX(double x) {myDirectionX = x;}   
//   public double getDirectionX() {return myDirectionX;}   
//   public void setDirectionY(double y) {myDirectionY = y;}   
//   public double getDirectionY() {return myDirectionY;}   
//   public void setPointDirection(int degrees) {myPointDirection = degrees;}   
//   public double getPointDirection() {return myPointDirection;}
// }
// abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
// {   
//   protected int corners;  //the number of corners, a triangular floater has 3   
//   protected int[] xCorners;   
//   protected int[] yCorners; 
//   protected int myColor;   
//   protected double myCenterX, myCenterY; //holds center coordinates   
//   protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
//   protected double myPointDirection; //holds current direction the ship is pointing in degrees    
//   abstract public void setX(int x);  
//   abstract public int getX();
//   abstract public void setY(int y);   
//   abstract public int getY();   
//   abstract public void setDirectionX(double x);   
//   abstract public double getDirectionX();
//   abstract public void setDirectionY(double y);   
//   abstract public double getDirectionY();  
//   abstract public void setPointDirection(int degrees);   
//   abstract public double getPointDirection();

//   //Accelerates the floater in the direction it is pointing (myPointDirection)   
//   public void accelerate(double dAmount, char dir) { 
//     if (dir == 'w' || dir == 's') {
//       myCenterY += dAmount;
//     }
//   }   

//   public void accelerate2(double dAmount, char dir) { 
//     if (dir == 'a' || dir == 'd') {
//       myCenterX += dAmount;   
//     }
//   }   

//   public void rotate (int nDegreesOfRotation)   
//   {     
//     //rotates the floater by a given number of degrees    
//     myPointDirection += nDegreesOfRotation;   
//   }   
//   public void move()   //move the floater in the current direction of travel
//   {      
//     //change the x and y coordinates by myDirectionX and myDirectionY       
//     // myCenterX += myDirectionX;    
//     // myCenterY += myDirectionY;     

//     //wrap around screen 
    
//     if(myCenterX > width)
//     {     
//       myCenterX = 0;    
//     }    
//     else if (myCenterX < 0)
//     {     
//       myCenterX = width;    
//     }    
//     if(myCenterY > height)
//     {    
//       myCenterY = 0;    
//     }   
//     else if (myCenterY < 0)
//     {     
//       myCenterY = height;    
//     }   
//   }   

//   public void show()  //Draws the floater at the current position  
//   {             
//     fill(myColor);   
//     stroke(myColor);    
//     //convert degrees to radians for sin and cos         
//     double dRadians = myPointDirection*(Math.PI/180);                 
//     int xRotatedTranslated, yRotatedTranslated;    
//     beginShape();         
//     for(int nI = 0; nI < corners; nI++)    
//     {     
//       //rotate and translate the coordinates of the floater using current direction 
//       xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
//       yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
//       vertex(xRotatedTranslated,yRotatedTranslated);    
//     }   
//     endShape(CLOSE);  
//   }   
// }

// public void keyPressed() {
//   upIsPressed = false;
//   downIsPressed = false;
//   leftIsPressed = false;
//   rightIsPressed = false;

//   if (key == 'w') {
//     upIsPressed = true;
//     speedInc = -5;
//     println(speedInc);
//   }

//   if (key == 's') {
//     downIsPressed = true;
//     speedInc = 5;
//     println(speedInc);
//   }

//   if (key == 'd') {
//     rightIsPressed = true;
//     speedInc = 5;
//     println(speedInc);
//   }

//   if (key == 'a') {
//     leftIsPressed = true;
//     speedInc = -5;
//     println(speedInc);
//   }



//   if (!(upIsPressed && downIsPressed)) {
//     if (upIsPressed) {
//       ship.accelerate(speedInc, 'w');
//     }
//     if (downIsPressed) {
//       ship.accelerate(speedInc, 's');
//     }
//   }

//   if (!(leftIsPressed && rightIsPressed)) {
//     if (leftIsPressed) {
//       ship.accelerate2(speedInc, 'a');
//     }
//     if (rightIsPressed) {
//       ship.accelerate2(speedInc ,'d');
//     }
//   }
// }


