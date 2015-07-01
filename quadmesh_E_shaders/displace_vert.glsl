#define PROCESSING_COLOR_SHADER

/*
* default processing variables, used to map the geometry from world coordinates to screen coordinates.
*/
uniform mat4 transform;
uniform mat4 texMatrix;

// CUSTOM
uniform float timePassed;
uniform float pos;

//float freq = 2*PI;

/*
* default processing attributes, that are set for each vertex during setup in quadmesh_E.pde
*/
attribute vec4 vertex;
attribute vec4 color;

varying vec4 vertColor;



// USER PARAMETERS
float SIN_X_FREQUENCY = 0.308;
float SIN_Z_FREQUENCY = 1.2;

float SIN_X_AMPLITUDE = 10.0;
float SIN_Z_AMPLITUDE = 75.0;

float Y_OFFSET = 10.0;

void main() {

    float i = float(timePassed);
  // this is the default vertex position coming from the mesh creation code in the sketch
  vec4 position = vertex;

  // TODO: uncomment next line, to override position value with a value calculated here in the shader
  position.y = Y_OFFSET + SIN_X_AMPLITUDE + cos (position.x*0.005)
    + SIN_Z_AMPLITUDE + cos (position.z*0.005*timePassed) * (i*float(100));

  
  // map world coordinate to screen coordinates
  gl_Position = transform * position;


  // use the color defined in the sketch    
    //vertColor = mix(color, vec4(i,0, 1, 1), vertex);
  /*  if(i <= 7)
        vertColor = color + vec4(i);
    else
        i = 0;*/
    vertColor = color;
}