import * as THREE from "three";
import { map } from "./Map";
import { renderer } from "./Renderer";
const tileSideGeometry = new THREE.PlaneGeometry(1, 1);
export class Tile {
    constructor(tileJson, x, y, z) {
        this.objectGroup = new THREE.Group();
        this.objectGroup.position.set(x, y, z);
        this.createStructure(tileJson);
        this.addToScene();
    }
    createStructure(tile) {
        if (tile.floorResourceId !== null) {
            const mesh = new THREE.Mesh(tileSideGeometry, map.materials[tile.floorResourceId]);
            mesh.position.set(0, -0.5, 0);
            mesh.rotation.x = -Math.PI / 2;
            this.objectGroup.add(mesh);
        }
        if (tile.ceilingResourceId !== null) {
            const mesh = new THREE.Mesh(tileSideGeometry, map.materials[tile.ceilingResourceId]);
            mesh.position.set(0, 0.5, 0);
            mesh.rotation.x = Math.PI / 2;
            this.objectGroup.add(mesh);
        }
        if (tile.wallResourceId !== null) {
            const material = map.materials[tile.wallResourceId];
            this.addWall(material, 0, 0, 0.5, 0);
            this.addWall(material, 0, 0, -0.5, Math.PI);
            this.addWall(material, 0.5, 0, 0, Math.PI / 2);
            this.addWall(material, -0.5, 0, 0, -Math.PI / 2);
        }
    }
    addWall(material, x, y, z, rotationY) {
        const mesh = new THREE.Mesh(tileSideGeometry, material);
        mesh.position.set(x, y, z);
        mesh.rotation.y = rotationY;
        this.objectGroup.add(mesh);
    }
    addToScene() {
        renderer.scene.add(this.objectGroup);
    }
}
//# sourceMappingURL=Tile.js.map