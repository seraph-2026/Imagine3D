import * as THREE from "three";
import { map } from "../Renderer/Map";

export class CoordinateMapper {
    /**
     * Convert BYOND coordinates to Three.js coordinates.
     */
    static byondToThree(bx: number, by: number, bz: number): THREE.Vector3 {
        return new THREE.Vector3(-bx, bz, -by);
    }

    /**
     * Convert Three.js coordinates to BYOND coordinates.
     */
    static threeToByond(tx: number, ty: number, tz: number): THREE.Vector3 {
        return new THREE.Vector3(tx, ty, tz);
    }

    /**
     * Convert BYOND pixel location to BYOND coordinates
     */
    static byondPixelToCoordinates(bx: number, by: number, bz: number): THREE.Vector3 {
        return new THREE.Vector3(bx / map.icon_size_x, by / map.icon_size_x, bz);
    }
}
