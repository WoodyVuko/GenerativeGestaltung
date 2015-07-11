class Fish
{
  PVector pos, size;
  float   speed, radius;
  boolean check, rotateCheck;
  int direction = 1; // left direction
  PApplet parent;
  Box TIT;

  Fish(float x, float y, float z, PApplet pa, String fish, float br, float ho, float ti)
  {
    speed += random(1, 10);
    size = new PVector(br, ho, ti);
    check = true;
    parent = pa;
    pos = new PVector(x, y, z);
    TIT = new Box(parent, size.x, size.y, size.z);

    TIT = BoxTexture(TIT, fish);
    TIT.moveTo(pos.x, pos.y, pos.z);
  }

  void update(float left, float right, boolean way, int dir)
  { 
    direction = dir;
    if (way == true)
    {
      TIT.rotateToY(6);
      if (check == true)
      {
        if (pos.x >= left)
        {
          pos.x -= speed;

          //pos.y -= sin(20);
        } else
        {
          check = false;
          pos.x = right;
          TIT.rotateToY(6);
        }
      } else
      {
        if (pos.x <= right + 1)
        {
          pos.x += speed;
        } else
        {
          check = true;
          direction = 1;
          TIT.rotateToY(6);
        }
      }
    } else
    {
      TIT.rotateToY(3);
      if (check == true)
      {
        if (pos.x <= left)
        {
          pos.x += speed;

          //pos.y -= sin(20);
        } else
        {
          check = false;
          pos.x = right;
          TIT.rotateToY(3);
        }
      } else
      {
        if (pos.x >= right + 1)
        {
          pos.x -= speed;
        } else
        {
          check = true;
          TIT.rotateToY(3);
          direction = 1;
        }
      }
    }
  }
  void render(float speed)
  {       
    this.speed = speed;
    TIT.moveTo(width + pos.x, pos.y, pos.z);
    TIT.draw();
  }

  void reset(float scale)
  {
    pos.x = random(scale);
    pos.y = random(height);
    pos.z = random(-1200);
    speed = random(00.1, 0.1);
    radius = random( 5, 10 );
  }


  Box BoxTexture(Box Box, String vorne)
  {
    Box.setTexture(vorne, Box.BACK);  // Front
    Box.visible(false, Box.BOTTOM);
    Box.visible(false, Box.FRONT);
    Box.visible(false, Box.TOP);
    Box.visible(false, Box.LEFT);
    Box.visible(false, Box.RIGHT);
    Box.drawMode(Shape3D.TEXTURE);

    return Box;
  }
}
