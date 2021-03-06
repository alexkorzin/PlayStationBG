import * as THREE from 'three';
const OrbitControls = require('three-orbitcontrols');

import fragment from './planeFragment.glsl';
import vertex from './planeVertex.glsl';

import particlesFragment from './particlesFragment.glsl';
import particlesVertex from './particlesVertex.glsl';


// Renderer
const RENDERER = new THREE.WebGLRenderer({ antialias: true, alpha: true });
RENDERER.setSize(window.innerWidth, window.innerHeight);
document.querySelector('.container').appendChild(RENDERER.domElement);


// Scene
const SCENE = new THREE.Scene();
// SCENE.background = new THREE.Color( 0x0035ff );


// Camera
const CAMERA = new THREE.PerspectiveCamera(
  75,
  window.innerWidth / window.innerHeight,
  0.1,
  1000
);
CAMERA.position.z = 80;
CAMERA.aspect = window.innerWidth / window.innerHeight;
CAMERA.updateProjectionMatrix();

const CONTROL = new OrbitControls(CAMERA, RENDERER.domElement);

let time = 0;


//  Add Light
const light = new THREE.PointLight(0xFFFFFF, 1);
light.position.set(35, 35, 20);
SCENE.add(light);


// Add objects
const geometry = new THREE.PlaneGeometry(350, 60, 60, 40);



const particlesGeomntry = new THREE.PlaneGeometry(200,200);

const shaderMaterial = new THREE.ShaderMaterial({
  extensions: {
    derivatives: '#extension GL_OES_standard_derivatives : enable',
  },
  uniforms: {
    time: { type: 'f', value: 0.0 },
    colorScheme: { type: 'f', value: 1.0 },
  },
  vertexShader: vertex,
  fragmentShader: fragment,
  // wireframe: true,
  side: THREE.DoubleSide,
  transparent: true
});

const shaderParticlesMaterial = new THREE.ShaderMaterial({
  extensions: {
    derivatives: '#extension GL_OES_standard_derivatives : enable',
  },
  uniforms: {
    time: { type: 'f', value: 0.0 },
  },
  vertexShader: particlesVertex,
  fragmentShader: particlesFragment,
  // wireframe: true,
  side: THREE.DoubleSide,
  transparent: true
});


const meshParticles = new THREE.Mesh(particlesGeomntry, shaderParticlesMaterial);
meshParticles.position.z = 30;
SCENE.add(meshParticles);

const mesh = new THREE.Mesh(geometry, shaderMaterial);
mesh.position.y -= 5
SCENE.add(mesh);
mesh.rotation.x = -Math.PI / 2;

// Render loop
function render() {
  requestAnimationFrame(render);

  time++;
  shaderMaterial.uniforms.time.value = time;
  shaderParticlesMaterial.uniforms.time.value = time;
  geometry.verticesNeedUpdate = true;

  // geometry.vertices.forEach((v, i) => {
  //   v.z = Perlin(
  //     time / 1000 + v.x / 120 + v.y / 50,
  //     v.x / 80,
  //     v.y / 20) * 50;
  // })

  time++;
  CAMERA.updateProjectionMatrix();
  RENDERER.render(SCENE, CAMERA);
}

render();

// OnResize
window.addEventListener('resize', onWindowResize, false);
function onWindowResize() {
  RENDERER.setSize(window.innerWidth, window.innerHeight);
  CAMERA.aspect = window.innerWidth / window.innerHeight;
}