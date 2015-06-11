/*
Name: Goran Vuković  Matrikel: 827827
Aufgabe: Version 3 - Schwer
*/

// Texture
PShader simpleShader;
PImage texture;

// Time Counter
float timePassed = 0f;
float lastTime = 0;

// quad mesh
PShape mesh;

// displacement shader
PShader displaceShader;
 
  
// USER PARAMETERS
int N = 400;      // 140
float MESH_WIDTH = 5000;    // 10800
float Y_OFFSET = 000;

// Moving
int reinRaus = 300;
float linksRechts = width/2 - MESH_WIDTH/2 + 1500;
float hochRunter = height/2 + 200;

/*
* This function finds the quad on indexed position xi, zi and sets the y-coordinate.
* xi and zi are not the xz-world coordinates but the indices of row and column of the mesh.
* (N/2, N/2) would be the quad in the middle.
*/
void displaceQuadY (PShape shape, int x, int z, float y) {
  // find the start vertex of the quad on position xi, zi
  int index = z*4 + x*N*4;

  for (int i=0; i<4; i++) {
    PVector v = shape.getVertex(index+i);
    v.y = y;
    shape.setVertex(index+i,v);  
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      reinRaus += 550;
    } else if (keyCode == RIGHT) {
      reinRaus -= 550;
    } else if (keyCode == UP) {
      linksRechts -= 550;
    } else if (keyCode == DOWN) {
      linksRechts += 550;
    } else if (keyCode == ALT) {
      hochRunter -= 250;
    } else if (keyCode == SHIFT) {
      hochRunter += 250;
    } 
  } else {
      background(0,0,23);
  }
}

PShape createMesh () {

  mesh = createShape();
  // quad mesh means, each subsequent 4 vertices form a quad
  mesh.beginShape(QUADS);

  // draw no lines
  mesh.noStroke();
  
  
  // CALCULATED PARAMETERS
  float w = MESH_WIDTH/N;
  float h = MESH_WIDTH/N;
  
  // iterate over grid, create 4 vertices to draw a single quad
  for (int i=0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      
      // we calculate the y position of each quad 
      float y = Y_OFFSET;
      
      // noise freq
      float wx = 0.038;
      float wz = 0.01;
      
      
      // color red for all vertices
      mesh.fill(255,0,0);
      
      if ((i+j)%2==0) {
        mesh.fill(0,255,0);
      }
      
      // calculate 2D noise-value, dependant on x,z coordinate
      // noise (w*x, w*z);
      float b = noise (wx*i, wz*j)*255;
//      mesh.fill (b);
      mesh.vertex(i*w, b, -j*w);
      
      b = noise (wx*(i+1), wz*j)*255;
//      mesh.fill (b);
      mesh.vertex((i+1)*w, b, -j*w);
      
      b = noise(wx*(i+1), wz*(j+1))*255;
//      mesh.fill (b);
      mesh.vertex((i+1)*w, b, -(j+1)*w);
      
      b = noise(wx*i,wz*(j+1))*255;
//     mesh.fill (b);
      mesh.vertex(i*w, b, -(j+1)*w);
    }
  }
  mesh.endShape();
  return mesh;
}



void setup() {
  size(600, 600, P3D);  
  
  // load shader with fragment-program and vertex-program
  displaceShader = loadShader("displace_frag.glsl", "displace_vert.glsl");
  mesh = createMesh();
    // init time measurement
  lastTime = millis() / 1000.0;
}

int lod = 1;

void draw() {   
  
  lod = 1 + frameCount/40;
  background(0);
  
  // measure the passed time
  float currentTime = millis() / 1000.0;
  timePassed += (currentTime-lastTime);
  lastTime = currentTime;
  
  // pass the value to the shader 
  displaceShader.set("timePassed", timePassed);
  
  
  // enable displace shader
  shader(displaceShader);
  
  rotateY(1);
  // center mesh to camera
  translate (linksRechts, hochRunter, reinRaus);
  
    // move the middle quad in y-direction  
  float wx = 0.01;
  float wz = 0;
  float t = frameCount*0.01;
 
  for (int x=0; x<N; x++) {
    for (int z=0; z<N; z++) {
    
      float y = 0;
      noiseDetail(lod,0.7);
      y += 255 * noise(0.01*x, 0);
      //y += 50 * noise(0.1*x+t*10, 0);
   
      //displaceVertex (mesh, x, z, y);  
    }
  }
  
  shape(mesh);
}
