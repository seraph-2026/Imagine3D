import { Renderer } from "./Renderer/Renderer";
import { Map } from "./Game/Map";
import { BrowserView } from "./BrowserView/BrowserView";
import { TickLoop } from "./Network/TickLoop";

export class I3DManager {
    renderer: Renderer;
    map: Map;
    browserView: BrowserView;
    tickLoop: TickLoop;

    constructor() {
        this.browserView = new BrowserView();
        this.renderer = new Renderer();
        this.map = new Map(this.browserView);
        this.tickLoop = new TickLoop(this.browserView);
    }
}

export const manager = new I3DManager();

window.i3d = manager; // Make it accessible everywhere
