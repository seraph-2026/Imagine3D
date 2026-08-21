import * as THREE from "three";
export class AngleMapper {
    /**
     * Convert BYOND angle Three.js angle
     */
    static byondAngleToThree(byondAngle) {
        return THREE.MathUtils.degToRad((byondAngle % 360) - Math.PI / 2);
    }
}
//# sourceMappingURL=AngleMapper.js.map