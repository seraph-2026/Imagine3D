import * as THREE from "three";
export class AngleMapper {
    /**
     * Convert BYOND angle Three.js angle
     */
    static byondAngleToThree(bx, by, bz) {
        return new THREE.Vector3(bx, bz, by);
    }
}
//# sourceMappingURL=CoordinateMapper%20copy.js.map