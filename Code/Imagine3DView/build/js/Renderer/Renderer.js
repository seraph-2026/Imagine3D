import * as THREE from "three";
import { CoordinateMapper } from "../Utilities/CoordinateMapper";
import { AngleMapper } from "../Utilities/AngleMapper";
import { view } from "../BrowserView/BrowserView";
export class Renderer {
    constructor() {
        console.log("Renderer");
        this.scene = new THREE.Scene();
        this.camera = new THREE.PerspectiveCamera(60, window.innerWidth / window.innerHeight, 0.1, 1000);
        this.renderer = new THREE.WebGLRenderer();
        this.renderer.setSize(window.innerWidth, window.innerHeight);
        this.renderer.domElement.style.transform = "scaleX(-1)";
        document.body.appendChild(this.renderer.domElement);
        console.log("- Succesfully constructured");
        console.log("- Awaiting signal to animate()");
    }
    animate() {
        this.setCameraPosition();
        this.renderer.render(this.scene, this.camera);
        requestAnimationFrame(() => this.animate());
    }
    setCameraPosition() {
        // Only run if we have the position data
        if (view.state.playerPixelLocation) {
            const playerPixelLoc = view.state.playerPixelLocation;
            const angle = playerPixelLoc.angle; // Degrees
            const byondCoord = CoordinateMapper.byondPixelToCoordinates(playerPixelLoc.x, playerPixelLoc.y, playerPixelLoc.z);
            const threeCoord = CoordinateMapper.byondToThree(byondCoord.x, byondCoord.y, byondCoord.z);
            this.camera.position.x = threeCoord.x + 1;
            this.camera.position.y = threeCoord.y;
            this.camera.position.z = threeCoord.z + 1;
            // Face camera to positive z and then add angle
            this.camera.rotation.y = AngleMapper.byondAngleToThree(angle);
        }
        else {
            this.camera.position.x = 0;
            this.camera.position.y = 0;
            this.camera.position.z = 0;
        }
    }
    requestPointerLock() {
        const canvas = this.renderer.domElement;
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