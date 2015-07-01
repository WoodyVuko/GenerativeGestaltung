/*
Name: Goran Vuković  Matrikel: 827827
Aufgabe: Version 3 - Schwersdfesrewf
*/
// Wand Fronte
Walls Front;

// Water-Bubbles
int numWater = 50;
Bubble[] water;

// Lava-Bubbles
int numBubbles = 50;
Bubble[] bubbles;

// Fishes
int numFishes = 50;
Fish[] fishContrainer;

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

void setup() {
  size(600, 600, P3D);  
  frameRate(25);
  
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
    fishContrainer[i] = new Fish();
  }
  // init time measurement
  lastTime = millis() / 1000.0;
  Front = new Walls(1600, 6000, 40, color(23,51,112));
  
  // Lava Bubbles
  bubbles = new Bubble[numBubbles];
  for (int i = 0; i < numBubbles; i++) 
  {
    bubbles[i] = new Bubble( random(MESH_WIDTH), random(height - 400), random(1200), color(230, 10, 0));
  }
  
  water = new Bubble[numWater];
  for (int i = 0; i < numWater; i++) 
  {
    water[i] = new Bubble( random(MESH_WIDTH), random(height - 200), random(1200), color(0, 10, 255));
  }
  
      // init time measurement
  lastTime = millis() / 1000.0;
}

int lod = 1;

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
  
  
    // Lava-Bubbles
    for (int i = 0; i < bubbles.length; i++) {
        bubbles[i].update();
        bubbles[i].render(random(1, -1500), random(-200, -800), random(1200, -200));
        if ( bubbles[i].object.y < -50) {
            bubbles[i].reset(1200);
        }
    }
    
    // Water-Bubbles
    for (int i = 0; i < water.length; i++) {
        water[i].update();
        water[i].render(random(1, -1000), -1000, random(1200, -200));
        if ( water[i].object.y < -50) {
            water[i].reset(-1000);
        }
    }
    
    // Fishes
    for (int i = 0; i < fishContrainer.length; i++) {
        fishContrainer[i].update();
        fishContrainer[i].render();
        if ( fishContrainer[i].pos.y < -50) {
            fishContrainer[i].reset();
        }
    }
  
  
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
 
     println("Zeit: ", timePassed);
}



void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      reinRaus += 150;        
      if(reinRaus >= 1500)
      {
        reinRaus = 1499;
      }
    } else if (keyCode == DOWN) {
      reinRaus -= 150;
      /*if(reinRaus <= 500)
      {
        reinRaus = 501;
      }*/
    } else if (keyCode == RIGHT) {
      linksRechts -= 150;
      if(linksRechts <= -949)
      {
        linksRechts = -950;
      }
    } else if (keyCode == LEFT) {
      linksRechts += 150;
      if(linksRechts >= 100)
      {
        linksRechts = 100;
      }
    } else if (keyCode == ALT) {
      hochRunter -= 100;
      if(hochRunter <= 300)
      {
        hochRunter = 301;
      }
    } else if (keyCode == SHIFT) {
      hochRunter += 100;
    } 
  } else {
      background(0,0,255);
  }
}
