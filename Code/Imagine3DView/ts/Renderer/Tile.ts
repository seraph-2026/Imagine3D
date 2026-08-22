import * as THREE from "three";
import { map } from "./Map";
import { TileJson } from "../JsonTypes/TileJson";
import { i3d_renderer } from "./I3D_Renderer";

const tileSideGeometry = new THREE.PlaneGeometry(1, 1);

export class Tile {
    objectGroup: THREE.Group;

    constructor(tileJson: TileJson, x: number, y: number, z: number) {
        this.objectGroup = new THREE.Group();
        this.objectGroup.position.set(x, y, z);

        this.createStructure(tileJson);
        this.addToScene();
    }

    private createStructure(tile: TileJson): void {
        if (tile.floorResourceId !== null) {
            const material = map.materials[tile.floorResourceId];
            const mesh = new THREE.Mesh(tileSideGeometry, material);

            mesh.position.set(0, -0.5, 0);
            mesh.rotation.x = -Math.PI / 2;

            this.objectGroup.add(mesh);
        }

        if (tile.ceilingResourceId !== null) {
            const material = map.materials[tile.ceilingResourceId];
            const mesh = new THREE.Mesh(tileSideGeometry, material);

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

    private addWall(material: THREE.Material, x: number, y: number, z: number, rotationY: number): void {
        const mesh = new THREE.Mesh(tileSideGeometry, material);

        mesh.position.set(x, y, z);
        mesh.rotation.y = rotationY;

        this.objectGroup.add(mesh);
    }

    addToScene(): void {
        i3d_renderer.scene.add(this.objectGroup);
    }
}
