import * as THREE from "three";
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
        return new THREE.Vector3(bx / window.i3d.map.icon_size_x, by / window.i3d.map.icon_size_x, bz);
    }
}
//# sourceMappingURL=CoordinateMapper.js.map