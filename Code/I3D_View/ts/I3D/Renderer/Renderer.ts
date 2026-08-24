import * as THREE from "three";
import { CameraManager } from "./CameraManager";
import { StateManager } from "../State/StateManager";

export class Renderer {
    scene: THREE.Scene;
    threeRenderer: THREE.WebGLRenderer;
    stateManager: StateManager;
    cameraManager: CameraManager;

    constructor(stateManager: StateManager) {
        console.log("Renderer");

        this.scene = new THREE.Scene();
        this.stateManager = stateManager;
        const camera = new THREE.PerspectiveCamera(60, window.innerWidth / window.innerHeight, 0.1, 1000);
        this.cameraManager = new CameraManager(camera, stateManager);

        this.threeRenderer = new THREE.WebGLRenderer();

        this.threeRenderer.setSize(window.innerWidth, window.innerHeight);
        this.threeRenderer.domElement.style.transform = "scaleX(-1)";
        document.body.appendChild(this.threeRenderer.domElement);

        console.log("- Succesfully constructured");
        console.log("- Awaiting signal to animate()");
    }

    animate(): void {
        this.cameraManager.setCameraPosition();
        this.cameraManager.setCameraAngle();

        this.threeRenderer.render(this.scene, this.cameraManager.camera);

        requestAnimationFrame(() => this.animate());
    }

    requestPointerLock(): void {
        console.log("- Requesting pointer lock on canvas");
        const canvas: HTMLCanvasElement = this.threeRenderer.domElement;

        canvas.addEventListener("click", () => {
            canvas.requestPointerLock();
        });
    }

    resizeToFitScreen(): void {
        const resize = (): void => {
            this.threeRenderer.setSize(window.innerWidth, window.innerHeight);
        };

        window.addEventListener("resize", resize);
        resize();
    }
}
