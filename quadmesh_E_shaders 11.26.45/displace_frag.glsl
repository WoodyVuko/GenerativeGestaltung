#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform float timePassed;

/*
* The only thing that happens here is that the color, which comes
* from the vertex shader is interpolated to the fragments (aka screen pixels).
*/


varying vec4 vertColor;


void main() {
    // Blau 1 = 10 , 39, 255
    // Blau 2 = 8, 32, 212
    // Blau 3 = 17 , 149, 237
    // Blau 4 = 82, 183, 250
    
    int x = int(timePassed)/1;
    //gl_FragColor = vertColor*vec4(10,39,5,1);
    gl_FragColor = vertColor;
    
    //gl_FragColor = vec4 (gl_FragCoord.xyz*0.001,1*x);
   // gl_FragColor = mix(vec4 (gl_FragCoord.xyz*0.001,1), vertColor,1);
}