import * as THREE from "three";
import { map } from "../I3D/Renderer/I3D_Map";
export class CoordinateMapper {
    /**
     * Convert BYOND coordinates to Three.js coordinates.
     */
    static byondToThree(bx, by, bz) {
        return new THREE.Vector3(-bx, bz, -by);
    }
    /**
     * Convert Three.js coordinates to BYOND coordinates.
     */
    static threeToByond(tx, ty, tz) {
        return new THREE.Vector3(tx, ty, tz);
    }
    /**
     * Convert BYOND pixel location to BYOND coordinates
     */
    static byondPixelToCoordinates(bx, by, bz) {
        return new THREE.Vector3(bx / map.icon_size_x, by / map.icon_size_x, bz);
    }
}
//# sourceMappingURL=I3D_CoordinateMapper.js.map