/*
Name: Goran Vuković  Matrikel: 827827
 Aufgabe: Version 3 - Schwer
 */
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

import shapes3d.utils.*;
import shapes3d.animation.*;
import shapes3d.*;
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
SpaceObjects Sat1, Sat2, Plane, Moon, Sun;
Rock[] meteorContrainer;
SpaceObjects[] Stars;
int numMeteor = 15, numStars, speedStars, detailStars, radiusStars;
color[] colorContrainer;
// Meteor Only
float zoomMeteor, detailMeteor, speedMeteor, roughMeteor, radiusMeteor;
float rotationMoon, rotationSun, rotationMerkur, rotationVenus;

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
int numWater, speedWater, detailWater, speedSharks;
Bubble[] water;
int numFishes, speedFishes, numSharks;
Fish[] fishContrainer;
Fish[] sharkContrainer;
Fish[] shadowContrainer;
float xy = 1;
boolean check = true;

/************************* Global parameters for "Wall" *******************************/
/***************************************************************************************/
Walls Front, Level, Lava, Sand;

/************************* Global parameters for "Shader" *******************************/
/***************************************************************************************/
PShader texShader;
PImage texture;

/************************* Global parameters for "Time" *******************************/
/***************************************************************************************/
float timePassed = 0f;
float lastTime = 0;

/************************* Global parameters for "Mesh" *******************************/
/***************************************************************************************/
PShape pLava, pIsland, pWater, pFront, pLand;
Mesh meshLava, meshIsland, meshWater, meshLand;

/************************* Global parameters for "Shader" *******************************/
/***************************************************************************************/
PShader displaceShader;


/************************* Global Details for "Mesh" ***********************************/
/***************************************************************************************/
int N = 400 ; // 400  
float MESH_WIDTH;    
float Y_OFFSET = 000;
float center = MESH_WIDTH / 2.0;
int pos = 0;

float test, MESH = N + (100*2); // MagicNumber 

/************************* Global parameters for "Distances" ***************************/
/***************************************************************************************/
float distanceLavaToSea = -100;
float distance0 = -800;
float distanceSeaToWater = -900;
float distance1 = -1400;
float distanceWaterToHorizon = -800;
float distance2 = distance0 * 3;
float ditanceFishToLand = 400;
float distance3 = -200;

/************************* Global parameters for "Movement" ****************************/
/***************************************************************************************/
float reinRaus = (MESH_WIDTH/2);
float linksRechts = -MESH - (100);
float hochRunter = height/2 + 300;
int lod = 1;

/************************* Global parameters for "Land" ****************************/
/***************************************************************************************/
float scale0, scale1, amp0, amp1, y_posi;
Level lavaBox, seaBox, landBox;

/************************* Global parameters for "Planet" ****************************/
/***************************************************************************************/
Planet sun, moon, merkur, venus;


/************************************************* TESTING" ****************************/
/***************************************************************************************/
float eins, zwei, drei, vier, fuenf;

void setup() { 
  size(600, 600, P3D);  
  frameRate(50); // 25
  // Control Window
  cp5 = new ControlP5(this);
  cf = addControlFrame("controls", 400, 400); 

  // Texture-Shader Test
  texShader = loadShader("texfrag.glsl", "texvert.glsl");

  // load shader with fragment-program and vertex-program
  displaceShader = loadShader("displace_frag.glsl", "displace_vert.glsl");

  /******************** Constructor for Meshes ******************************/
  /**************************************************************************/
  meshLava = new Mesh(color(255, 0, 0), color(0, 255, 0), N, loadImage("lava.png"));
  pLava = meshLava.createMeshNoise(0.01, 0);

  meshIsland = new Mesh(color(0, 0, 0), color(0, 0, 255), MESH_WIDTH, loadImage("seaBox.jpg"));
  pIsland = meshIsland.createMeshNoise(0.02, 10300);

  meshWater = new Mesh(color(68, 53, 255), color(0, 0, 255), N, loadImage("water2.jpg"));
  pWater = meshWater.createMesh();

  meshLand = new Mesh(color(255, 0, 0), color(0, 255, 0), N, loadImage("landBoxOben.jpg"));
  pLand = meshLand.createMesh2(amp0, amp1, scale0, scale1 );

  /******************* Center to Mesh ***************************************/
  /**************************************************************************/
  translate (linksRechts - 300, hochRunter, reinRaus - 800);


  /************************** Constructor Cloud *****************************/
  /**************************************************************************/
  clouds = new Cloud[numClouds];
  for (int i = 0; i < numClouds; i++) 
  {
    clouds[i] = new Cloud(random(MESH_WIDTH - 400), random(-400, 0)+ (-1600), random(-1200));
  }

  /******************* Constructor Lava Bubbles *****************************/
  /**************************************************************************/
  lavaBubbles = new Bubble[numLava];
  for (int i = 0; i < numLava; i++) 
  {
    lavaBubbles[i] = new Bubble( random(MESH_WIDTH), random(height - 400), random(0  - 1200), color(230, 10, 0));
  }

  /******************** Constructor Air Bubbles *****************************/
  /**************************************************************************/
  water = new Bubble[numWater];
  for (int i = 0; i < numWater; i++) 
  {
    water[i] = new Bubble( MESH, random(distanceSeaToWater, distance1), random( 1200, -200), color(0, 10, 255));
  }

  /******************** Constructor Stars ***********************************/
  /**************************************************************************/
  Stars = new SpaceObjects[numStars];
  for (int i = 0; i < numStars; i++) 
  {
    Stars[i] = new SpaceObjects( random(MESH, MESH_WIDTH + MESH), random(-5920, 0)+ (-2400), -1200, color(255, 255, 255));
  }

  /************************ Constructor Meteors *****************************/
  /**************************************************************************/
  meteorContrainer = new Rock[numMeteor];
  for (int i = 0; i < numMeteor; i++) 
  {
    int tmp = int(dice(0, numMeteor));                       // -400
    meteorContrainer[i] = new Rock(random(400, MESH_WIDTH), random(-2900, 0)+ (-3500), random(-1200));
  }
  /************************ Constructor Sat's *****************************/
  /**************************************************************************/
  Sat1 = new SpaceObjects(random(400, MESH_WIDTH + MESH), -3500, -MESH_WIDTH + 2, loadImage("sat.png"), 5, 10);
  Sat2 = new SpaceObjects(random(900, MESH_WIDTH + MESH), -3200, -MESH_WIDTH + 2, loadImage("sat2.png"), 2, 5);
  Plane = new SpaceObjects(random(900, MESH_WIDTH + MESH), -2400, -1200, loadImage("plane.png"), 2, 5);


  lastTime = millis() / 1000.0;
  Front = new Walls(1600, 6000, 40, color(23, 51, 112));

  /******************* Constructor Ebenen ***********************************/
  /**************************************************************************/
  lavaBox = new Level(this, MESH_WIDTH, 140, -MESH_WIDTH, "lavaBoxVorne.jpg", "lavaBoxVorne.jpg", "lavaBox.jpg", "lavaBox.jpg", "lavaBox.jpg", "lavaBox.jpg");
  seaBox = new Level(this, MESH_WIDTH, 100, -MESH_WIDTH, "seaBoxVorne.jpg", "seaBoxVorne.jpg", "seaBox.jpg", "seaBox.jpg", "seaBoxOben.jpg", "seaBox.jpg");
  landBox = new Level(this, MESH_WIDTH, 20, -MESH_WIDTH, "landBoxVorne.jpg", "landBoxVorne.jpg", "landBoxVorne.jpg", "landBoxDown.jpg", "landBoxVorne.jpg", "landBoxVorne.jpg");

  /******************* Constructor Fishes ***********************************/
  /**************************************************************************/
  fishContrainer = new Fish[numFishes];
  for (int i = 0; i < numFishes; i++) 
  {                              // -MESH/2 random(distance3, ditanceFishToLand)
    fishContrainer[i] = new Fish(random(MESH + 50, MESH_WIDTH - 350), random(distance0, (distanceLavaToSea + (-150))), random(-MESH_WIDTH), this, str(int(random(1, 11))) + "_fish.png", random(15, 50), random(5, 16), 5);
  }

  /******************* Constructor Sharks ***********************************/
  /**************************************************************************/
  sharkContrainer = new Fish[numSharks];
  for (int i = 0; i < numSharks; i++) 
  {                              // -MESH/2 random(distance3, ditanceFishToLand)
    sharkContrainer[i] = new Fish(random(MESH + 50, MESH_WIDTH - 350), random(distance0, (distanceLavaToSea + (-350))), -1190, this, "shark.png", 550, 120, 5);
  }

  /************************ Constructor Planets *****************************/
  /**************************************************************************/
  sun = new Planet(20, 30, this, "sun.jpg", 490);
  merkur = new Planet(20, 30, this, "merkur.jpg", 90);
  venus = new Planet(20, 30, this, "venus.jpg", 290);
  moon = new Planet(20, 30, this, "moon.jpg", 190);

  // init time measurement
  lastTime = millis() / 1000.0;
}
//float distanceLavaToSea = -100;
//float distance0 = -800;
void draw() {   
  lod = 1 + frameCount/40;
  background(0, 0, 0);

  /************************** Time ******************************************/
  /**************************************************************************/
  float currentTime = millis() / 1000.0;
  timePassed += (currentTime-lastTime);
  lastTime = currentTime;

  /************************** Find Middle **********************************/
  /**************************************************************************/
  for (int i = 0; i < 400; i++)
  {
    pos = meshLava.findQuad(pLava, 200, 200, -300.00);
  }

  for (int i = 0; i < 400; i++)
  {
    meshWater.displaceQuadY(pWater, 200, 200, -300.00);
  }

  /********************* Values for Shader **********************************/
  /**************************************************************************/
  displaceShader.set("timePassed", timePassed);

  /************************** Camera ***************************************/
  /**************************************************************************/
  translate (linksRechts - 300, hochRunter, reinRaus);

  /************************** Noise  Water **********************************/
  /**************************************************************************/
  // move the middle quad in y-direction  
  float wx = 0.01;
  float wz = 0;
  float t = frameCount*0.01;

  for (int x=0; x<N; x++) {
    for (int z=0; z<N; z++) {

      float y = 0;
      noiseDetail(lod, 0.7);
      y += 255 * noise(0.01*x, 0);
      //y += 50 * noise(0.1*x+t*10, 0);

      //displaceVertex (mesh, x, z, y);
    }
  }
  /************************** Texture with Walls ****************************/
  /**************************************************************************/
  pushMatrix();
  Front.doImage(            MESH, height/2 - 8000, -MESH_WIDTH, MESH_WIDTH);  
  popMatrix();
  pushMatrix();
  Front.doLeft(       MESH + 800, height/2 - 8000, -MESH_WIDTH, MESH_WIDTH);
  popMatrix();
  pushMatrix();
  Front.doRight(MESH_WIDTH - 200, height/2 - 8000, -MESH_WIDTH, MESH_WIDTH);
  popMatrix();

  /****************************** Boxes *************************************/
  /**************************************************************************/
  lavaBox.render(MESH + (MESH_WIDTH/2), 280 + (MESH_WIDTH / 60), -MESH/2 + 300 + (-MESH_WIDTH/2));
  seaBox.render(MESH + (MESH_WIDTH/2), -267 + (MESH_WIDTH/ 60), -MESH/2 + 300 + (-MESH_WIDTH/2));
  landBox.render(MESH + (MESH_WIDTH/2), -6953.8 + (-1.85) + (7.5), -MESH/2 + 300 + (-MESH_WIDTH/2));

  /****************************** Clouds ************************************/
  /**************************************************************************/
  for (int i = 0; i < clouds.length; i++) {
    if (i < (clouds.length / 2))
    {
      clouds[i].update(300, (MESH_WIDTH/2) + 100, true);
      clouds[i].render(speedClouds);
    } else
    {
      clouds[i].update((MESH_WIDTH/2) + 100, 300, false);
      clouds[i].render(speedClouds);
    }
  }

  /****************************** Lava Bubbles ******************************/
  /**************************************************************************/
  for (int i = 0; i < lavaBubbles.length; i++) 
  {
    pushMatrix();
    lavaBubbles[i].update();
    lavaBubbles[i].render(MESH, random(distanceLavaToSea, distance0), random(1200, -200), speedLava, detailLava);
    if ( lavaBubbles[i].object.y < -50) 
    {
      lavaBubbles[i].reset(MESH*2);
    }
    popMatrix();
  }

  /******************************* Air Bubbles ******************************/
  /**************************************************************************/
  for (int i = 0; i < water.length; i++) 
  {
    pushMatrix();
    water[i].update();
    water[i].render(MESH, random(distanceSeaToWater, distance1), random( 1200, -200), speedWater, detailWater);
    if ( water[i].object.y < -50) 
    {
      water[i].reset(MESH*2);
    }
    popMatrix();
  }

  /********************************* Stars ***********************************/
  /**************************************************************************/
  for (int i = 0; i < numStars; i++) 
  {  
    Stars[i].updatePlane(MESH, MESH_WIDTH + MESH, true);
    Stars[i].renderStars(speedStars, detailStars, radiusStars);
  }

  /********************************* Fish ***********************************/
  /*************************************************************************/
  for (int i = 0; i < fishContrainer.length; i++) 
  {    
    if (i < (fishContrainer.length / 2))
    {
      fishContrainer[i].update(0, MESH_WIDTH, true, 1);
      fishContrainer[i].render(speedFishes);
    } else
    {
      fishContrainer[i].update(MESH_WIDTH, 0, false, -1);
      fishContrainer[i].render(speedFishes);
    }
  }

  /********************************* Sharks ********************************/
  /*************************************************************************/
  for (int i = 0; i < sharkContrainer.length; i++) 
  {    
    if (i < (sharkContrainer.length / 2))
    {
      sharkContrainer[i].update(0, MESH_WIDTH, true, 1);
      sharkContrainer[i].render(speedFishes);
    } else
    {
      sharkContrainer[i].update(MESH_WIDTH, 0, false, -1);
      sharkContrainer[i].render(speedSharks);
    }
  }

  /********************************** Meteors *******************************/
  /**************************************************************************/
  for (int i = 0; i < meteorContrainer.length; i++) 
  { 
    if (i < (meteorContrainer.length / 2))
    {
      meteorContrainer[i].update(MESH, MESH_WIDTH + MESH, true, radiusMeteor);
      meteorContrainer[i].render(random(0.001, 0.01));
    } else
    {
      meteorContrainer[i].update(MESH_WIDTH + MESH, MESH, false, radiusMeteor);
      meteorContrainer[i].render(random(0.001, 0.01));
    }
  }  

  /************************** Satellites ************************************/
  /**************************************************************************/
  Sat1.update(MESH, MESH_WIDTH + MESH, true);
  Sat1.render(random(0.005, 0.05));
  Sat2.update(MESH, MESH_WIDTH + MESH, true);
  Sat2.render(random(0.001, 0.01));
  Plane.updatePlane(MESH, MESH_WIDTH + MESH, true);
  Plane.render(0);
  /************************** Positioning Meshes ****************************/
  /**************************************************************************/
  pushMatrix();
  meshLava.doPosition(MESH, 100.0, 0.0);
  shape(pLava);
  popMatrix();

  pushMatrix();
  meshIsland.doPosition(MESH, height/2 - 766 + eins, 0);  
  shape(pIsland);
  popMatrix();

  pushMatrix();
  meshWater.doPosition(MESH, height/2 - 1400, 0);
  shape(pWater);
  popMatrix();

  pushMatrix();
  meshLand.doPosition(MESH, height/2 - 1500 - y_posi, -MESH_WIDTH);
  shape(pLand);
  popMatrix();

  /************************** Shader ****************************************/
  /**************************************************************************/
  shader(displaceShader);
  shader(texShader);

  /************************ Planets *****************************************/
  /**************************************************************************/
  sun.render(0, radians(-rotationSun), 0, MESH_WIDTH/2 + MESH, -6320, -MESH_WIDTH/2);
  venus.render(0, radians(+rotationVenus), 0, MESH_WIDTH/2 + MESH, -4832, -MESH_WIDTH/2);
  merkur.render(0, radians(-rotationMerkur), 0, MESH_WIDTH/2 + MESH, -3912, -MESH_WIDTH/2);
  moon.render(0, radians(rotationMoon), 0, MESH_WIDTH/2 + MESH, -2880, -MESH_WIDTH/4);
  
  println(linksRechts);
  println(hochRunter);
  println(reinRaus);
}


/************************ Randomfunction **********************************/
/**************************************************************************/
float dice(float min, float max)
{
  float tmp = random(max);
  if ((tmp > max) && (tmp > min))
  {
    tmp = random(max);
  }
  return tmp;
}

/************************** Random Color Grey *****************************/
/**************************************************************************/
void surpriseMe(int count)
{
  colorContrainer = new color[count];
  for (int i = 0; i < colorContrainer.length; i++)
  {
    if ( 60 + (i * 10) > 255)
    {
      colorContrainer[i] = color(255, 255, 255);
    } else
    {
      colorContrainer[i] = color(60 + (i * 10), 60 + (i * 10), 60 + (i * 10));
    }
  }
}

/************************** Movement Control ******************************/
/**************************************************************************/
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      reinRaus += 1 + Forward_and_Back;        
     if(reinRaus >= 1510)
       {
       reinRaus = 1509;
       }
       
    } else if (keyCode == DOWN) {
      reinRaus -= 1 + Forward_and_Back;
     if(reinRaus <= 151)
       {
       reinRaus = 150;
       }
      
    } else if (keyCode == RIGHT) {
      linksRechts -= 1 + Left_and_Right;
      if(linksRechts <= -880)
       {
       linksRechts = -879;
       }
      
    } else if (keyCode == LEFT) {
      linksRechts += 1 + Left_and_Right;
       if(linksRechts >= -320)
       {
         linksRechts = -319;
       }
       
    } else if (keyCode == ALT) {
      hochRunter -= 1 + Up_and_Down;
      if (hochRunter <= 149)
      {
        hochRunter = 148;
      }
      
    } else if (keyCode == SHIFT) {
      hochRunter += 1 + Up_and_Down;
      if(hochRunter >= 7095)
       {
         hochRunter = 7094;
       }
    }
  } else {
    background(0, 0, 255);
  }
}


/************************** Control Window ********************************/
/**************************************************************************/

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
    {                              // -MESH/2 random(distance3, ditanceFishToLand)
      fishContrainer[i] = new Fish(random(MESH + 50, MESH_WIDTH - 350), random(distance0, distanceLavaToSea), random(-MESH_WIDTH), this, str(int(random(1, 11))) +  "_fish.png", random(15, 50), random(5, 16), 5);
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
      clouds[i] = new Cloud(random(-10, 1200), random(-400, 0)+ (-1600), random(-1200));
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
      Stars[i] = new SpaceObjects( random(MESH_WIDTH - 400), random(-2900, 0)+ (-2400), -1300, color(255, 255, 255));
    }
    break;
    case(8):
    meshLava = new Mesh(color(255, 0, 0), color(0, 255, 0), N, loadImage("lava.png"));
    pLava = meshLava.createMeshNoise(0.01, 0);

    meshIsland = new Mesh(color(0, 0, 0), color(0, 0, 255), MESH_WIDTH, loadImage("seaBox.jpg"));
    pIsland = meshIsland.createMeshNoise(0.02, 10300);

    meshWater = new Mesh(color(68, 53, 255), color(0, 0, 255), N, loadImage("water2.jpg"));
    pWater = meshWater.createMesh();

    meshLand = new Mesh(color(255, 0, 0), color(0, 255, 0), N, loadImage("landBoxOben.jpg"));
    pLand = meshLand.createMesh2(amp0, amp1, scale0, scale1 );

    lavaBox = new Level(this, MESH_WIDTH, 140, -MESH_WIDTH, "lavaBoxVorne.jpg", "lavaBoxVorne.jpg", "lavaBox.jpg", "lavaBox.jpg", "lavaBox.jpg", "lavaBox.jpg");
    seaBox = new Level(this, MESH_WIDTH, 100, -MESH_WIDTH, "seaBoxVorne.jpg", "seaBoxVorne.jpg", "seaBox.jpg", "seaBox.jpg", "seaBoxOben.jpg", "seaBox.jpg");
    landBox = new Level(this, MESH_WIDTH, 100, -MESH_WIDTH, "landBoxVorne.jpg", "landBoxVorne.jpg", "landBoxVorne.jpg", "landBoxDown.jpg", "landBoxVorne.jpg", "landBoxVorne.jpg" );  
    
    Stars = new SpaceObjects[numStars];
    for (int i = 0; i < numStars; i++) 
    {
      Stars[i] = new SpaceObjects( random(MESH_WIDTH - 400), random(-2900, 0)+ (-2400), -1300, color(255, 255, 255));
    }
    break;

    case(9):
    /******************* Constructor Sharks ***********************************/
    /**************************************************************************/
    sharkContrainer = new Fish[numSharks];
    for (int i = 0; i < numSharks; i++) 
    {                              // -MESH/2 random(distance3, ditanceFishToLand)
      sharkContrainer[i] = new Fish(random(MESH + 50, MESH_WIDTH - 350), random(distance0, (distanceLavaToSea + (-350))), -1190, this, "shark.png", 550, 120, 5);
    }
    break;

    case(10):
    meshLand = new Mesh(color(255, 0, 0), color(0, 255, 0), N, loadImage("land.jpg"));
    pLand = meshLand.createMesh2(amp0, amp1, scale0, scale1 );
    break;

    case(11):
    break;
  }
}

