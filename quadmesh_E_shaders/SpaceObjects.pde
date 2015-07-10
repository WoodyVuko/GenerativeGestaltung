class SpaceObjects
{
    PVector pos;
    float   speed, radius, angle, detail;
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
    
    SpaceObjects(float x, float y, float z, color cl)
    {
      check = true;
      rotateCheck = true;
      pos = new PVector( x, y, z);
      col = cl;
    }   
    
     // -50 bis 1780 = Rechts nach Links
    void update(float left, float right, boolean way)
    { 
       
      if(way == true)
      {
        if(check == true)
        {
          if(pos.x > left)
          {
            pos.x -= speed;

          //pos.y -= sin(20);
          }
          else
          {
            //float tmp = pos.x;
            check = false;
            pos.x += speed;
            //pos.x = right;// + tmp; 
          }
        }
        else
        {
          if(pos.x <= right)
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
            pos.x -= speed;  
          }
        }
        else
        {
          if(pos.x > right)
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


    void renderStars(float speed, float detail, float radius)
    { 
      this.detail = detail;
      this.radius = radius;
        this.speed = speed;
        stroke(255,255,255);
        fill(255,255,255);
        for (int i = 1; i < 3; i++) 
        {
            pushMatrix();    // Breite                        Höhe                  Tiefe(tiefer, näher)
            translate (pos.x, pos.y, pos.z);
            
            sphereDetail(int(detail));
            sphere(radius);
            // Ringe statt 3D
            //ellipse( object.x, object.y, i * radius * 2, i * radius * 2 );

            popMatrix(); 
            //println("Breite", object.x + random(1, -1500), "Höhe:", object.y  + random(0, -500), "Tiefe:", object.z - random(1200, -200));

        }

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

