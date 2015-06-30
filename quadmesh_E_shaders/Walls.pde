// Wände
class Walls
{
  float breite, hoehe, tiefe;
  PVector size;
  color farbe;
  PImage img;
  PShape wall;

  Walls(float b, float h, float t, color c)
  {
     size = new PVector( b, h, t); 
     farbe = c;
     img = loadImage("black.png");

  }
  
  void render(float x, float y, float z)
  {    
    pushMatrix();
    fill(farbe);
    noStroke();
    translate(x, y, z); 
    box(size.x, size.y, size.z); 
    popMatrix();
  }
  
    void doImage(float x, float y, float z)
  {
    textureMode(IMAGE);
    pushMatrix();
    // load texture
    translate(x,y,z);
    stroke(255);
    fill(127);
    noStroke();  
    beginShape();
    texture(img);
    vertex( 100, 8000, 0, 0,   0);
    vertex( -2950, 8000, 0, 1920/2, 0);
    vertex( -2950,  800, 0, 1920/2, 800);
    vertex( 100,  800, 0, 0,   800);
    endShape(CLOSE);
   popMatrix(); 
  }
  
  void doLeft(float x, float y, float z)
  {
    textureMode(IMAGE);
    pushMatrix();
    translate(x,y,z);
    stroke(255);
    fill(127);
    noStroke();  
    beginShape();
    texture(img);
    vertex( -800, 8000, -100, 0,   0);
    vertex( -800, 8000, 2950, 1920/2, 0);
    vertex( -800,  800, 2950, 1920/2, 800);
    vertex( -800,  800, -100, 0,   800);
    endShape(CLOSE);
   popMatrix(); 
  }
    
  void doRight(float x, float y, float z)
  {
    textureMode(IMAGE);
    pushMatrix();
    translate(x,y,z);
    stroke(255);
    fill(127);
    noStroke();  
    beginShape();
    texture(img);
    vertex( 800, 8000, -100, 0,   0);
    vertex( 800, 8000, 2950, 1920/2, 0);
    vertex( 800,  800, 2950, 1920/2, 800);
    vertex( 800,  800, -100, 0,   800);
    endShape(CLOSE);
   popMatrix(); 
  }
}

