varying vec3 v_position;
varying vec2 vUv;
uniform float time;
uniform float colorScheme;
void main(void) {
  
	vec2 st = v_position.xy;

	// vec2 grid = abs(fract(st/4. - 0.5) - 0.5) / fwidth(st/4.);
  	// float color = min(grid.x, grid.y);
  	// gl_FragColor = vec4(1.,1.,1.,0.5 - color);

	float colorGreen = 0.3 + v_position.z / 60.;
	float colorRed = 0.3+ v_position.z / 60. ;
	float colorBlue = 0.3+ v_position.z / 60. ;

	float transparent = 0.3;
	

	// Red
	if(colorScheme == 1.0){
		colorRed = 0.85;
		colorGreen = 0.2 + v_position.z / 60.;
	}

	// Blue
	if(colorScheme == 2.0){
		colorBlue = 0.85;
		colorRed = 0.2+ v_position.z / 60.;
	}

	// Black
	if(colorScheme == 3.0){
		colorGreen = 0.3+ v_position.z / 60. ;
	}

  	gl_FragColor = vec4(colorRed, colorGreen, colorBlue, transparent);
}