class SpaceObjects
{
    PVector pos;
    float   speed, radius, angle;
    boolean check, rotateCheck;
    int direction = 1; // left direction
    PImage img;
    color col;
    
    SpaceObjects(float x, float y, float z, PImage name, float speedMin, float speedMax)
    {
      check = true;
      rotateCheck = true;
      pos = new PVector( x, y, z);
      speed = random(1, 10);
      radius = random( speedMin, speedMax );
      img = name;
      angle = 0;
    }
 
    SpaceObjects(float x, float y, float z, float speedMin, float speedMax, color cl)
    {
      check = true;
      rotateCheck = true;
      pos = new PVector( x, y, z);
      speed = random(1, 10);
      radius = random( speedMin, speedMax );
      angle = 0;
      col = cl;
    }
     
     // -50 bis 1780 = Rechts nach Links
    void update(float left, float right, boolean way)
    { 
      if(way == true)
      {
        if(check == true)
        {
          if(pos.x >= left)
          {
            pos.x -= speed;

          //pos.y -= sin(20);
          }
          else
          {
            check = false;
            pos.x = right; 
          }
        }
        else
        {
          if(pos.x <= right + 1)
          {
            pos.x += speed;
          }
          else
          {
            check = true;
            direction = 1;
          }
        }
      }
      else
      {
        if(check == true)
        {
          if(pos.x <= left)
          {
            pos.x += speed;

          //pos.y -= sin(20);
          }
          else
          {
            check = false;
            pos.x = right;  
          }
        }
        else
        {
          if(pos.x >= right + 1)
          {
            pos.x -= speed;
          }
          else
          {
            check = true;
            direction = 1; 
          }        
        }
      }
    }

void render(float speed)
{
  angle += speed;
  pushMatrix();
  translate(pos.x, pos.y, pos.z);
  noStroke();
  rotate(angle); 
  beginShape();
  texture(img);
  vertex(-100, -100, 0, 0, 0);
  vertex(100, -100, 0, img.width, 0);
  vertex(100, 100, 0, img.width, img.height);
  vertex(-100, 100, 0, 0, img.height);
  endShape();
  popMatrix();
}

void renderMoon(float speed)
{
  angle += speed;
  pushMatrix();
  translate(pos.x, pos.y, pos.z);
  noStroke();
  rotate(angle); 
  beginShape();
  texture(img);
  vertex(-100, -100, 0, 0, 0);
  vertex(400, -100, 0, img.width, 0);
  vertex(400, 400, 0, img.width, img.height);
  vertex(-100, 400, 0, 0, img.height);
  endShape();
  popMatrix();
}

void renderSun(float speed)
{
  angle += speed;
  pushMatrix();
  translate(pos.x, pos.y, pos.z);
  noStroke();
  rotate(angle); 
  beginShape();
  texture(img);
  vertex(-100, -100, 0, 0, 0);
  vertex(900, -100, 0, img.width, 0);
  vertex(900, 900, 0, img.width, img.height);
  vertex(-100, 900, 0, 0, img.height);
  endShape();
  popMatrix();
}

//void renderMeteor(float x, float y, float z, float speed, float radius)
void renderMeteor(float speed, float radius)
{
  angle += speed;
        stroke(col);
        fill(col);
        for (int i = 1; i < 3; i++) {
            pushMatrix();    // Breite                        Höhe                  Tiefe(tiefer, näher)
            translate (pos.x, pos.y, pos.z); 
            rotate(angle);  
            sphereDetail(3);
            sphere(radius);
            popMatrix(); 
        }
}
    void reset()
    {
      /*
        pos.x = random(200);
        pos.y = random(200);
        pos.z = random(200);
        speed = random(5, 20);
        radius = random( 5, 10 );
        */
    }
     
}

