import { GlobalSettings } from "./GlobalSettings";
import { MapJson } from "./MapJson";
import { PlayerJson } from "./PlayerJson";

export type GameStateJson = {
    player: PlayerJson | null;
    map: MapJson | null;
    globalSettings: GlobalSettings | null;
};
