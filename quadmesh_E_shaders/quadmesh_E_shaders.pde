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
SpaceObjects Sat1, Sat2, Moon, Sun;
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
int numWater, speedWater, detailWater;
Bubble[] water;
int numFishes, speedFishes;
Fish[] fishContrainer;
float xy = 1;
boolean check = true;

/************************* Global parameters for "Wall" *******************************/
/***************************************************************************************/
Walls Front, Level, Lava, Sand;

/************************* Global parameters for "Shader" *******************************/
/***************************************************************************************/
PShader texShader;
PImage texture, label;

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
Box lavaBox, seaBox, landBox, TIT;

Ellipsoid sun, moon, merkur, venus;

float ti, br;

Fish fish;

void setup() { 
  size(600, 600, P3D);  
  frameRate(50); // 25

  // Control Window
  cp5 = new ControlP5(this);
  cf = addControlFrame("controls", 400, 400); 

  // Texture-Shader Test
  label = loadImage("smiley.jpg");
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
  translate (linksRechts, hochRunter, reinRaus);


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
    Stars[i] = new SpaceObjects( random(MESH, MESH_WIDTH + MESH), random(-2900, 0)+ (-2400), -1200, color(255, 255, 255));
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
  Sat1 = new SpaceObjects(random(400, MESH_WIDTH + MESH), -3500, -1200, loadImage("sat.png"), 5, 10);
  Sat2 = new SpaceObjects(random(400, MESH_WIDTH + MESH), -3200, -1200, loadImage("sat2.png"), 2, 5);

  /************************ Constructor Planets *****************************/
  /**************************************************************************/
  sun = AddEllipsoid (20, 30, "sun.jpg", 490);
  merkur = AddEllipsoid (20, 30, "merkur.jpg", 90);
  venus = AddEllipsoid (20, 30, "venus.jpg", 290);
  moon = AddEllipsoid (20, 30, "moon.jpg", 190);

  lastTime = millis() / 1000.0;
  Front = new Walls(1600, 6000, 40, color(23, 51, 112));

  lavaBox = new Box(this, MESH_WIDTH, 140, -MESH_WIDTH);
  lavaBox = BoxTexture(lavaBox, "lavaBoxVorne.jpg", "lavaBoxVorne.jpg", "lavaBox.jpg", "lavaBox.jpg", "lavaBox.jpg", "lavaBox.jpg");
  seaBox = new Box(this, MESH_WIDTH, 100, -MESH_WIDTH);
  seaBox = BoxTexture(seaBox, "seaBoxVorne.jpg", "seaBoxVorne.jpg", "seaBox.jpg", "seaBox.jpg", "seaBoxOben.jpg", "seaBox.jpg");
  landBox = new Box(this, MESH_WIDTH, 100, -MESH_WIDTH);
  landBox = BoxTexture(landBox, "landBoxVorne.jpg", "landBoxVorne.jpg", "landBoxVorne.jpg", "landBoxVorne.jpg", "landBoxOben.jpg", "landBoxDown.jpg");


  /******************* Constructor Lava Bubbles *****************************/
  /**************************************************************************/
  fishContrainer = new Fish[numFishes];
  for (int i = 0; i < numFishes; i++) 
  {                              // -MESH/2 random(distance3, ditanceFishToLand)
    fishContrainer[i] = new Fish(random(MESH + 50, MESH_WIDTH - 350), random(distance0, (distanceLavaToSea + (-150))), random(-MESH_WIDTH), this);
  }

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
  translate (linksRechts, hochRunter, reinRaus);

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
  lavaBox.moveTo(MESH + (MESH_WIDTH/2), 280 + (MESH_WIDTH / 60), -MESH/2 + 300 + (-MESH_WIDTH/2));
  seaBox.moveTo(MESH + (MESH_WIDTH/2), -247 + (MESH_WIDTH / 60), -MESH/2 + 300 + (-MESH_WIDTH/2));
  landBox.moveTo(MESH + (MESH_WIDTH/2), -953.8 + (-1.85) + (7.5), -MESH/2 + 300 + (-MESH_WIDTH/2));
  lavaBox.draw();  
  seaBox.draw();
  landBox.draw();

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
    Stars[i].update(MESH, MESH_WIDTH + MESH, true);
    Stars[i].renderStars(speedStars, detailStars, radiusStars);
  }

  /********************************* Fish ***********************************/
  /***********************************************************************NOT DONE*/
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
  Sat2.update(MESH, MESH_WIDTH + MESH, false);
  Sat2.render(random(0.001, 0.01));

  /************************** Planets ***************************************/
  /**************************************************************************/
  //Moon.renderMoon(rotationMoon);
  //Sun.renderSun(rotationSun);

  /************************** Positioning Meshes ****************************/
  /**************************************************************************/
  pushMatrix();
  meshLava.doPosition(MESH, 100.0, 0.0);
  shape(pLava);
  popMatrix();

  pushMatrix();
  meshIsland.doPosition(MESH, height/2 - 700, 0);  
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

  sun.rotateBy(0, radians(-rotationSun), 0);
  sun.moveTo(MESH_WIDTH/2 + MESH, -6000, -MESH_WIDTH);
  sun.draw(); // draw earth and added shapes (moon)

  venus.rotateBy(0, radians(+rotationVenus), 0);
  venus.moveTo(MESH_WIDTH/2 + MESH, -4700, -(MESH_WIDTH/2));
  venus.draw(); // draw earth and added shapes (moon)

  merkur.rotateBy(0, radians(-rotationMerkur), 0);
  merkur.moveTo(MESH_WIDTH/2 + MESH, -4250, -(MESH_WIDTH/2));
  merkur.draw(); // draw earth and added shapes (moon)

  moon.rotateBy(0, radians(rotationMoon), 0);
  moon.moveTo(MESH_WIDTH/2 + MESH, -3900, -(MESH_WIDTH/2));
  moon.draw(); // draw earth and added shapes (moon)

}uuu
int tm = 0;

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
      /*if(reinRaus >= 1500)
       {
       reinRaus = 1499;
       }*/
    } else if (keyCode == DOWN) {
      reinRaus -= 1 + Forward_and_Back;
      /*if(reinRaus <= 500)
       {
       reinRaus = 501;
       }*/
    } else if (keyCode == RIGHT) {
      linksRechts -= 1 + Left_and_Right;
      /*if(linksRechts <= -949)
       {
       linksRechts = -950;
       }*/
    } else if (keyCode == LEFT) {
      linksRechts += 1 + Left_and_Right;
      /* if(linksRechts >= 100)
       {
       linksRechts = 100;
       }*/
    } else if (keyCode == ALT) {
      hochRunter -= 1 + Up_and_Down;
      if (hochRunter <= 300)
      {
        hochRunter = 301;
      }
    } else if (keyCode == SHIFT) {
      hochRunter += 1 + Up_and_Down;
    }
  } else {
    background(0, 0, 255);
  }
}

Box BoxTexture(Box lavaBox, String vorne, String hinten, String links, String rechts, String oben, String unten )
{
  lavaBox.setTexture(hinten, lavaBox.FRONT); // Back
  lavaBox.setTexture(vorne, lavaBox.BACK);  // Front
  lavaBox.setTexture(rechts, lavaBox.LEFT);
  lavaBox.setTexture(links, lavaBox.RIGHT);
  lavaBox.setTexture(oben, lavaBox.TOP);  
  lavaBox.setTexture(unten, lavaBox.BOTTOM);
  //lavaBox.visible(true, lavaBox.BOTTOM);
  lavaBox.drawMode(Shape3D.TEXTURE);

  return lavaBox;
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
      fishContrainer[i] = new Fish(random(MESH + 50, MESH_WIDTH - 350), random(distance0, distanceLavaToSea), random(-MESH_WIDTH), this);
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

    lavaBox = new Box(this, MESH_WIDTH, 140, -MESH_WIDTH);
    lavaBox = BoxTexture(lavaBox, "lavaBoxVorne.jpg", "lavaBoxVorne.jpg", "lavaBox.jpg", "lavaBox.jpg", "lavaBox.jpg", "lavaBox.jpg");
    seaBox = new Box(this, MESH_WIDTH, 130, -MESH_WIDTH);
    seaBox = BoxTexture(seaBox, "seaBoxVorne.jpg", "seaBoxVorne.jpg", "seaBox.jpg", "seaBox.jpg", "seaBoxOben.jpg", "seaBox.jpg");
    landBox = new Box(this, MESH_WIDTH, 100, -MESH_WIDTH);
    landBox = BoxTexture(landBox, "landBoxVorne.jpg", "landBoxVorne.jpg", "landBoxDown.jpg", "landBoxDown.jpg", "landBoxOben.jpg", "landBoxDown.jpg");

    break;

    case(9):

    break;

    case(10):
    meshLand = new Mesh(color(255, 0, 0), color(0, 255, 0), N, loadImage("land.jpg"));
    pLand = meshLand.createMesh2(amp0, amp1, scale0, scale1 );
    break;

    case(11):

    break;
  }
}

Ellipsoid AddEllipsoid (int slices, int segments, String textureFile, float radius) 
{
  Ellipsoid aShape = new Ellipsoid(this, slices, segments);
  aShape.setTexture(textureFile);
  aShape.drawMode(Shape3D.TEXTURE);
  aShape.setRadius(radius);
  return aShape;
}

/************** Funktion für Sprite als BG (Laggy) ****/
/* Funktionierende Funktion für BG als Sprite! ********
/* Einfach render für Hintrgrundwand ersetzen.. ******
 
 PVector Mache Wasser()
 {
 PImage fish = loadImage("water.jpg");
 pushMatrix();
 translate(x,y,z);
 image(fish,0,0,mesh,8000);
 popMatrix();
 }
 */
