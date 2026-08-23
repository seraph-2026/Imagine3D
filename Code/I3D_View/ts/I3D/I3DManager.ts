import { Renderer } from "./Renderer/Renderer";
import { Map } from "./Game/Map";
import { StateManager } from "./State/StateManager";
import { TickLoop } from "./Network/TickLoop";

export class I3DManager {
    renderer: Renderer;
    map: Map;
    browserView: StateManager;
    tickLoop: TickLoop;

    constructor() {
        this.browserView = new StateManager();
        this.renderer = new Renderer();
        this.map = new Map(this.browserView);
        this.tickLoop = new TickLoop(this.browserView);
    }
}

export const manager = new I3DManager();

window.i3d = manager; // Make it accessible everywhere
