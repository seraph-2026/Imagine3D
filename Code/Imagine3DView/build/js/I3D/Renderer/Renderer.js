import * as THREE from "three";
import { CameraManager } from "./CameraManager";
export class Renderer {
    constructor() {
        console.log("Renderer");
        this.scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(60, window.innerWidth / window.innerHeight, 0.1, 1000);
        this.cameraManager = new CameraManager(camera);
        this.threeRenderer = new THREE.WebGLRenderer();
        this.threeRenderer.setSize(window.innerWidth, window.innerHeight);
        this.threeRenderer.domElement.style.transform = "scaleX(-1)";
        document.body.appendChild(this.threeRenderer.domElement);
        console.log("- Succesfully const2ructured");
        console.log("- Awaiting signal to animate()");
    }
    animate() {
        this.cameraManager.setCameraPosition();
        this.cameraManager.setCameraAngle();
        this.threeRenderer.render(this.scene, this.cameraManager.camera);
        requestAnimationFrame(() => this.animate());
    }
    requestPointerLock() {
        console.log("- Requesting pointer lock on canvas");
        const canvas = this.threeRenderer.domElement;
        canvas.addEventListener("click", () => {
            canvas.requestPointerLock();
        });
    }
    resizeToFitScreen() {
        const resize = () => {
            this.threeRenderer.setSize(window.innerWidth, window.innerHeight);
        };
        window.addEventListener("resize", resize);
        resize();
    }
}
//# sourceMappingURL=Renderer.js.map