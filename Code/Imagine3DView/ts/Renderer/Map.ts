import * as THREE from "three";
import { view } from "../BrowserView/BrowserView";
import { MapJson } from "../JsonTypes/JsonMap";
import { TileJson } from "../JsonTypes/TileJson";
import { ResourceJson } from "../JsonTypes/ResourceJson";
import { CoordinateMapper } from "../Utilities/CoordinateMapper";
import { Tile } from "./Tile";

export class Map {
    icon_size_x!: number;
    icon_size_y!: number;
    icon_size_z!: number;

    maxX!: number;
    maxY!: number;
    maxZ!: number;

    tileIdMap!: number[][][];
    jsonTiles!: TileJson[];
    tiles!: Tile[][][];
    resources!: ResourceJson[];
    textures!: THREE.Texture[];
    materials!: THREE.MeshBasicMaterial[];

    isLoaded: boolean = false;

    constructor() {
        console.log("Map");
        console.log("- Succesfully constructured");
        console.log("- Awaiting to recieve JsonMap from BYOND (using view.state)");
        this.waitForJsonMapThenLoad();
    }

    private waitForJsonMapThenLoad(): void {
        if (!view.state.map) {
            setTimeout(() => this.waitForJsonMapThenLoad(), 10);
            return;
        }

        console.log("- Recieved JsonMap. Initializing Map");

        const mapJson: MapJson = view.state.map;

        this.tileIdMap = mapJson.tileIdMap;

        this.maxX = mapJson.tileIdMap.length;
        this.maxY = mapJson.tileIdMap[0].length;
        this.maxZ = mapJson.tileIdMap[0][0].length;

        this.icon_size_x = mapJson.icon_size_x;
        this.icon_size_y = mapJson.icon_size_y;

        this.jsonTiles = mapJson.tileMap.tiles;
        this.resources = mapJson.resourceMap.resources;

        this.textures = this.createTextures();
        this.materials = this.createMaterials();

        this.tiles = this.loadTiles();

        console.log("- Map initialized. isLoaded is true now.");
        this.isLoaded = true;
    }

    private createTextures(): THREE.Texture[] {
        return this.resources.map((resource) => {
            const texture = new THREE.TextureLoader().load(resource.png);

            texture.magFilter = THREE.NearestFilter;
            texture.minFilter = THREE.NearestFilter;

            return texture;
        });
    }

    private createMaterials(): THREE.MeshBasicMaterial[] {
        return this.textures.map((texture) => new THREE.MeshBasicMaterial({ map: texture }));
    }

    loadTiles(): Tile[][][] {
        const tileArray: Tile[][][] = [];

        for (let x = 0; x < this.tileIdMap.length; x++) {
            for (let y = 0; y < this.tileIdMap[x].length; y++) {
                for (let z = 0; z < this.tileIdMap[x][y].length; z++) {
                    const tileId = this.tileIdMap[x][y][z];
                    const tileJson = this.jsonTiles[tileId];

                    const position = CoordinateMapper.byondToThree(x, y, z);

                    tileArray[position.x] ??= [];
                    tileArray[position.x][position.y] ??= [];

                    tileArray[position.x][position.y][position.z] = new Tile(
                        tileJson,
                        position.x + 1,
                        position.y + 1,
                        position.z + 1,
                    );
                }
            }
        }
        return tileArray;
    }
}

export const map = new Map();

// Make it accessible in the console for debugging
window.map = map;
