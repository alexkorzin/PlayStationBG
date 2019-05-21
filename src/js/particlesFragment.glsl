varying vec3 v_position;
varying vec2 vUv;
uniform float time;

float rand2D(in vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float dotNoise2D(in float x, in float y, in float fractionalMaxDotSize, in float dDensity)
{
    float integer_x = x - fract(x);
    float fractional_x = x - integer_x;

    float integer_y = y - fract(y);
    float fractional_y = y - integer_y;

   	if (rand2D(vec2(integer_x+1.0, integer_y +1.0)) > dDensity)
      	{return 0.0;}

    float xoffset = (rand2D(vec2(integer_x, integer_y)) -0.5);
    float yoffset = (rand2D(vec2(integer_x+1.0, integer_y)) - 0.5);
    float dotSize = 0.5 * fractionalMaxDotSize * max(0.25,rand2D(vec2(integer_x, integer_y+1.0)));

   	vec2 truePos = vec2 (0.5 + xoffset * (1.0 - 2.0 * dotSize) , 0.5 + yoffset * (1.0 -2.0 * dotSize));

   	float distance = length(truePos - vec2(fractional_x, fractional_y));

   	return 1.0 - smoothstep (0.3 * dotSize, 1.0* dotSize, distance);

}
float DotNoise2D(in vec2 coord, in float wavelength, in float fractionalMaxDotSize, in float dDensity)
{
   return dotNoise2D(coord.x/wavelength, coord.y/wavelength, fractionalMaxDotSize, dDensity);
}

void main(void) {
    float color = DotNoise2D( vec2(vUv.x - time/10000., vUv.y) , 0.03, abs(sin(time/100.))/20., 0.3);
    gl_FragColor = vec4(1.,1.,1., color);
}