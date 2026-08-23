import { TileJson } from "./TileJson";
import { ResourceJson } from "./ResourceJson";

export type MapJson = {
    icon_size_x: number;
    icon_size_y: number;

    tileIdMap: number[][][];

    tileMap: {
        tiles: TileJson[];
    };

    resourceMap: {
        resources: ResourceJson[];
    };
};
