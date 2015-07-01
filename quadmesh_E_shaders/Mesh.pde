// Mesh Class       
class Mesh
{     
  color one, two;
  PShape mesh;
  PImage texture;
  float detail;
  PVector pos;
    Mesh(color o, color t, float detai, PImage tex)
    {
      one = o;
      two = t;
      texture = tex;
      detail = detai;  
    }
   
    
void displaceQuadY (PShape shape, int x, int z, float y) {
  
  // find the start vertex of the quad on position xi, zi
  int index = x*4 + z*N*4;
  for (int i=0; i<4; i++) {
    PVector v = shape.getVertex(index+i);
    v.y = y;
    shape.setVertex(index+i,v);  
  }
}

void displaceVertex (PShape shape, int index, float y) {
    PVector v = shape.getVertex(index);
    v.y = y;
    shape.setVertex(index,v);
}

    
    int findQuad(PShape shape, int x, int z, float y) 
    {
      // find the start vertex of the quad on position xi, zi
      int index = z*4 + x*N*4;
      int temp = 0;
      
      for (int i=0; i<4; i++) 
      {
        //PVector v = shape.getVertex(index+i);
        temp = int(y);
        //shape.setVertex(index+i,v);  
      }
      // return shape;
    return temp;      
    }
    PShape createMesh()
    {
      textureMode(NORMAL);
      mesh = createShape();
  
      // quad mesh means, each subsequent 4 vertices form a quad
      mesh.beginShape(QUADS);
  
      // draw no lines
      mesh.noStroke();
  
        // load texture
      mesh.texture(texture);
      
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
      
          
      mesh.vertex(i*w, y, -j*w, i/detail, j/detail);
      mesh.vertex((i+1)*w, y, -j*w, i/detail, j/detail);
      mesh.vertex((i+1)*w, y, -(j+1)*w, i/detail, j/detail);
      mesh.vertex(i*w, y, -(j+1)*w, i/detail, j/detail);
    }
      }
      mesh.endShape();
          return mesh;

    }
    PShape createMeshNoise (float noise, float high) 
    {    
      textureMode(NORMAL);
      mesh = createShape();
      // quad mesh means, each subsequent 4 vertices form a quad
      mesh.beginShape(QUADS);
      // draw no lines
      mesh.noStroke();
      // load texture
      mesh.texture(texture);
      // CALCULATED PARAMETERS
      float w = MESH_WIDTH/N;
      float h = MESH_WIDTH/N;
  
      // iterate over grid, create 4 vertices to draw a single quad
      for (int i=0; i < N; i++) 
      {
        for (int j = 0; j < N; j++) 
        {
          // we calculate the y position of each quad 
          float y = Y_OFFSET;
          // noise freq
          float wx = 0.038;
          float wz = noise;
          // color red for all vertices
          mesh.fill(one);
          float temp = 0;
          if ((i+j)%2==0) 
          {
            mesh.fill(two);
          }
          if(((i >= 200) && (i <= 210  ) && (j >= 200) && (j <= 210)))
          {

         // calculate 2D noise-value, dependant on x,z coordinate
          // noise (w*x, w*z);
          float b = noise (wx*i, wz*j)*255;
          mesh.fill (b);
          mesh.vertex(i*w, b, -j*w, 0, 0);
          
          b = noise (wx*(i+1), wz*j)*255;
          mesh.fill (b);
          mesh.vertex((i+1)*w, b, -j*w ,1920/2, 800);
      
          b = noise(wx*(i+1), wz*(j+1))*255;
          mesh.fill (b);
          mesh.vertex((i+1)*w, b, -(j+1)*w, 1920/2, 800);
      
          b = noise(wx*i,wz*(j+1))*255;
          mesh.fill (b);
          mesh.vertex(i*w, b, -(j+1)*w, 0, 0);
        
          }
          else
          {

         // calculate 2D noise-value, dependant on x,z coordinate
          // noise (w*x, w*z);
          float b = noise (wx*i, wz*j)*255;
          //      mesh.fill (b);
          mesh.vertex(i*w, b, -j*w, i/detail, j/detail);
          
          b = noise (wx*(i+1), wz*j)*255;
          //      mesh.fill (b);
          mesh.vertex((i+1)*w, b, -j*w, i/detail, j/detail);
      
          b = noise(wx*(i+1), wz*(j+1))*255;
          //      mesh.fill (b);
          mesh.vertex((i+1)*w, b, -(j+1)*w,  i/detail, j/detail);
      
          b = noise(wx*i,wz*(j+1))*255;
          //     mesh.fill (b);
          mesh.vertex(i*w, b, -(j+1)*w,  i/detail, j/detail); 
          }
        }
      }
    mesh.endShape();
    return mesh;
  }   

void doPosition(float x, float y, float z)
{      pos = new PVector(x, y, z);

  translate(pos.x, pos.y, pos.z);
}

    }

