import * as THREE from "three";
import { CameraManager } from "./CameraManager";
export class Renderer {
    constructor() {
        console.log("Renderer");
        this.scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(60, window.innerWidth / window.innerHeight, 0.1, 1000);
        this.cameraManager = new CameraManager(camera);
        this.renderer = new THREE.WebGLRenderer();
        this.renderer.setSize(window.innerWidth, window.innerHeight);
        this.renderer.domElement.style.transform = "scaleX(-1)";
        document.body.appendChild(this.renderer.domElement);
        console.log("- Succesfully constructured");
        console.log("- Awaiting signal to animate()");
    }
    animate() {
        this.cameraManager.setCameraPosition();
        this.cameraManager.setCameraAngle();
        this.renderer.render(this.scene, this.cameraManager.camera);
        requestAnimationFrame(() => this.animate());
    }
    requestPointerLock() {
        console.log("- Requesting pointer lock on canvas");
        const canvas = renderer.renderer.domElement;
        canvas.addEventListener("click", () => {
            canvas.requestPointerLock();
        });
    }
    resizeToFitScreen() {
        const resize = () => {
            this.renderer.setSize(window.innerWidth, window.innerHeight);
        };
        window.addEventListener("resize", resize);
        resize();
    }
}
export const renderer = new Renderer();
//# sourceMappingURL=Renderer.js.map