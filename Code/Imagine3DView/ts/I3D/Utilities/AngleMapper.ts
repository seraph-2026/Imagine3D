import * as THREE from "three";

export class AngleMapper {
    /**
     * Convert BYOND angle Three.js angle
     */
    static byondAngleToThree(byondAngle: number): number {
        return THREE.MathUtils.degToRad((byondAngle % 360) - Math.PI / 2);
    }

    static threeAngleToByond(threeAngle: number): number {
        return THREE.MathUtils.radToDeg(threeAngle) + 90;
    }
}
