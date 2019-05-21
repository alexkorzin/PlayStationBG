varying vec3 v_position;
varying vec2 vUv;
uniform float time;
uniform float colorScheme;
void main(void) {
  
	vec2 st = v_position.xy;

	// vec2 grid = abs(fract(st/4. - 0.5) - 0.5) / fwidth(st/4.);
  	// float color = min(grid.x, grid.y);
  	// gl_FragColor = vec4(1.,1.,1.,0.5 - color);

	float colorGreen = 0.0;
	float colorRed = 0.0;
	float colorBlue = 0.0;

	// Red
	if(colorScheme == 1.0){
		colorGreen = 0.15 + .2 -vUv.y;
		colorRed = 0.85;
		colorBlue = 0.3 + .2 -vUv.y;
	}

	// Blue
	if(colorScheme == 2.0){
		colorGreen = 0.6 - vUv.y - abs(sin(time/1000.))/10.;
		colorRed = 1.- vUv.y - 0.8;
		colorBlue = .9;
	}

	// Black
	if(colorScheme == 3.0){
		colorGreen = 1. - vUv.y/2. - 0.6;
		colorRed = 1. - vUv.y/2. - 0.6;
		colorBlue = 1. - vUv.y/2. - 0.6;
	}

  	gl_FragColor = vec4(colorRed, colorGreen, colorBlue,0.3);
}