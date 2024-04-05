/*
 * 3d.js
 *
 * Copyright (c) 2024 Thomas Buck (thomas@xythobuz.de)
 *
 * For the fitCameraToObject() function also:
 * Copyright (c) 2024 Michal Jirků
 * https://wejn.org/2020/12/cracking-the-threejs-object-fitting-nut/
 *
 * For everything else:
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * See <http://www.gnu.org/licenses/>.
 */

import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
import { STLLoader } from 'three/addons/loaders/STLLoader.js'
import { VRMLLoader } from 'three/addons/loaders/VRMLLoader.js';

function fitCameraToObject(camera, object, offset, orbitControls, yOffset) {
    const boundingBox = new THREE.Box3();
    boundingBox.setFromObject( object );

    var middle = new THREE.Vector3();
    boundingBox.getCenter(middle);

    var size = new THREE.Vector3();
    boundingBox.getSize(size);

    // figure out how to fit the box in the view:
    // 1. figure out horizontal FOV (on non-1.0 aspects)
    // 2. figure out distance from the object in X and Y planes
    // 3. select the max distance (to fit both sides in)
    //
    // The reason is as follows:
    //
    // Imagine a bounding box (BB) is centered at (0,0,0).
    // Camera has vertical FOV (camera.fov) and horizontal FOV
    // (camera.fov scaled by aspect, see fovh below)
    //
    // Therefore if you want to put the entire object into the field of view,
    // you have to compute the distance as: z/2 (half of Z size of the BB
    // protruding towards us) plus for both X and Y size of BB you have to
    // figure out the distance created by the appropriate FOV.
    //
    // The FOV is always a triangle:
    //
    //  (size/2)
    // +--------+
    // |       /
    // |      /
    // |     /
    // | F° /
    // |   /
    // |  /
    // | /
    // |/
    //
    // F° is half of respective FOV, so to compute the distance (the length
    // of the straight line) one has to: `size/2 / Math.tan(F)`.
    //
    // FTR, from https://threejs.org/docs/#api/en/cameras/PerspectiveCamera
    // the camera.fov is the vertical FOV.

    const fov = camera.fov * ( Math.PI / 180 );
    const fovh = 2*Math.atan(Math.tan(fov/2) * camera.aspect);
    let dx = size.z / 2 + Math.abs( size.x / 2 / Math.tan( fovh / 2 ) );
    let dy = size.z / 2 + Math.abs( size.y / 2 / Math.tan( fov / 2 ) );
    let cameraZ = Math.max(dx, dy);

    // offset the camera, if desired (to avoid filling the whole canvas)
    if( offset !== undefined && offset !== 0 ) cameraZ *= offset;

    camera.target = middle;
    camera.position.set( middle.x, middle.y + yOffset * cameraZ, middle.z + cameraZ );

    // set the far plane of the camera so that it easily encompasses the whole object
    const minZ = boundingBox.min.z;
    const cameraToFarEdge = ( minZ < 0 ) ? -minZ + cameraZ : cameraZ - minZ;

    camera.far = cameraToFarEdge * 3;
    camera.updateProjectionMatrix();

    if ( orbitControls !== undefined ) {
        // set camera to rotate around the center
        orbitControls.target = middle;

        // prevent camera from zooming out far enough to create far plane cutoff
        orbitControls.maxDistance = cameraToFarEdge * 2;
    }
}

export function init_3d(path, container, status, div_width, div_height) {
    const width = div_width;
    const height = div_height;

    const scene = new THREE.Scene();
    //scene.add(new THREE.AxesHelper(1));

    const camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000);

    const renderer = new THREE.WebGLRenderer({ antialias: true });
    renderer.setSize(width, height);

    const controls = new OrbitControls(camera, renderer.domElement);
    controls.enableDamping = true;
    controls.autoRotate = true;

    for (const i of [1, -1]) {
        for (const j of [0, 1, 2]) {
            const light = new THREE.DirectionalLight(0xffffff, 0.5);
            light.position.set(i * (j == 0 ? 1 : 0),
                                i * (j == 1 ? 1 : 0),
                                i * (j == 2 ? 1 : 0));
            scene.add(light);
        }
    }

    if (path.endsWith(".stl")) {
        const light_amb = new THREE.AmbientLight(0x424242);
        scene.add(light_amb);

        const material = new THREE.MeshStandardMaterial();
        //material.roughness = 0.75;

        const loader = new STLLoader();
        loader.load(
            path,
            function (geometry) {
                const mesh = new THREE.Mesh(geometry, material);
                mesh.rotation.setFromVector3(new THREE.Vector3(-Math.PI / 2, 0, 0));
                scene.add(mesh);
                fitCameraToObject(camera, scene, 0, controls, 0);
                controls.update();
                status.textContent = "Loaded STL 100%";
            },
            (xhr) => {
                const s = Math.floor((xhr.loaded / xhr.total) * 100) + '% loaded';
                console.log(s);
                status.textContent = s;
            },
            (error) => {
                console.log(error);
                status.textContent = error;
            }
        );
    } else if (path.endsWith(".wrl")) {
        const light_amb = new THREE.AmbientLight(0xffffff);
        scene.add(light_amb);

        const loader = new VRMLLoader();
        loader.load(
            path,
            function (object) {
                scene.add(object);
                fitCameraToObject(camera, scene, 0, controls, 0);
                controls.update();
                status.textContent = "Loaded VRML 100%";
            },
            (xhr) => {
                const s = Math.floor((xhr.loaded / xhr.total) * 100) + '% loaded';
                console.log(s);
                status.textContent = s;
            },
            (error) => {
                console.log(error);
                status.textContent = error;
            }
        );
    } else {
        const s = "error: unknown filetype for " + path;
        console.log(s);
        status.textContent = s;
    }

    camera.position.z = 50;
    controls.update();

    function animate() {
        requestAnimationFrame(animate);
        controls.update();
        renderer.render(scene, camera);
    }

    animate();
    status.textContent = "3D model ready!";

    container.appendChild(renderer.domElement);

    const div = document.createElement("div");
    div.style.position = "absolute";
    div.style.left = "5px";
    div.style.top = "5px";
    div.style.background = "white";
    div.style.color = "black";
    container.appendChild(div);

    const chk_ar = document.createElement("input");
    chk_ar.type = "checkbox";
    chk_ar.checked = true;
    chk_ar.addEventListener('change', function() {
        controls.autoRotate = this.checked;
    });

    const div_ar = document.createElement("div");
    div_ar.appendChild(chk_ar);
    div_ar.appendChild(document.createTextNode("Auto-Rotate"));
    div.appendChild(div_ar);

    const btn_rst = document.createElement("input");
    btn_rst.type = "button";
    btn_rst.value = "Reset Camera";
    btn_rst.addEventListener('click', function() {
        fitCameraToObject(camera, scene, 0, controls, 0);
        controls.update();
    });

    const div_rst = document.createElement("div");
    div_rst.appendChild(btn_rst);
    div.appendChild(div_rst);
}
