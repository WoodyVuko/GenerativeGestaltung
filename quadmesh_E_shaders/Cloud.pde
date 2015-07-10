class Cloud
{
    PVector pos, col;
    float   speed, radius;
    boolean check, rotateCheck;
    int direction = 1; // left direction
    
    Cloud(float x, float y, float z)
    {
      check = true;
      rotateCheck = true;
      pos = new PVector( x, y, z);
      col = new PVector( color(255, 155,0),color(255, 155,0),color(255, 155,0));
      //speed = random(1, 2);
      radius = random( 5, 10 );
    }
     
     // -50 bis 1780 = Rechts nach Links */
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
  this.speed = +speed;
  pushMatrix();
  translate(pos.x, pos.y, pos.z);
    //cloud
  fill(255, 255, 255);
  noStroke();
  ellipse(100+pos.x, 50, 60, 60);
 
  fill(255, 255, 255);
  noStroke();
  ellipse(125+pos.x, 55, 50, 50);
 
  fill(255, 255, 255);
  noStroke();
  ellipse(150+pos.x, 60, 30, 30);
 
  fill(255, 255, 255);
  noStroke();
  ellipse(70+pos.x, 60, 30, 30);

 
  //cloud2
  fill(255, 255, 255);
  noStroke();
  ellipse(200+pos.x, 130, 60, 60);
 
  fill(255, 255, 255);
  noStroke();
  ellipse(225+pos.x, 135, 50, 50);
 
  fill(255, 255, 255);
  noStroke();
  ellipse(250+pos.x, 140, 30, 30);
 
  fill(255, 255, 255);
  noStroke();
  ellipse(170+pos.x, 140, 30, 30);
  popMatrix();
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

