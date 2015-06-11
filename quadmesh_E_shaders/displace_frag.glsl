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
    int x = int(timePassed)/1;
    gl_FragColor = vertColor*vec4(x/6,x,5,1);

    
   // gl_FragColor = vec4 (gl_FragCoord.xyz*0.001,1*x);
   // gl_FragColor = mix(vec4 (gl_FragCoord.xyz*0.001,1), vertColor,1);
}