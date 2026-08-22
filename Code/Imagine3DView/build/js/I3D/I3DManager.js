import { Renderer } from "./Renderer/Renderer";
import { Map } from "./Game/Map";
export class I3DManager {
    constructor() {
        this.renderer = new Renderer();
        this.map = new Map();
    }
}
export const manager = new I3DManager();
window.i3d = manager; // Make it accessible everywhere
//# sourceMappingURL=I3DManager.js.map