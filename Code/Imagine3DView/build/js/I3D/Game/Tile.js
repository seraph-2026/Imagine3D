import * as THREE from "three";
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
            const material = window.i3d.map.materials[tile.floorResourceId];
            const mesh = new THREE.Mesh(tileSideGeometry, material);
            mesh.position.set(0, -0.5, 0);
            mesh.rotation.x = -Math.PI / 2;
            this.objectGroup.add(mesh);
        }
        if (tile.ceilingResourceId !== null) {
            const material = window.i3d.map.materials[tile.ceilingResourceId];
            const mesh = new THREE.Mesh(tileSideGeometry, material);
            mesh.position.set(0, 0.5, 0);
            mesh.rotation.x = Math.PI / 2;
            this.objectGroup.add(mesh);
        }
        if (tile.wallResourceId !== null) {
            const material = window.i3d.map.materials[tile.wallResourceId];
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
        window.i3d.renderer.scene.add(this.objectGroup);
    }
}
//# sourceMappingURL=Tile.js.map