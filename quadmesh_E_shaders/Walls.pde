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
    farbe = c;
    size = new PVector(b, h, t);
    img = loadImage("testA.png");     
    //img = loadImage("black.png");
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

  void doImage(float x, float y, float z, float mesh)
  {
    textureMode(IMAGE);
    pushMatrix();
    // load texture
    translate(x, y, z);
    stroke(255);
    fill(127);
    noStroke();  
    beginShape();
    texture(img);
    vertex( 0, 8000, 0, 0, 0);
    vertex( mesh, 8000, 0, 800, 0);
    vertex( mesh, 800, 0, 800, 8000);
    vertex( 0, 800, 0, 0, 8000);
    endShape(CLOSE);
    popMatrix();
  }

  void doLeft(float x, float y, float z, float mesh)
  {
    textureMode(IMAGE);
    pushMatrix();
    translate(x, y, z);
    stroke(255);
    fill(127);
    noStroke();  
    beginShape();
    texture(img);
    vertex( -800, 8000, 0, 0, 0);
    vertex( -800, 8000, mesh, 800, 0);
    vertex( -800, 800, mesh, 800, 8000);
    vertex( -800, 800, 0, 0, 8000);
    endShape(CLOSE);
    popMatrix();
    println("X LEFT: ", x);
  }

  void doRight(float x, float y, float z, float mesh)
  {
    textureMode(IMAGE);
    pushMatrix();
    translate(x, y, z);
    stroke(255);
    fill(127);
    noStroke();  
    beginShape();
    texture(img);
    vertex( 800, 8000, 0, 0, 0);
    vertex( 800, 8000, mesh, 800, 0);
    vertex( 800, 800, mesh, 800, 8000);
    vertex( 800, 800, 0, 0, 8000);
    endShape(CLOSE);
    popMatrix();
  }

  void doLevel ( float x, float y, float z, float mesh)
  {
    //textureMode(IMAGE);
    pushMatrix();
    translate(x, y, z);
    //noStroke();  
    fill(94, 96, 0);
    //texture(img);
    box(size.x, size.y, size.z);
    popMatrix();
    println("x: ", x, "  y:", y, "  z:", z);
  }
}

