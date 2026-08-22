import * as THREE from "three";
import { CoordinateMapper } from "../Utilities/CoordinateMapper";
import { AngleMapper } from "../Utilities/AngleMapper";
import { view } from "../BrowserView/BrowserView";
import { CameraManager } from "./CameraSettings";

export class I3D_Renderer {
    cameraManager: CameraManager;
    scene: THREE.Scene;
    renderer: THREE.WebGLRenderer;

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

    animate(): void {
        this.cameraManager.setCameraPosition();
        this.cameraManager.setCameraAngle();

        this.renderer.render(this.scene, this.cameraManager.camera);

        requestAnimationFrame(() => this.animate());
    }

    requestPointerLock(): void {
        console.log("- Requesting pointer lock on canvas");
        const canvas: HTMLCanvasElement = i3d_renderer.renderer.domElement;

        canvas.addEventListener("click", () => {
            canvas.requestPointerLock();
        });
    }

    resizeToFitScreen(): void {
        const resize = (): void => {
            this.renderer.setSize(window.innerWidth, window.innerHeight);
        };

        window.addEventListener("resize", resize);
        resize();
    }
}

export const i3d_renderer = new I3D_Renderer();
