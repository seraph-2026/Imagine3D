import * as THREE from "three";
import { CoordinateMapper } from "../Utilities/CoordinateMapper";
import { AngleMapper } from "../Utilities/AngleMapper";

export class CameraManager {
    camera: THREE.Camera;
    mouseLook: boolean;
    yaw: number;
    pitch: number;
    mouseSensitivity: number;
    mouseUpdateInterval: number;
    lastMouseUpdate: number;

    constructor(camera: THREE.Camera) {
        console.log("CameraManager");
        this.camera = camera;
        this.mouseLook = false;
        this.yaw = 0;
        this.pitch = 0;
        this.mouseSensitivity = 0.001;
        this.camera.rotation.order = "YXZ";
        this.lastMouseUpdate = 0;
        this.mouseUpdateInterval = 1000 / 60; // In milliseconds. Update with fps when we have it.
    }

    setCameraPosition(): void {
        // Only run if we have the position data
        if (window.view.state.pixelLoc) {
            const playerPixelLoc = window.view.state.pixelLoc;

            const byondCoord = CoordinateMapper.byondPixelToCoordinates(
                playerPixelLoc.x,
                playerPixelLoc.y,
                playerPixelLoc.z,
            );

            const threeCoord = CoordinateMapper.byondToThree(byondCoord.x, byondCoord.y, byondCoord.z);

            this.camera.position.x = threeCoord.x + 1;
            this.camera.position.y = threeCoord.y;
            this.camera.position.z = threeCoord.z + 1;
        } else {
            this.camera.position.x = 0;
            this.camera.position.y = 0;
            this.camera.position.z = 0;
        }
    }

    setCameraAngle(): void {
        if (this.mouseLook) {
            // If mouse look enabled, use the browser's mouse.
            this.camera.rotation.y = this.yaw;
            this.camera.rotation.x = this.pitch;
        } else {
            const angle = window.view.state.angle.angle; // Degrees
            // Otherwise, use the rotation angle we're given by BYOND
            this.camera.rotation.y = AngleMapper.byondAngleToThree(angle);
        }
    }

    enableMouseLook(): void {
        console.log("- Mouse look enabled");
        this.mouseLook = true;

        const canvas = window.i3d.renderer.threeRenderer.domElement;

        document.addEventListener("mousemove", (event) => {
            if (this.mouseLook && document.pointerLockElement === canvas) {
                let newYaw = this.yaw + event.movementX * this.mouseSensitivity;
                let newPitch = this.pitch - event.movementY * this.mouseSensitivity;

                // So you can't look so far up that you begin looking backwards. Math.PI / 2 (45* angle)
                const maxPitch = Math.PI / 2;
                newPitch = THREE.MathUtils.clamp(newPitch, -maxPitch, maxPitch);

                this.yaw = newYaw;
                this.pitch = newPitch;

                // Rate limit how often we send mouse updates to DM across the network
                const now = performance.now();

                if (now - this.lastMouseUpdate >= this.mouseUpdateInterval) {
                    this.lastMouseUpdate = now;

                    // Send yaw to DM (it doesn't have pitch)
                    const angle = window.view.state.angle;
                    angle.angle = AngleMapper.threeAngleToByond(this.yaw);
                    window.view.setState("angle", JSON.stringify(angle));
                }
            }
        });
    }
}
