varying vec3 v_position;
varying vec2 vUv;
void main(void) {
  
	vec2 st = v_position.xy;

	// vec2 grid = abs(fract(st/4. - 0.5) - 0.5) / fwidth(st/4.);
  	// float color = min(grid.x, grid.y);
  	// gl_FragColor = vec4(1.,1.,1.,1. - color);

  	gl_FragColor = vec4(1.-vUv.y - 0.5,1.-vUv.y - 0.5,0.9,0.35);
}