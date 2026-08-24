import { Renderer } from "./Renderer/Renderer";
import { Map } from "./Game/Map";
import { StateManager } from "./State/StateManager";
import { TickLoop } from "./Network/TickLoop";

export class I3DManager {
    renderer: Renderer;
    map: Map;
    stateManager: StateManager;
    tickLoop: TickLoop;

    constructor() {
        this.stateManager = new StateManager();
        this.renderer = new Renderer(this.stateManager);
        this.map = new Map(this.stateManager);
        this.tickLoop = new TickLoop(this.stateManager);

        this.stateManager.setCameraManager(this.renderer.cameraManager);
    }
}

export const manager = new I3DManager();

window.i3d = manager; // Make it accessible everywhere
