/*
Name: Goran Vuković  Matrikel: 827827
Aufgabe: Version 3 - Schwer
*/
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

/************************* ControlP5 Interface CLass ***********************************/
/***************************************************************************************/
ControlP5 cp5;
ControlFrame cf;

/************************* Global parameters for "Default" *****************************/
/***************************************************************************************/
float Forward_and_Back, Left_and_Right, Up_and_Down;
int cam_radius;
int clearColor;

/************************* Global parameters for "Space" *******************************/
/***************************************************************************************/
SpaceObjects Sat1, Sat2, Moon, Sun;
Rock[] meteorContrainer;
SpaceObjects[] Stars;
int numMeteor = 150, numStars, speedStars, detailStars, radiusStars;
color[] colorContrainer;
// Meteor Only
float zoomMeteor, detailMeteor, speedMeteor, roughMeteor, radiusMeteor;
float rotationMoon, rotationSun;

/************************* Global parameters for "Clouds" *******************************/
/***************************************************************************************/
int numClouds, speedClouds; 
Cloud[] clouds;

/************************* Global parameters for "Lava" *******************************/
/***************************************************************************************/
int numLava, speedLava, detailLava;
Bubble[] lavaBubbles;

/************************* Global parameters for "Water" *******************************/
/***************************************************************************************/
int numWater, speedWater, detailWater;
Bubble[] water;
int numFishes, speedFishes;
Fish[] fishContrainer;

// Wand Fronte
Walls Front;


// Texture
PShader texShader;
PImage texture, label;

// Time Counter
float timePassed = 0f;
float lastTime = 0;

// quad mesh
PShape pLava, pIsland, pWater, pFront;
Mesh meshLava, meshIsland, meshWater;


// displacement shader
PShader displaceShader;
 
  
// USER PARAMETERS
int N = 400;      
float MESH_WIDTH = 1800;    
float Y_OFFSET = 000;
float center = MESH_WIDTH / 2.0;
int pos = 0;


// Moving
float reinRaus = (MESH_WIDTH/2);
float linksRechts = (width/2) - (MESH_WIDTH/2) + 100;
float hochRunter = height/2 + 300;

int lod = 1;

void setup() { 
  size(600, 600, P3D);  
  frameRate(25);
  
  // Control Window
  cp5 = new ControlP5(this);
  cf = addControlFrame("controls", 400,400); 
  
  // Texture-Shader Test
  label = loadImage("smiley.jpg");
  texShader = loadShader("texfrag.glsl", "texvert.glsl");

  // load shader with fragment-program and vertex-program
  displaceShader = loadShader("displace_frag.glsl", "displace_vert.glsl");

  meshLava = new Mesh(color(255,0,0), color(0,255,0),N , loadImage("lava.png"));
  pLava = meshLava.createMeshNoise(0.01, 0);
  
  meshIsland = new Mesh(color(0,0,0), color(0,0,255),N , loadImage("ocean.jpg"));
  pIsland = meshIsland.createMeshNoise(0.02, 10300);
  
  meshWater = new Mesh(color(68,53,255), color(0,0,255),N , loadImage("water.jpg"));
  pWater = meshWater.createMesh();
  
  // Fishes  
  fishContrainer = new Fish[numFishes];
  for (int i = 0; i < numFishes; i++) 
  {
    fishContrainer[i] = new Fish(random(MESH_WIDTH), random((300) - 200) , random(0  - 1200));
  }
  // init time measurement
  lastTime = millis() / 1000.0;
  Front = new Walls(1600, 6000, 40, color(23,51,112));
  
  // Clouds
  clouds = new Cloud[numClouds];
  for (int i = 0; i < numClouds; i++) 
  {
    clouds[i] = new Cloud(random(-10, 1200), random(-400, 0)+ (-1600) , random(-1200));
  }
  
  // Lava Bubbles
  lavaBubbles = new Bubble[numLava];
  for (int i = 0; i < numLava; i++) 
  {
    lavaBubbles[i] = new Bubble( random(MESH_WIDTH), random(height - 400), random(0  - 1200), color(230, 10, 0));
  }
    
  // Water Bubbles
  water = new Bubble[numWater];
  for (int i = 0; i < numWater; i++) 
  {
    water[i] = new Bubble( random(MESH_WIDTH), random(height - 200), random(-1200, 1800), color(0, 10, 255));
  }
  
  // Stars
  Stars = new SpaceObjects[numStars];
  for (int i = 0; i < numStars; i++) 
  {
    Stars[i] = new SpaceObjects( random(-10, 1700), random(-2900, 0)+ (-2400) , -1300, color(255,255,255));
  }
  
  // Setting Color for Asteroids
  surpriseMe(numMeteor);
  
  // Meteor
  meteorContrainer = new Rock[numMeteor];
  for (int i = 0; i < numMeteor; i++) 
  {
    int tmp = int(dice(0, numMeteor));                       // -400
    meteorContrainer[i] = new Rock(random(-10, 1200), random(-2900, 0)+ (-3500) , random(-1200));
  }
  
  Sat1 = new SpaceObjects(random(-10, 100), -2900 , -1480, loadImage("sat.png"), 5, 10);
  Sat2 = new SpaceObjects(random(-10, 600), -3200 , -1480, loadImage("sat2.png"), 2, 5);
  Moon = new SpaceObjects(900, -4500 , -1480, loadImage("moon.jpg"), 0, 0);
  Sun = new SpaceObjects(700, -5900 , -1480, loadImage("sun.jpg"), 0, 0);

  /*
  Meteor = new SpaceObjects();  
  */  
  // init time measurement
  lastTime = millis() / 1000.0;
}


void draw() {   
  lod = 1 + frameCount/40;
  background(0, 0, 0);
  
  // measure the passed time
  float currentTime = millis() / 1000.0;
  timePassed += (currentTime-lastTime);
  lastTime = currentTime;
  
  for(int i = 0; i < 400; i++)
  {
     pos = meshLava.findQuad(pLava, 200,200, -300.00);
  }
  
    for(int i = 0; i < 400; i++)
  {
     meshWater.displaceQuadY(pWater, 200,200, -300.00);
  }
  
  // pass the value to the shader 
  displaceShader.set("timePassed", timePassed);
  displaceShader.set("pos", pos);
  
  // center mesh to camera
  translate (linksRechts, hochRunter, reinRaus);
  
  // move the middle quad in y-direction  
  float wx = 0.01;
  float wz = 10;
  float t = frameCount*0.01;
  int count = 0;


  for (int x=0; x<N; x++) 
  {
    for (int z=0; z<N; z++) 
    {
      float y = 0;
      //noiseDetail(lod,0.7);
      //y += 255 * noise(0.01*x, 0);
      y += sin(50 * noise(0.1*x+t*10, 0));
    //println("x", x, " z", z);  
    
    meshWater.displaceQuadY(pWater, x, z, sin(0.9) + 0.3); 
    }
  }
  
    // Clouds
    for (int i = 0; i < clouds.length; i++) {
      if(i < (clouds.length / 2))
       {
        clouds[i].update(-10, 980, true);
        clouds[i].render(speedClouds);
       }
     else
     {
        clouds[i].update(980, -10, false);
        clouds[i].render(speedClouds);
     }
    }
     
    // Lava-Bubbles
    for (int i = 0; i < lavaBubbles.length; i++) 
    {
        lavaBubbles[i].update();
        lavaBubbles[i].render(random(1, -1500), random(-100, -800), random(1200, -200), speedLava, detailLava);
        if ( lavaBubbles[i].object.y < -50) 
        {
            lavaBubbles[i].reset(1200);
        }
    }
    
    // Water-Bubbles
    for (int i = 0; i < water.length; i++) 
    {
        water[i].update();
        water[i].render(random(1, -1000), -1000, random(1200, -200), speedWater, detailWater);
        if ( water[i].object.y < -50) 
        {
            water[i].reset(1200);
        }
    }
    
    // Stars
    for (int i = 0; i < Stars.length; i++) 
    {
     if(i < (Stars.length / 2))
       {
        Stars[i].update(100, 1780, true);
        Stars[i].renderStars(speedStars, detailStars, radiusStars);
       }
     else
     {
        Stars[i].update(1780, 100, false);
        Stars[i].renderStars(speedStars, detailStars, radiusStars);
     }
    }   
    
    // Fishes
    for (int i = 0; i < fishContrainer.length; i++) 
    {
      if(i < (fishContrainer.length / 2))
       {
        fishContrainer[i].update(100, 980, true, 1);
        fishContrainer[i].render(speedFishes);
       }
     else
     {
        fishContrainer[i].update(980, 100, false, -1);
        fishContrainer[i].render(speedFishes);
     }
       
    }
    
    // Meteor
    for (int i = 0; i < meteorContrainer.length; i++) 
    { 
      if(i < (meteorContrainer.length / 2))
       {
        meteorContrainer[i].update(-50, 1780, true, radiusMeteor);
        meteorContrainer[i].render(random(0.001, 0.01));
       }
     else
     {
        meteorContrainer[i].update(1728, -50, false, radiusMeteor);
        meteorContrainer[i].render(random(0.001, 0.01));
     }
   }  
   
  // Sat 1
  Sat1.update(-50, 1780, true);
  Sat1.render(random(0.005,0.05));
  Sat2.update(1780, -50, false);
  Sat2.render(random(0.001,0.01));
  
  Moon.renderMoon(rotationMoon);
  Sun.renderSun(rotationSun);
  
  // Texture with Walls
  Front.doImage(MESH_WIDTH/2 + 1500,  height/2 - 8000, -1500);
  Front.doLeft(MESH_WIDTH/2 + 0,  height/2 - 8000, -1500);
  Front.doRight(MESH_WIDTH/2 + 0,  height/2 - 8000, -1500);
  
  
  shape(pLava);
  
    
  pushMatrix();
  translate(0, height/2 - 700, 0);
  shape(pIsland);
  popMatrix();
  
  pushMatrix();
  translate(0, height/2 - 1400, 0);
  shape(pWater);
  popMatrix();
  
    // enable displace shader
  shader(displaceShader);
  
  // enable textureshader
  shader(texShader); 
 
}

float dice(float min, float max)
{
  float tmp = random(max);
  if((tmp > max) && (tmp > min))
  {
    tmp = random(max);
  }
   return tmp;
}

void surpriseMe(int count)
{
  colorContrainer = new color[count];
  for(int i = 0; i < colorContrainer.length; i++)
  {
    if( 60 + (i * 10) > 255)
    {
      colorContrainer[i] = color(255, 255, 255);
    }
    else
    {
      colorContrainer[i] = color(60 + (i * 10), 60 + (i * 10), 60 + (i * 10));
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      reinRaus += 1 + Forward_and_Back;        
      if(reinRaus >= 1500)
      {
        reinRaus = 1499;
      }
    } else if (keyCode == DOWN) {
      reinRaus -= 1 + Forward_and_Back;
      /*if(reinRaus <= 500)
      {
        reinRaus = 501;
      }*/
    } else if (keyCode == RIGHT) {
      linksRechts -= 1 + Left_and_Right;
      if(linksRechts <= -949)
      {
        linksRechts = -950;
      }
    } else if (keyCode == LEFT) {
      linksRechts += 1 + Left_and_Right;
      if(linksRechts >= 100)
      {
        linksRechts = 100;
      }
    } else if (keyCode == ALT) {
      hochRunter -= 1 + Up_and_Down;
      if(hochRunter <= 300)
      {
        hochRunter = 301;
      }
    } else if (keyCode == SHIFT) {
      hochRunter += 1 + Up_and_Down;
    } 
  } else {
      background(0,0,255);
  }
}

void controlEvent(ControlEvent theEvent) {
  
  switch(theEvent.getController().getId()) {
    case(1): // Lava Bubbles
      lavaBubbles = new Bubble[numLava];
      for (int i = 0; i < numLava; i++) 
      {
        lavaBubbles[i] = new Bubble( random(MESH_WIDTH), random(height - 400), random(0  - 1200), color(230, 10, 0));
      }
      break;
    case(2):
      fishContrainer = new Fish[numFishes];
      for (int i = 0; i < numFishes; i++) 
      {
        fishContrainer[i] = new Fish( random(MESH_WIDTH), random((300) - 200) , random(0  - 1200));
      }
      break;
    case(3):
      water = new Bubble[numWater];
      for (int i = 0; i < numWater; i++) 
      {
        water[i] = new Bubble( random(MESH_WIDTH), random(height - 200), random(-1200, 1800), color(0, 10, 255));
      }
      break;
    case(4):
      clouds = new Cloud[numClouds];
      for (int i = 0; i < numClouds; i++) 
      {
        clouds[i] = new Cloud(random(-10, 1200), random(-400, 0)+ (-1600) , random(-1200));
      }
      break;
    case(5):
        for (int i = 0; i < meteorContrainer.length; i++) 
        { 
          meteorContrainer[i].changeDetails(radiusMeteor, roughMeteor, detailMeteor);                    
        }    
      break;
    case(6):
        for (int i = 0; i < meteorContrainer.length; i++) 
        { 
          meteorContrainer[i].changeSpeed(radiusMeteor, speedMeteor);
         }
      break;
    case(7):
      // Stars
  Stars = new SpaceObjects[numStars];
  for (int i = 0; i < numStars; i++) 
  {
    Stars[i] = new SpaceObjects( random(-10, 1700), random(-2900, 0)+ (-2400) , -1300, color(255,255,255));
  }
  break;
  }
}
