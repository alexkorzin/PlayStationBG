varying vec2 vUv;
varying vec3 v_position;


void main() {
    vUv = uv;
    v_position = position.xyz;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}