/*
Name: Goran Vuković  Matrikel: 827827
Aufgabe: Version 3 - Schwer
*/

float timePassed = 0f;
float lastTime = 0;

// quad mesh
PShape mesh;

// displacement shader
PShader displaceShader;
  
  
// USER PARAMETERS
int N = 140;
float MESH_WIDTH = 1800;


void setup() {
  
  size(600, 600, P3D);  
  
  // load shader with fragment-program and vertex-program
  displaceShader = loadShader("displace_frag.glsl", "displace_vert.glsl");
  mesh = createShape();
  
  // quad mesh means, each subsequent 4 vertices form a quad
  mesh.beginShape(QUADS);
  
  // draw no lines
  mesh.noStroke();
  
  
  // CALCULATED PARAMETERS
  float w = MESH_WIDTH/N;
  float h = MESH_WIDTH/N;
  
  // iterate over grid, create 4 vertices to draw a single quad
  for (int j=0; j < N; j++) {
    for (int i = 0; i < N; i++) {
  
      // we calculate the y position of each quad 
      float y = 100;

      // color red for all vertices
      mesh.fill(255,0,0);
      
      if ((i+j)%2==0) {
        mesh.fill(0,255,0);
      }
      
          
      mesh.vertex(i*w, y, -j*w);
      mesh.vertex((i+1)*w, y, -j*w);
      mesh.vertex((i+1)*w, y, -(j+1)*w);
      mesh.vertex(i*w, y, -(j+1)*w);
    }
  }
  mesh.endShape();
  
    // init time measurement
  lastTime = millis() / 1000.0;
}


void draw() {   
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
  translate (width/2 - MESH_WIDTH/2 + 1500, height/2 + 200, 600);
  shape(mesh);
}
