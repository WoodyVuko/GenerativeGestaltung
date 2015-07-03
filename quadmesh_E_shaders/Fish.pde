class Fish
{
    PVector pos, col;
    float   speed, radius;
    boolean check, rotateCheck;
    int direction = 1; // left direction

    
    Fish(float x, float y, float z)
    {
      check = true;
      rotateCheck = true;
      pos = new PVector(x, y, z);
      //pos = new PVector( random(600, -10), random((300) - 200) , random(0  - 1200));
      col = new PVector( random(255), random(255) , random(255));
      //speed = random(1, 5);
      radius = random( 5, 10 );
      println(x);
    }
     
     void xxx(float x)
     {
       println("X: ", pos.x);
       pos.x = x;
       pushMatrix();
       translate(x, pos.y, pos.z);
        popMatrix();
     }
     
      // -50 bis 1780 = Rechts nach Links
    void update(float left, float right, boolean way, int dir)
    { 
      direction = dir;
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
    
     /*
     // -50 bis 1780 = Rechts nach Links
    void update(float left, float right, boolean way, int dir)
    { 
      direction = dir;
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
*/

     
    void render(float speed)
    {       

      this.speed = +speed;
      noStroke();
      pushMatrix();//  -800
      translate(pos.x, -800, pos.z);
      fill(col.x, col.y, col.z, 230);
      //stroke(240);

      triangle (pos.x+5*direction, pos.y, pos.x+15*direction, pos.y-8, pos.x+15*direction, pos.y+8);
      ellipse (pos.x, pos.y, 20, 15);
                //pushMatrix();
                //translate(width/2,height/2);
      fill(44,44,122); 
      popMatrix();

    }
    
    void reset(float scale)
    {
        pos.x = random(scale);
        pos.y = random(height);
        pos.z = random(-1200);
        speed = random(00.1, 0.1);
        radius = random( 5, 10 );
    }
     
}

