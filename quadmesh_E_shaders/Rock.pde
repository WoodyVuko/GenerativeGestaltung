class Rock
{
  float[][][] points;
  float radius, rough, speed;
  float detail;
  boolean rebuild;
  PImage skin;
  PVector spin;
  boolean check;
  PVector pos;
  float angle, tmp;
  
  Rock(float x, float y, float z)
  {
    tmp = 0;
    pos = new PVector( x, y, z);
    check = true;
    this.radius = random(50);
    this.rough  = random(1.8);
    this.detail = random(25);
    this.speed  = random(10);
    noiseSeed(frameCount);
    initPoints();
    initSkin();
  }
  
  void changeSpeed(float radius, float speed)
  {
    //tmp = radius;
    this.speed  = speed;
  }

  void changeDetails(float radius, float rough, float detail)
  {
    this.radius = radius;
    this.rough  = rough;
    this.detail = detail;
    initPoints();
    initSkin();
  }
  void initPoints()
  {
    int i = 0;
    float uStep = 2.0 * PI / detail;
    float vStep = 1.0 * PI / detail;
    points = new float[int(sq(detail + 1))][4][6];
    for(float u = 0.0; u < TWO_PI; u += uStep)
    {
      for(float v = -HALF_PI; v < HALF_PI; v += vStep)
      {
        points[i][0] = getPoint(u +     0, v +     0); // Point as per equation
        points[i][1] = getPoint(u + uStep, v +     0); // Next point around
        points[i][2] = getPoint(u +     0, v + vStep); // Next point up
        points[i][3] = getPoint(u + uStep, v + vStep); // Next point up and around
        i++;
      }
    }
  }

  void initSkin()
  {textureMode(IMAGE);
    int d = 300;
    skin = createImage(d, d, RGB);
    skin.loadPixels();      
    for(int i = 0; i < d; i++)
      for(int j = 0; j < d; j++)
        skin.pixels[i * d + j] = color(255 * noise(i / 5.0, j / 5.0));
    skin.updatePixels();
  }

  float[] getPoint(float u, float v)
  {textureMode(IMAGE);
    PVector p = new PVector(cos(v) * cos(u), cos(v) * sin(u), sin(v));
    float r = radius * ((1 - rough) + rough * 2 * noise(p.x + p.y, p.y + p.z, p.z + p.x));
    return new float[] { p.x * r, p.y * r, p.z * r, u / TWO_PI, (v + HALF_PI) / PI };
  }

  void render(float speed)
  {textureMode(IMAGE);
    this.speed += tmp;
    angle += speed;
    if(rebuild) { noLoop(); initPoints(); loop(); rebuild = false; }
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateX(angle);
    rotateY(angle);
    rotateZ(angle);
    for(int i = 0; i < points.length; i++)
    {
      float[][] pointSet = points[i];
      if(pointSet == null) continue;
      beginShape(TRIANGLE_STRIP);
       texture(skin);
      for(int j = 0; j < pointSet.length; j++)
      {
        float[] p = pointSet[j];
        vertex(p[0], p[1], p[2], p[3] * (skin.width - 1), p[4] * (skin.height - 1));
      }
      endShape();
    }
    popMatrix();
  }
          // -50 bis 1780 = Rechts nach Links
 void update(float left, float right, boolean way, float rad)
    { 
      radius = rad;
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
          }        
        }
      }
    }
    
    float getRadius()
    {
      return radius;
    }

}


